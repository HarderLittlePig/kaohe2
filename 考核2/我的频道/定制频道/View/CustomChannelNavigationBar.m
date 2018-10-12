//
//  CustomChannelNavigationBar.m
//  考核2
//
//  Created by iOS 开发 on 2018/10/9.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "CustomChannelNavigationBar.h"

@implementation CustomChannelNavigationBar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, kSCREENWIDTH, kNAVIGTAIONBARHEIGHT);
        self.backgroundColor = kWHITECOLOR;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1].CGColor;
        
        [self addView];
    }
    
    return self;
}

-(void)addView{
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat y = kSTATUSBARHEIGH + 7;
    _backButton.frame = CGRectMake(0, kSTATUSBARHEIGH, 37, self.height - kSTATUSBARHEIGH);
    _backButton.tintColor = kBLACKCOLOR;
    [_backButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backButton];

    _determineButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _determineButton.titleLabel.font = kFONT(15);
    _determineButton.frame = CGRectMake(self.width - 59, kSTATUSBARHEIGH, 59, self.height -kSTATUSBARHEIGH);
    [_determineButton setTitle:@"确定" forState:UIControlStateNormal];
    [_determineButton setTitleColor:[UIColor colorWithRed:237/255.0 green:49/255.0 blue:49/255.0 alpha:1] forState:UIControlStateNormal];
    [_determineButton addTarget:self action:@selector(determineAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_determineButton];
    
    CGFloat wid = self.width - _backButton.width - _determineButton.width;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(37,y,wid,30)];
    bgView.backgroundColor = [UIColor colorWithRed:243/255.0 green:246/255.0 blue:248/255.0 alpha:1];
    bgView.layer.cornerRadius = 15;
    [self addSubview:bgView];
    
    UIImageView *searchImg = [[UIImageView alloc]initWithFrame:CGRectMake(20, (bgView.height - 14)*0.5, 14, 14)];
    searchImg.image = [UIImage imageNamed:@"xwzx_ss"];
    [bgView addSubview:searchImg];
    
    _inputField = [[UITextField alloc]initWithFrame:CGRectMake(38, 0, bgView.width - 38 - 20, bgView.frame.size.height)];
    _inputField.font = [UIFont fontWithName:@"HiraginoSansGB-W3" size:15];
    _inputField.delegate = self;
    _inputField.placeholder = @"请输入关键字搜索行业";
    _inputField.tintColor = kBLACKCOLOR;
    _inputField.returnKeyType = UIReturnKeySearch;
    _inputField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_inputField addTarget:self action:@selector(valueChangedAction:) forControlEvents:UIControlEventEditingChanged];
    [bgView addSubview:_inputField];
}

//输入框获取到焦点
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([_delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [self.delegate textFieldDidBeginEditing:self];
    }
}

//实时获取输入内容
-(void)valueChangedAction:(UITextField *)textField{
    if ([_delegate respondsToSelector:@selector(searchBar:textDidChange:)]) {
        [self.delegate searchBar:self textDidChange:textField.text];
        
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
-(void)determineAction{
    self.determineBlock ? self.determineBlock() : nil;
}
@end
