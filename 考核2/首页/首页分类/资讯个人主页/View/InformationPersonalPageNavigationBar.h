//
//  InformationPersonalPageNavigationBar.h
//  考核2
//
//  Created by iOS 开发 on 2018/10/16.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^backBlock)(void);

@interface InformationPersonalPageNavigationBar : UIView
@property(nonatomic,strong)UIButton *backButton;
@property(nonatomic,strong)UIImageView *bgView;
@property(nonatomic,copy)backBlock backBlock;

@end
