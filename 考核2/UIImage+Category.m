//
//  UIImage+Category.m
//  考核2
//
//  Created by iOS 开发 on 2018/10/25.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "UIImage+Category.h"

@implementation UIImage (Category)

/** 设置圆形图片(放到分类中使用) */

- (UIImage *)cutCircleImage {
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    // 获取上下文
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    
    // 设置圆形
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctr, rect);
    
    // 裁剪
    CGContextClip(ctr);
    
    // 将图片画上去
    [self drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)cutHeaderImage {
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(23, 23), NO, 0.0);
    
    // 获取上下文
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    
    // 设置圆形
    CGRect rect = CGRectMake(0, 0, 23, 23);
    CGContextAddEllipseInRect(ctr, rect);
    
    // 裁剪
    CGContextClip(ctr);
    
    // 将图片画上去
    [self drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
