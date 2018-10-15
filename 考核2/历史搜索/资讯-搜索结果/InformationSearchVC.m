//
//  InformationSearchVC.m
//  考核2
//
//  Created by iOS 开发 on 2018/10/10.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "InformationSearchVC.h"
#import "CustomChannelNavigationBar.h"

#import "ClassContentCell1.h"
#import "ClassContentCell2.h"
#import "ClassAdCell.h"

#import "ClassModel.h"

@interface InformationSearchVC ()<CustomChannelNavigationBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation InformationSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWHITECOLOR;
    
    
    [self addNavigationBar];
    
    [self.view addSubview:self.table];
    
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
        [self.dataArray addObject:model];
    }
    
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
        [self.view makeToast:@"了解详情" duration:1.0f position:CSToastPositionCenter];
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
}

-(void)searchBarSearchButtonClicked:(CustomChannelNavigationBar *)searchBar{
    NSLog(@"%@",searchBar.inputField.text);
    if ([searchBar.inputField.text isEqualToString:@""] || searchBar.inputField.text.length == 0) {
        [self.view makeToast:@"请先输入内容" duration:1.0f position:CSToastPositionCenter];
    }else{
        [self.view makeToast:searchBar.inputField.text duration:1.0f position:CSToastPositionCenter];
    }
}

-(UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, kNAVIGTAIONBARHEIGHT, kSCREENWIDTH, kSCREENHEIGHT - kNAVIGTAIONBARHEIGHT) style:UITableViewStylePlain];
        _table.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
        _table.delegate = self;
        _table.dataSource = self;
        _table.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _table;
}

-(void)addNavigationBar{
    CustomChannelNavigationBar *bar = [[CustomChannelNavigationBar alloc]initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, kNAVIGTAIONBARHEIGHT)];
    bar.delegate = self;
    [bar.determineButton setTitle:@"搜索" forState:UIControlStateNormal];
    [bar.inputField becomeFirstResponder];
    bar.inputField.text = self.searchBarContent;
    [bar.determineButton setTitleColor:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1] forState:UIControlStateNormal];
    bar.backBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    __weak typeof(bar)  weakBar = bar;
    bar.determineBlock = ^{
        __strong typeof(weakBar) strongBar = weakBar;
        [self searchBarSearchButtonClicked:strongBar];
    };
    
    [self.view addSubview:bar];
}

@end
