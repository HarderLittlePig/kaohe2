//
//  UITableView+EmptyData.m
//  考核2
//
//  Created by iOS 开发 on 2018/10/26.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "UITableView+EmptyData.h"

@implementation UITableView (EmptyData)

- (void)showEmptyDataView
{
    [self showEmptyDataViewWithTitle:@"暂无数据"];
}

- (void)showEmptyDataViewWithTitle:(NSString *)title
{
    UIView *backView = [[UIView alloc]initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor lightGrayColor];
    
    UIImage *image = [UIImage imageNamed:@"wildtoDefaulte"];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    imageView.frame = CGRectMake((self.width - image.size.width) / 2, 120, image.size.width, image.size.height);
    [backView addSubview:imageView];
    
//    CGSize title_size = [title sizeWithFont:[UIFont systemFontOfSize:14.0] maxW:self.width - 100];
    
    UILabel *label = [[UILabel alloc] init];
    label.x = 50;
    label.y = CGRectGetMaxY(imageView.frame) + 25;
    label.width = self.width - label.x * 2;
    label.height = 40;//title_size.height
    label.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14.0];
    label.backgroundColor = [UIColor clearColor];
    label.text = title;
    [backView addSubview:label];
    
    self.backgroundView = backView;
}

//清空占位图
- (void)clearPlaceholderView
{
    self.backgroundView = nil;
}

@end
