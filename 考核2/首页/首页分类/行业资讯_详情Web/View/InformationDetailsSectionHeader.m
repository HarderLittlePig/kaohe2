//
//  InformationDetailsSectionHeader.m
//  考核2
//
//  Created by iOS 开发 on 2018/10/23.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "InformationDetailsSectionHeader.h"

@implementation InformationDetailsSectionHeader

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, kSCREENWIDTH, 55);
        self.backgroundColor = kWHITECOLOR;
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.offset(0);
            make.height.offset(10);
        }];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = @"推荐阅读";
        label.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:17];
        label.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(30);
            make.height.offset(20);
            make.centerX.equalTo(self.mas_centerX);
        }];
        
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor colorWithRed:237/255.0 green:49/255.0 blue:49/255.0 alpha:1];
        view.layer.cornerRadius = 1;
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(label.mas_bottom).offset(7);
            make.height.offset(2);
            make.width.offset(25);
        }];
    }
    return self;
}
@end
