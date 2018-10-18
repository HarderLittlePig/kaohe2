//
//  InformationPersonalPageHeaderView.m
//  考核2
//
//  Created by iOS 开发 on 2018/10/16.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "InformationPersonalPageHeaderView.h"

@implementation InformationPersonalPageHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, kSCREENWIDTH, 195);
        UIImageView *bgImage = [[UIImageView alloc]initWithFrame:self.bounds];
        bgImage.image = [UIImage imageNamed:@"xwzx_grzy_top_bg"];
        [self addSubview:bgImage];
        
        
        UIImageView *iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(kSCREENWIDTH*0.5-75*0.5, 98, 75, 75)];
        iconImage.image = [UIImage imageNamed:@"moment_pic_2"];
        iconImage.layer.cornerRadius = 75*0.5;
        iconImage.layer.masksToBounds = YES;
        [self addSubview:iconImage];
        
        UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumoToMyCollectionAction)];
        [iconImage addGestureRecognizer:tapG];
    }
    return self;
}

-(void)jumoToMyCollectionAction{
    [self.superview makeToast:@"点击了头像" duration:1.0f position:CSToastPositionCenter];
    
}
@end
