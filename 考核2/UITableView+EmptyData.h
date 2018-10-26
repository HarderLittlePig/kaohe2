//
//  UITableView+EmptyData.h
//  考核2
//
//  Created by iOS 开发 on 2018/10/26.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (EmptyData)

//展示空数据
- (void)showEmptyDataView;
- (void)showEmptyDataViewWithTitle:(NSString *)title;

//清空占位图
- (void)clearPlaceholderView;

@end
