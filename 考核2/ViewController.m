//
//  ViewController.m
//  考核2
//
//  Created by iOS 开发 on 2018/9/30.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "ViewController.h"
#import "HomeVC.h"

@interface ViewController ()
@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    HomeVC *h = [[HomeVC alloc]init];
    [self.navigationController pushViewController:h animated:YES];
}
@end
