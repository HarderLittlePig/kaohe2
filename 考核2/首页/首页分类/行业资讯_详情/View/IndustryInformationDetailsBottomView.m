//
//  IndustryInformationDetailsBottomView.m
//  考核2
//
//  Created by iOS 开发 on 2018/10/16.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "IndustryInformationDetailsBottomView.h"

@implementation IndustryInformationDetailsBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, kSCREENHEIGHT - 52, kSCREENWIDTH, 52);
        
        UIButton *industryVoteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        industryVoteBtn.adjustsImageWhenHighlighted = NO;
        [industryVoteBtn setImage:[UIImage imageNamed:@"xwzx_details_hytp"] forState:UIControlStateNormal];
        [industryVoteBtn addTarget:self action:@selector(industryVoteAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:industryVoteBtn];
        [industryVoteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(9);
            make.top.offset(3);
            make.bottom.offset(-3);
            make.width.offset(140 * Iphone6ScaleWidth);
        }];
        
        UIButton *collectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        collectionBtn.titleLabel.font = kFONT(13);
        [collectionBtn setImage:[UIImage imageNamed:@"xwzx_details_sc"] forState:UIControlStateNormal];
        [collectionBtn setTitle:@" 收藏" forState:UIControlStateNormal];
        [collectionBtn setImage:[UIImage imageNamed:@"xwzx_details_sc_p"] forState:UIControlStateSelected];
        [collectionBtn setTitle:@" 已收藏" forState:UIControlStateSelected];
        [collectionBtn setTitleColor:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1] forState:UIControlStateNormal];
        [collectionBtn addTarget:self action:@selector(collectionAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:collectionBtn];
        [collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-9);
            make.top.offset(8);
            make.bottom.offset(-8);
            make.width.offset(70 * Iphone6ScaleWidth);
        }];
        
        UIButton *likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        likeBtn.titleLabel.font = kFONT(13);
        [likeBtn setImage:[UIImage imageNamed:@"xwzx_details_dz"] forState:UIControlStateNormal];
        [likeBtn setTitle:@" 123" forState:UIControlStateNormal];
        [likeBtn setImage:[UIImage imageNamed:@"xwzx_details_dz_p"] forState:UIControlStateSelected];
        [likeBtn setTitle:@" 124" forState:UIControlStateSelected];
        [likeBtn setTitleColor:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1] forState:UIControlStateNormal];
        [likeBtn addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:likeBtn];
        [likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(collectionBtn.mas_left).offset(-20);
            make.top.offset(8);
            make.bottom.offset(-8);
            make.width.offset(70 * Iphone6ScaleWidth);
        }];
    }
    return self;
}
-(void)industryVoteAction{
    [self.superview makeToast:@"行业投票" duration:1 position:CSToastPositionCenter];
}
-(void)likeAction:(UIButton *)sender{
    sender.selected = !sender.selected;
}
-(void)collectionAction:(UIButton *)sender{
    sender.selected = !sender.selected;
}
@end
