//
//  CustomChannelAlertView.m
//  考核2
//
//  Created by iOS 开发 on 2018/10/9.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "CustomChannelAlertView.h"

@implementation CustomChannelAlertView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [kBLACKCOLOR colorWithAlphaComponent:0.6f];
        self.frame = kSCREENBOUNDS;
        
        UIView *bgView = [[UIView alloc]init];
        bgView.backgroundColor = kWHITECOLOR;
        bgView.layer.cornerRadius = 8;
        [self addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.offset(15);
            make.right.offset(-15);
            // * Iphone6ScaleHeight
            make.height.offset(226);
        }];
        self.bgView = bgView;
        bgView.transform = CGAffineTransformMakeScale(0.3, 0.3);
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.6 options:UIViewAnimationOptionOverrideInheritedCurve animations:^{
            bgView.transform = CGAffineTransformIdentity;
        } completion:nil];
        
        UILabel *promotLab = [[UILabel alloc]init];
        promotLab.text = @"为这些行业创建一个标签吧";
        promotLab.font = kFONT(16);
        promotLab.textAlignment = NSTextAlignmentCenter;
        promotLab.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        [bgView addSubview:promotLab];
        [promotLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.offset(0);
            make.height.offset(50);
        }];
        
        
        UIView *lineView1 = [[UIView alloc]init];
        lineView1.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1];
        [bgView addSubview:lineView1];
        [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(50);
            make.left.right.offset(0);
            make.height.offset(0.5);
        }];
        
        UITextField *inputField = [[UITextField alloc]init];
        inputField.placeholder = @"输入名字，1-3个字";
        inputField.tintColor = kBLACKCOLOR;
        inputField.font = kFONT(15);
        inputField.delegate = self;
        inputField.backgroundColor = [UIColor colorWithRed:243/255.0 green:246/255.0 blue:248/255.0 alpha:1];
        inputField.layer.cornerRadius = 5;
        inputField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [bgView addSubview:inputField];
        [inputField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(bgView.mas_centerY);
            make.left.offset(15);
            make.right.offset(-15);
            make.height.offset(50);
        }];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelBtn setTitle:@"取 消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = kFONT(16);
        cancelBtn.layer.borderWidth = 0.5;
        [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.offset(0);
            make.size.mas_equalTo(CGSizeMake((kSCREENWIDTH - 30) * 0.5, 45));
        }];
        
        UIButton *determineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [determineBtn setTitle:@"确 定" forState:UIControlStateNormal];
        [determineBtn setTitleColor:[UIColor colorWithRed:219/255.0 green:49/255.0 blue:23/255.0 alpha:1] forState:UIControlStateNormal];
        determineBtn.titleLabel.font = kFONT(16);
        determineBtn.layer.borderWidth = 0.5;
        [determineBtn addTarget:self action:@selector(determineAction) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:determineBtn];
        [determineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.offset(0);
            make.size.mas_equalTo(CGSizeMake((kSCREENWIDTH - 30) * 0.5, 45));
        }];
        
        UIView *lineView2 = [[UIView alloc]init];
        lineView2.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1];
        [bgView addSubview:lineView2];
        [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.offset(-45);
            make.left.right.offset(0);
            make.height.offset(0.5);
        }];
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self determineAction];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY).offset(-226 * 0.25);
    }];
}
-(void)determineAction{
    
}

-(void)cancelAction{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.bgView.transform = CGAffineTransformMakeScale(0.2, 0.2);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    if (touch.view == self) {
        [self cancelAction];
    }
}
@end
