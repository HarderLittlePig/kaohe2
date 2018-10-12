//
//  NavigationController.m
//  考核
//
//  Created by iOS 开发 on 2018/9/20.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation NavigationController

+ (void)initialize{
//    UINavigationBar *bar = [UINavigationBar appearance];
//    bar.tintColor = kWHITECOLOR;
//    bar.barTintColor = kREDCOLOR;
//    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName:kWHITECOLOR,NSFontAttributeName:kFONT(17)}];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
    self.interactivePopGestureRecognizer.enabled = YES;
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) {
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"top_return_arrow_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    return [super pushViewController:viewController animated:animated];
}
-(void)backAction{
    [self popViewControllerAnimated:YES];
}
@end
