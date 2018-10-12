//
//  UIView+Category.h
//  有妖气漫画重构
//
//  Created by WYZC016 on 16/12/16.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Category)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

/** 从xib中创建一个控件 */
+ (instancetype)viewFromXib;
@end
