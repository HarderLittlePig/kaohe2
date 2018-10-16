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


#import "InformationPersonalPageVC.h"

@interface IndustryInformationDetailsVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)UIView *line;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,weak)UIButton *userBtn;
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
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IndustryInformationDetailsCell1 *cell1 = [IndustryInformationDetailsCell1 createCellWithTableView:tableView];
    
    return cell1;
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

-(void)shareAction{
    [self.view makeToast:@"分享" duration:1.0f position:CSToastPositionCenter];
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
        _table.rowHeight = 800;
    }
    return _table;
}

@end
