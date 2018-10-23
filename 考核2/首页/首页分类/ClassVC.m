//
//  ClassVC.m
//  考核2
//
//  Created by iOS 开发 on 2018/9/30.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "ClassVC.h"
#import "ClassContentCell1.h"
#import "ClassContentCell2.h"
#import "ClassContentCell3.h"
#import "ClassAdCell.h"
#import "ClassModel.h"

#import "IndustryInformationDetailsVC.h"
#import "InformationDetailsVC.h"

@interface ClassVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation ClassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kWHITECOLOR;
    
    self.view.frame = CGRectMake(0, 0, kSCREENWIDTH,kSCREENHEIGHT - kNAVIGTAIONBARHEIGHT - 40);
    [self.view addSubview:self.table];
    
    //self.table.refreshControl
    
    [self requestNewData];
    
    [self requestMoreData];
    
    self.dataArray = [NSMutableArray array];
    for (int i = 0; i < 13; i++) {
        ClassModel *model = [[ClassModel alloc]init];
        model.title = @"习近平寄语...青少年儿童人生的扣子从一开始就要扣好";
        model.lookCount = @"136";
        model.publishTime = @"2018-10-12";
        
        if ((i + 1) % 5 == 0) {
            model.imageArray = @[@1,@2,@3];
        }else{
            model.imageArray = @[@1];
        }
        
        if (i == 6) {
            model.imageArray = @[];
        }
        
        if (i == 0) {
            model.isTopping = YES;
        }
        if (i == 1 || i == 2) {
            model.isPopular = YES;
        }
        
        if (i == 7) {
            model.isAd = YES;
        }
        
        [self.dataArray addObject:model];
    }
}

-(void)requestNewData{
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.table.mj_header endRefreshing];
        });
    }];
    [self.table.mj_header beginRefreshing];
}

-(void)requestMoreData{
    self.table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self.table.mj_footer endRefreshing];
            [self.table.mj_footer endRefreshingWithNoMoreData];
            [self.table.mj_footer setState:MJRefreshStateNoMoreData];
//            [self.table.mj_footer resetNoMoreData];
            
        });
        [self.table.mj_footer beginRefreshing];
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    ClassModel *model = self.dataArray[indexPath.row];
    if (model.imageArray.count == 0) {
        return 102 + 8;
    }
    if (model.imageArray.count == 1) {
        if (model.isAd) {
            return 306 + 8;
        }
        return 112 + 8;
    }else if (model.imageArray.count > 1){
        return 195 + 8;
    }else{
        return 112 + 8;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 12;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ClassAdCell *adcell = [ClassAdCell createCellWithTableView:tableView];
    adcell.jumpBlock = ^{
        [self.view makeToast:@"了解详情" duration:1.0f position:CSToastPositionCenter];
    };
    
    ClassContentCell1 *contentcell1 = [ClassContentCell1 createCellWithTableView:tableView];
    ClassContentCell2 *contentcell2 = [ClassContentCell2 createCellWithTableView:tableView];
    ClassContentCell3 *contentcell3 = [ClassContentCell3 createCellWithTableView:tableView];
    
    ClassModel *model = self.dataArray[indexPath.row];
    contentcell1.model = model;
    contentcell2.model = model;
    contentcell3.model = model;
    adcell.model = model;
    
    if (model.imageArray.count == 0) {
        return contentcell3;
    }
    
    if (model.imageArray.count == 1) {
        
        if (model.isAd) {
            return adcell;
        }
        
        return contentcell1;
        
    }else if (model.imageArray.count > 1){
        return contentcell2;
        
    }else{
        return contentcell1;
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row % 2 == 0) {
        IndustryInformationDetailsVC *detail = [[IndustryInformationDetailsVC alloc]init];
        [self.navigationController pushViewController:detail animated:YES];
    }else{
        InformationDetailsVC *detail = [[InformationDetailsVC alloc]init];
        [self.navigationController pushViewController:detail animated:YES];
    }
}

-(UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _table.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
        _table.delegate = self;
        _table.dataSource = self;
        _table.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _table;
}
@end
