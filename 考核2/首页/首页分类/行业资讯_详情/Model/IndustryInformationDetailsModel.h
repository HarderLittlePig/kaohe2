//
//  IndustryInformationDetailsModel.h
//  考核2
//
//  Created by iOS 开发 on 2018/10/23.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IndustryInformationDetailsModel : NSObject
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *userIcon;
@property(nonatomic,copy)NSString *userName;
@property(nonatomic,copy)NSString *time;
@property(nonatomic,copy)NSString *browseCount;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *dutyEditor;
@property(nonatomic,assign)CGFloat cellHeight;
@end
