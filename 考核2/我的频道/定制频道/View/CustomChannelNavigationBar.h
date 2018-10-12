//
//  CustomChannelNavigationBar.h
//  考核2
//
//  Created by iOS 开发 on 2018/10/9.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomChannelNavigationBar;
@protocol CustomChannelNavigationBarDelegate <NSObject>

@optional

//实时获取输入内容
- (void)searchBar:(CustomChannelNavigationBar *)searchBar textDidChange:(NSString *)searchText;

//输入框获取到焦点
- (void)textFieldDidBeginEditing:(CustomChannelNavigationBar *)searchBar;

//确定按钮
- (void)searchBarSearchButtonClicked:(CustomChannelNavigationBar *)searchBar;

@end


typedef void(^backBlock)(void);
typedef void(^determineBlock)(void);

@interface CustomChannelNavigationBar : UIView<UITextFieldDelegate>

@property(nonatomic,strong)UIButton *backButton;
@property(nonatomic,strong)UITextField *inputField;
@property(nonatomic,strong)UIButton *determineButton;

@property(nonatomic,copy)backBlock backBlock;
@property(nonatomic,copy)determineBlock determineBlock;

//设置代理
@property (nonatomic,weak)id<CustomChannelNavigationBarDelegate>delegate;
@end
