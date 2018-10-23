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
#import "InformationPersonalPageCell2.h"
#import "InformationPersonalPageCell3.h"
#import "InformationPersonalPageCell4.h"

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
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            return 112 + 30;
            break;
        case 1:
            return 181+30;
            break;
        case 2:
            return 102+30;
            break;
        case 3:
            return 284+30;
            break;
            
        default:
            break;
    }
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    InformationPersonalPageCell1 *cell1 = [InformationPersonalPageCell1 createCellWithTableView:tableView];
    InformationPersonalPageCell2 *cell2 = [InformationPersonalPageCell2 createCellWithTableView:tableView];
    InformationPersonalPageCell3 *cell3 = [InformationPersonalPageCell3 createCellWithTableView:tableView];
    InformationPersonalPageCell4 *cell4 = [InformationPersonalPageCell4 createCellWithTableView:tableView];
    
    
    cell1.title.text = @"杨贵妃没有死？去了日本还有后代！日本女星拿出家谱证明！";
    cell2.title.text = @"杨贵妃没有死？去了日本还有后代！日本女星拿出家谱证明！";
    cell3.title.text = @"杨贵妃没有死？去了日本还有后代！日本女星拿出家谱证明！";
    cell4.title.text = @"杨贵妃没有死？去了日本还有后代！日本女星拿出家谱证明！";
    
    switch (indexPath.row) {
        case 0:
            return cell1;
            break;
        case 1:
            return cell2;
            break;
        case 2:
            return cell3;
            break;
        case 3:
            return cell4;
            break;
            
        default:
            break;
    }
    return nil;
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
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _table;
}
@end
