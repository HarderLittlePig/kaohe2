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
#import "ClassAdCell.h"


@interface ClassVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *table;
@end

@implementation ClassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.frame = CGRectMake(0, 0, kSCREENWIDTH,kSCREENHEIGHT - kNAVIGTAIONBARHEIGHT - 40);
    [self.view addSubview:self.table];
    
    //self.table.refreshControl
    
    
    [self requestNewData];
    
    [self requestMoreData];
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
            [self.table.mj_footer endRefreshing];
            [self.table.mj_footer endRefreshingWithNoMoreData];
//            [self.table.mj_footer setState:MJRefreshStateNoMoreData];
//            [self.table.mj_footer resetNoMoreData];
        });
        [self.table.mj_footer beginRefreshing];
    }];
    
    
//
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row % 3 == 0) {
        return 130;
    }else if(indexPath.row % 3 == 1){
        return 210;
    }else{
        return 306;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 12;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ClassAdCell *adcell = [ClassAdCell createCellWithTableView:tableView];
    adcell.jumpBlock = ^{
        [SVProgressHUD showSuccessWithStatus:@"了解详情"];
    };
    
    ClassContentCell1 *contentcell1 = [ClassContentCell1 createCellWithTableView:tableView];
    ClassContentCell2 *contentcell2 = [ClassContentCell2 createCellWithTableView:tableView];
    
    if (indexPath.row % 3 == 0) {
        return contentcell1;
    }else if(indexPath.row % 3 == 1){
        return contentcell2;
    }else{
        return adcell;
    }
    
    
//    cell.backgroundColor = [UIColor colorWithRed:(arc4random() % 256)/255.0 green:(arc4random() % 256)/255.0 blue:(arc4random() % 256)/255.0 alpha:1];
}
-(UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _table.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
        _table.delegate = self;
        _table.dataSource = self;
        _table.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _table;
}
@end
