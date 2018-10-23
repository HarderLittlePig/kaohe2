//
//  InformationDetailsSectionFooter.m
//  考核2
//
//  Created by iOS 开发 on 2018/10/23.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "InformationDetailsSectionFooter.h"

@implementation InformationDetailsSectionFooter

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, kSCREENWIDTH, 55);
        self.backgroundColor = kWHITECOLOR;
        
        UIButton *lookMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        lookMoreBtn.backgroundColor = kWHITECOLOR;
        [lookMoreBtn setTitle:@"查看更多" forState:UIControlStateNormal];
        [lookMoreBtn setTitleColor:[UIColor colorWithRed:157/255.0 green:167/255.0 blue:174/255.0 alpha:1] forState:UIControlStateNormal];
        lookMoreBtn.titleLabel.font = kFONT(13);
        lookMoreBtn.layer.cornerRadius = 13.5;
        lookMoreBtn.layer.masksToBounds = YES;
        lookMoreBtn.layer.borderColor = [UIColor colorWithRed:157/255.0 green:167/255.0 blue:174/255.0 alpha:1].CGColor;
        lookMoreBtn.layer.borderWidth = 1.0f;
        [lookMoreBtn addTarget:self action:@selector(lookMoreAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:lookMoreBtn];
        [lookMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(80*Iphone6ScaleWidth, 27*Iphone6ScaleHeight));
        }];
    }
    return self;
}
-(void)lookMoreAction{
    self.lookMoreBtn ? self.lookMoreBtn() : nil;
}
@end
