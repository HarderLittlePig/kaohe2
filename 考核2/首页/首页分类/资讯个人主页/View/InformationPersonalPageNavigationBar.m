//
//  InformationPersonalPageNavigationBar.m
//  考核2
//
//  Created by iOS 开发 on 2018/10/16.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "InformationPersonalPageNavigationBar.h"

@implementation InformationPersonalPageNavigationBar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, kSCREENWIDTH, kNAVIGTAIONBARHEIGHT);
        self.backgroundColor = [UIColor clearColor];
        
        UIImageView *bgView = [[UIImageView alloc]initWithFrame:self.bounds];
        bgView.alpha = 0;
        bgView.userInteractionEnabled = YES;
        bgView.image = [UIImage imageNamed:@"top_navigation_bg"];
        [self addSubview:bgView];
        self.bgView = bgView;
        
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(0, kSTATUSBARHEIGH, 37, self.height - kSTATUSBARHEIGH);
        [_backButton setImage:[[UIImage imageNamed:@"top_return_arrow_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_backButton];
        
        
        UILabel *userName = [[UILabel alloc]init];
        userName.text = @"谭宗明";
        userName.font = kFONT(18);
        userName.textColor = [UIColor colorWithRed:22/255.0 green:26/255.0 blue:36/255.0 alpha:1];
        [bgView addSubview:userName];
        [userName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.offset(kSTATUSBARHEIGH);
            make.height.offset(kNAVIGTAIONBARHEIGHT - kSTATUSBARHEIGH);
        }];
    }
    return self;
}

-(void)backAction{
    self.backBlock ? self.backBlock() : nil;
}
@end
