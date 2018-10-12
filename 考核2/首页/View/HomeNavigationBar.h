//
//  HomeNavigationBar.h
//  考核2
//
//  Created by iOS 开发 on 2018/9/30.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeNavigationBar;

@protocol HomeNavigationBarDelegate <NSObject>

@optional

//输入框获取到焦点
- (void)textFieldDidBeginEditing:(HomeNavigationBar *)searchBar;
//确定按钮
- (void)searchBarSearchButtonClicked:(HomeNavigationBar *)searchBar;

@end

typedef void(^backBlock)(void);
typedef void(^classBlock)(void);

@interface HomeNavigationBar : UIView<UITextFieldDelegate>
@property(nonatomic,strong)UIButton *backButton;
@property(nonatomic,strong)UITextField *inputField;
@property(nonatomic,strong)UIButton *classButton;

@property(nonatomic,copy)backBlock backBlock;
@property(nonatomic,copy)classBlock classBlock;

//设置代理
@property (nonatomic,weak)id<HomeNavigationBarDelegate>delegate;
@end
