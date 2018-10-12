//
//  HomeNavigationBar.m
//  考核2
//
//  Created by iOS 开发 on 2018/9/30.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "HomeNavigationBar.h"

@implementation HomeNavigationBar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, kSCREENWIDTH, kNAVIGTAIONBARHEIGHT);
        self.backgroundColor = [UIColor colorWithRed:219/255.0 green:49/255.0 blue:0/255.0 alpha:1];
        [self addView];
    }
    return self;
}

-(void)addView{
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat y = kSTATUSBARHEIGH + 7;
    _backButton.frame = CGRectMake(0, kSTATUSBARHEIGH, 37, self.height - kSTATUSBARHEIGH);
    [_backButton setImage:[UIImage imageNamed:@"top_return_arrow_n"] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backButton];
    
    _classButton = [[UIButton alloc]init];
    _classButton.titleLabel.font = kFONT(9);
    
    // button标题的偏移量
    _classButton.titleEdgeInsets = UIEdgeInsetsMake(_classButton.imageView.frame.size.height+5, -_classButton.imageView.bounds.size.width, 0,0);
    // button图片的偏移量
    _classButton.imageEdgeInsets = UIEdgeInsetsMake(0, _classButton.titleLabel.frame.size.width/2, _classButton.titleLabel.frame.size.height+5, -_classButton.titleLabel.frame.size.width/2);
    
    
    _classButton.frame = CGRectMake(self.width - 37, kSTATUSBARHEIGH, 37, self.height -kSTATUSBARHEIGH);
    [_classButton setImage:[UIImage imageNamed:@"xwzx_fl"] forState:UIControlStateNormal];
    [_classButton setTitle:@"分类" forState:UIControlStateNormal];
    [_classButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_classButton addTarget:self action:@selector(classAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_classButton];
    
    CGFloat wid = self.width - _backButton.width - _classButton.width;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(37,y,wid,30)];
    bgView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    bgView.layer.cornerRadius = 15;
    [self addSubview:bgView];
    
    UIImageView *searchImg = [[UIImageView alloc]initWithFrame:CGRectMake(20, (bgView.height - 14)*0.5, 14, 14)];
    searchImg.image = [UIImage imageNamed:@"xwzx_ss"];
    [bgView addSubview:searchImg];

    _inputField = [[UITextField alloc]initWithFrame:CGRectMake(38, 0, bgView.width - 38 - 20, bgView.frame.size.height)];
    _inputField.font = kFONT(15);
    _inputField.returnKeyType = UIReturnKeySearch;
    _inputField.placeholder = @"请输入关键字";
    _inputField.tintColor = kBLACKCOLOR;
    _inputField.delegate = self;
    _inputField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [bgView addSubview:_inputField];
}

//输入框获取到焦点
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([_delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [self.delegate textFieldDidBeginEditing:self];
    }
}

//确定按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([_delegate respondsToSelector:@selector(searchBarSearchButtonClicked:)]) {
        [self.delegate searchBarSearchButtonClicked:self];
    }
    return YES;
}

-(void)backAction{
    self.backBlock ? self.backBlock() : nil;
}
-(void)classAction{
    self.classBlock ? self.classBlock() : nil;
}
@end
