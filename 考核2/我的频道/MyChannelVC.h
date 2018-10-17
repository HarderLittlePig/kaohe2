//
//  MyChannelVC.h
//  考核2
//
//  Created by iOS 开发 on 2018/9/30.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChangeChannelBlock)(NSInteger index);
@interface MyChannelVC : UIViewController
@property(nonatomic,copy)ChangeChannelBlock changeChannelBlock;
@end
