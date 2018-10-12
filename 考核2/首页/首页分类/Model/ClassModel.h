//
//  ClassModel.h
//  考核2
//
//  Created by iOS 开发 on 2018/10/8.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassModel : NSObject

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *lookCount;
@property(nonatomic,copy)NSString *publishTime;
@property(nonatomic,strong)NSArray *imageArray;
//是否置顶
@property(nonatomic,assign)BOOL isTopping;
//是否热门
@property(nonatomic,assign)BOOL isPopular;
//是否大图
@property(nonatomic,assign)BOOL isLargePicture;
//是否广告
@property(nonatomic,assign)BOOL isAd;

@end
