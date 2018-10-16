//
//  InformationPersonalPageVC.m
//  考核2
//
//  Created by iOS 开发 on 2018/10/16.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "InformationPersonalPageVC.h"
#import "InformationPersonalPageNavigationBar.h"
#import "InformationPersonalPageHeaderView.h"
#import "InformationPersonalPageSectionView.h"

#import "InformationPersonalPageCell1.h"

@interface InformationPersonalPageVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,weak)InformationPersonalPageNavigationBar *bar;
@end

@implementation InformationPersonalPageVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWHITECOLOR;
    
    [self.view addSubview:self.table];
    
    InformationPersonalPageHeaderView *header = [[InformationPersonalPageHeaderView alloc]initWithFrame:CGRectZero];
    self.table.tableHeaderView = header;
    
    //注意子控件的添加顺序
    [self addNavigationBar];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    InformationPersonalPageSectionView *secV = [[InformationPersonalPageSectionView alloc]initWithFrame:CGRectZero];
    return secV;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 90;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    InformationPersonalPageCell1 *cell1 = [InformationPersonalPageCell1 createCellWithTableView:tableView];
    cell1.title.text = @"洗衣机";
    return cell1;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.table) {
        if (scrollView.contentOffset.y < 200) {
            self.bar.bgView.alpha = scrollView.contentOffset.y / 200;
        }else{
            self.bar.bgView.alpha = 1;
        }
    }
}

-(void)addNavigationBar{
    InformationPersonalPageNavigationBar *bar = [[InformationPersonalPageNavigationBar alloc]initWithFrame:CGRectZero];
    bar.backBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    [self.view addSubview:bar];
    [self.view bringSubviewToFront:bar];
    self.bar = bar;
}

-(UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, -kSTATUSBARHEIGH, kSCREENWIDTH, kSCREENHEIGHT+kSTATUSBARHEIGH) style:UITableViewStyleGrouped];
        _table.tableFooterView = [[UIView alloc]init];
        _table.delegate = self;
        _table.dataSource = self;
        _table.rowHeight = 120;
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _table;
}
@end
