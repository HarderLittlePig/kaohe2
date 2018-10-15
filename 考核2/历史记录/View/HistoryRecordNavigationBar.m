//
//  HistoryRecordNavigationBar.m
//  考核2
//
//  Created by iOS 开发 on 2018/10/9.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "HistoryRecordNavigationBar.h"

@implementation HistoryRecordNavigationBar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, kSCREENWIDTH, kNAVIGTAIONBARHEIGHT);
        self.backgroundColor = kWHITECOLOR;
        self.layer.borderWidth = 0.5;
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
    
    
    CGFloat wid = self.width - _backButton.width-20;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(37,y,wid,30)];
    bgView.backgroundColor = [UIColor colorWithRed:243/255.0 green:246/255.0 blue:248/255.0 alpha:1];
    bgView.layer.cornerRadius = 15;
    [self addSubview:bgView];
    
    UIImageView *searchImg = [[UIImageView alloc]initWithFrame:CGRectMake(20, (bgView.height - 14)*0.5, 14, 14)];
    searchImg.image = [UIImage imageNamed:@"xwzx_ss"];
    [bgView addSubview:searchImg];
    
    _inputField = [[UITextField alloc]initWithFrame:CGRectMake(38, 0, bgView.width - 38 - 20, bgView.frame.size.height)];
    _inputField.font = kFONT(15);
    _inputField.delegate = self;
    _inputField.returnKeyType = UIReturnKeySearch;
    _inputField.placeholder = @"油气回收装置";
    _inputField.tintColor = kBLACKCOLOR;
    _inputField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [bgView addSubview:_inputField];
    
}

//输入框获取到焦点
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([_delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [self.delegate textFieldDidBeginEditing:self];
    }
}

//- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    if ([_delegate respondsToSelector:@selector(searchBarSearchButtonClicked:)]) {
//        [self.delegate searchBarSearchButtonClicked:self];
//    }
//    return YES;
//}

-(void)backAction{
    self.backBlock ? self.backBlock() : nil;
}
@end
