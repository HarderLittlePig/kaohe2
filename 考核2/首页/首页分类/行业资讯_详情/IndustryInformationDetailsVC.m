//
//  IndustryInformationDetailsVC.m
//  考核2
//
//  Created by iOS 开发 on 2018/10/16.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "IndustryInformationDetailsVC.h"
#import "IndustryInformationDetailsBottomView.h"
#import "IndustryInformationDetailsCell1.h"
#import "IndustryInformationDetailsCell2.h"

#import "InformationPersonalPageVC.h"

@interface IndustryInformationDetailsVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)UIView *line;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,weak)UIButton *userBtn;
@property(nonatomic,strong)NSMutableArray *array;
@end

@implementation IndustryInformationDetailsVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kWHITECOLOR;
    
    [self addBottomView];
    
    [self settingNacigationBar];
    
    [self.view addSubview:self.table];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, kNAVIGTAIONBARHEIGHT - kSTATUSBARHEIGH -1, kSCREENWIDTH, 1)];
    line.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar addSubview:line];
    self.line = line;
    
    self.array = @[@1,@2].mutableCopy;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IndustryInformationDetailsCell1 *cell1 = [IndustryInformationDetailsCell1 createCellWithTableView:tableView];
    IndustryInformationDetailsCell2 *cell2 = [IndustryInformationDetailsCell2 createCellWithTableView:tableView];
    [cell2.deleteBtn addTarget:self action:@selector(deleleRowAction) forControlEvents:UIControlEventTouchUpInside];
    if (indexPath.row == 0) {
        return cell1;
    }else{
        return cell2;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.table) {
        if (scrollView.contentOffset.y > 200) {
            self.line.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1];
            //
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"返回"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
            //
            UIButton *userBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            userBtn.titleLabel.font = kFONT(17);
            userBtn.hidden = NO;
            [userBtn setTitle:@"谈资天下" forState:UIControlStateNormal];
            [userBtn setTitleColor:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1] forState:UIControlStateNormal];
            [userBtn addTarget:self action:@selector(jumpPersonPageAction) forControlEvents:UIControlEventTouchUpInside];
            self.userBtn = userBtn;
            UIBarButtonItem *userItem = [[UIBarButtonItem alloc]initWithCustomView:userBtn];
            self.navigationItem.leftBarButtonItems = @[backItem,userItem];
            
            //分享
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"xwzx_details_fx_p"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(shareAction)];
        }else{
            [self settingNacigationBar];
            
            self.line.backgroundColor = [UIColor clearColor];
            self.userBtn.hidden = YES;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 870;
    }else{
        return 294+20;
    }
}

-(void)shareAction{
    [self.view makeToast:@"分享" duration:1.0f position:CSToastPositionCenter];
}

//删除广告
-(void)deleleRowAction{
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:0];
    [self.array removeLastObject];
    [self.table deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view makeToast:@"删除成功" duration:1 position:CSToastPositionCenter];
    });
}

-(void)jumpPersonPageAction{
    InformationPersonalPageVC *personal = [[InformationPersonalPageVC alloc]init];
    [self.navigationController pushViewController:personal animated:YES];
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)settingNacigationBar{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"xwzx_details_fh"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    //分享
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"xwzx_details_fx"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(shareAction)];
    
    self.navigationController.navigationBar.barTintColor = kWHITECOLOR;
    
    //去除UINavigationBar的黑线
    [[UINavigationBar appearance]setShadowImage:[UIImage new]];
    [[UINavigationBar appearance]setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}

-(void)addBottomView{
    IndustryInformationDetailsBottomView *bottomV = [[IndustryInformationDetailsBottomView alloc]init];
    [self.view addSubview:bottomV];
}

-(UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, kNAVIGTAIONBARHEIGHT, kSCREENWIDTH, kSCREENHEIGHT - kNAVIGTAIONBARHEIGHT - 52) style:UITableViewStylePlain];
        _table.tableFooterView = [[UIView alloc]init];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
    }
    return _table;
}

@end
