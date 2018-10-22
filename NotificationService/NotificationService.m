//
//  NotificationService.m
//  NotificationService
//
//  Created by iOS 开发 on 2018/10/22.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "NotificationService.h"

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService

-(void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    //[modified]这个是一个标示，可以实现对服务器下发下来的内容进行更改
    self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [modified]", self.bestAttemptContent.title];//注意：可以用来测试项目是否调用了notification service
     
    NSDictionary *apsDic = [request.content.userInfo objectForKey:@"aps"];
    NSString *attachUrl = [apsDic objectForKey:@"image"];
     
    NSString *category = [apsDic objectForKey:@"category"];
    self.bestAttemptContent.categoryIdentifier = category;
     
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:attachUrl];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url
                                                        completionHandler:^(NSURL * _Nullable location,
                                                                            NSURLResponse * _Nullable response,
                                                                            NSError * _Nullable error) {
                                                            NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
                                                            NSString *file = [caches stringByAppendingPathComponent:response.suggestedFilename];
                                                            NSFileManager *mgr = [NSFileManager defaultManager];
                                                            [mgr moveItemAtPath:location.path toPath:file error:nil];
                                                             
                                                            if (file && ![file  isEqualToString: @""])
                                                            {
                                                                UNNotificationAttachment *attch= [UNNotificationAttachment attachmentWithIdentifier:@"photo"
                                                                                                                                                URL:[NSURL URLWithString:[@"file://" stringByAppendingString:file]]
                                                                                                                                            options:nil
                                                                                                                                              error:nil];
                                                                if(attch)
                                                                {
                                                                    self.bestAttemptContent.attachments = @[attch];
                                                                }
                                                            }
                                                            self.contentHandler(self.bestAttemptContent);
                                                        }];
    [downloadTask resume];
     
}

 /*
  {
  "appkey":"your appkey",
  "production_mode":"false",
  "timestamp":1474340669558,
  "device_tokens":"your devicetoken",
  "type":"unicast",
  "payload":{
  "aps":{
  "mutable-content":1,
  "badge":1,
  "alert":{
  "body":"hello this is body",
  "subtitle":"hello title",
  "title":"hello this is subtitle"
  },
  "image":"https://dev.umeng.com/system/resources/W1siZiIsIjIwMTYvMDkvMjAvMTFfMzhfMzhfMTFfcHVzaC5wbmciXV0/push.png"
  }
  }
  }
  */

//- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
//    self.contentHandler = contentHandler;
//    self.bestAttemptContent = [request.content mutableCopy];
//
//    // Modify the notification content here...
//    self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [modified]", self.bestAttemptContent.title];
//
//    self.contentHandler(self.bestAttemptContent);
//}



- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}

@end
