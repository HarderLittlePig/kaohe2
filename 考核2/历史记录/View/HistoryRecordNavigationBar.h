//
//  HistoryRecordNavigationBar.h
//  考核2
//
//  Created by iOS 开发 on 2018/10/9.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HistoryRecordNavigationBar;

@protocol HistoryRecordNavigationBarDelegate <NSObject>

@optional

- (void)searchBarSearchButtonClicked:(HistoryRecordNavigationBar *)searchBar;//确定按钮
@end


typedef void(^backBlock)(void);
@interface HistoryRecordNavigationBar : UIView

@property(nonatomic,strong)UIButton *backButton;
@property(nonatomic,strong)UITextField *inputField;
@property(nonatomic,copy)backBlock backBlock;

//设置代理
@property (nonatomic,weak)id<HistoryRecordNavigationBarDelegate>delegate;
@end
