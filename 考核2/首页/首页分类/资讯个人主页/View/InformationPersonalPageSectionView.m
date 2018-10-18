//
//  InformationPersonalPageSectionView.m
//  考核2
//
//  Created by iOS 开发 on 2018/10/16.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "InformationPersonalPageSectionView.h"

@implementation InformationPersonalPageSectionView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kWHITECOLOR;
        
        self.frame = CGRectMake(0, 0, kSCREENWIDTH, 90);
        UILabel *userName = [[UILabel alloc]init];
        userName.text = @"谭宗明";
        userName.font = kFONT(18);
        userName.textColor = [UIColor colorWithRed:22/255.0 green:26/255.0 blue:36/255.0 alpha:1];
        [self addSubview:userName];
        [userName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(2);
            make.centerX.equalTo(self.mas_centerX);
        }];
        
        UIView *separatorV = [[UIView alloc] init];
        separatorV.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];;
        [self addSubview:separatorV];
        [separatorV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.offset(0);
            make.height.offset(10);
        }];
        
        UIView *lineV = [[UIView alloc] init];
        lineV.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1];
        [self addSubview:lineV];
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(1, 15));
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(separatorV.mas_top).offset(-16);
        }];
        
        
        UILabel *totalViews = [[UILabel alloc]init];
        totalViews.text = @"总浏览量：12:23万";
        totalViews.font = kFONT(13);
        totalViews.textColor = [UIColor colorWithRed:139/255.0 green:150/255.0 blue:158/255.0 alpha:1];
        [self addSubview:totalViews];
        [totalViews mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(lineV.mas_left).offset(-30);
            make.bottom.equalTo(separatorV.mas_top).offset(-16);
        }];
        
        UILabel *articles = [[UILabel alloc]init];
        articles.text = @"文章：12篇";
        articles.font = kFONT(13);
        articles.textColor = [UIColor colorWithRed:139/255.0 green:150/255.0 blue:158/255.0 alpha:1];
        [self addSubview:articles];
        [articles mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lineV.mas_right).offset(30);
            make.bottom.equalTo(separatorV.mas_top).offset(-16);
        }];
        
        
        
    }
    return self;
}

@end
