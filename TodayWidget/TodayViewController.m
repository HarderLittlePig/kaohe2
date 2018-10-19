//
//  TodayViewController.m
//  TodayWidget
//
//  Created by iOS 开发 on 2018/10/19.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [_noteList removeAllObjects];
    //    NSArray *myNote = [[[NSUserDefaults alloc] initWithSuiteName:@"group.todayextension.widget"] valueForKey:@"MyNote"];
    //    if (myNote) {
    //        [_noteList addObjectsFromArray:myNote];

    
    //创建一个共享的文件夹
//    NSURL *groupURL = [[NSFileManager defaultManager]  containerURLForSecurityApplicationGroupIdentifier: @"group.todayextension.widget"];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

@end
