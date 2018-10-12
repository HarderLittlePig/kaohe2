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

#import "ClassModel.h"

@interface ClassVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation ClassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
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
            [self.table.mj_footer endRefreshing];
            [self.table.mj_footer endRefreshingWithNoMoreData];
//            [self.table.mj_footer setState:MJRefreshStateNoMoreData];
//            [self.table.mj_footer resetNoMoreData];
        });
        [self.table.mj_footer beginRefreshing];
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    ClassModel *model = self.dataArray[indexPath.row];
    
    if (model.imageArray.count <= 1) {
        if (model.isAd) {
            return 316;
        }
        return 130;
    }else if (model.imageArray.count > 1){
        return 210;
    }else{
        return 130;
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
    
    
    ClassModel *model = self.dataArray[indexPath.row];
    contentcell1.model = model;
    contentcell2.model = model;
    adcell.model = model;
    
    if (model.imageArray.count <= 1) {
        
        if (model.isAd) {
            return adcell;
        }
        
        return contentcell1;
        
    }else if (model.imageArray.count > 1){
        return contentcell2;
        
    }else{
        return contentcell1;
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
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _table;
}
@end
