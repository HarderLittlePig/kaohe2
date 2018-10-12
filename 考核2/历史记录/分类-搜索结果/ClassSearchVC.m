//
//  ClassSearchVC.m
//  考核2
//
//  Created by iOS 开发 on 2018/10/10.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "ClassSearchVC.h"
#import "CustomChannelNavigationBar.h"

@interface ClassSearchVC ()<UITableViewDelegate,UITableViewDataSource,CustomChannelNavigationBarDelegate>
@property(nonatomic,strong)UITableView *table;
@end

@implementation ClassSearchVC

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWHITECOLOR;
    
    [self addNavigationBar];
    
    [self.view addSubview:self.table];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 12;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"洗衣机";
    cell.textLabel.font = kFONT(15);
    cell.textLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)addNavigationBar{
    CustomChannelNavigationBar *bar = [[CustomChannelNavigationBar alloc]initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, kNAVIGTAIONBARHEIGHT)];
    bar.delegate = self;
    [bar.determineButton setTitle:@"搜索" forState:UIControlStateNormal];
    [bar.inputField becomeFirstResponder];
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

-(void)searchBarSearchButtonClicked:(CustomChannelNavigationBar *)searchBar{
    NSLog(@"点击了键盘搜索");
}

-(void)searchBar:(CustomChannelNavigationBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"输入内容为%@，请求新数据刷新UI",searchText);
}

-(UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, kNAVIGTAIONBARHEIGHT, kSCREENWIDTH, kSCREENHEIGHT - kNAVIGTAIONBARHEIGHT) style:UITableViewStylePlain];
        _table.backgroundColor = kWHITECOLOR;
        _table.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _table.tableFooterView = [[UIView alloc]init];
        _table.delegate = self;
        _table.dataSource = self;
        _table.rowHeight = 55;
    }
    return _table;
}
@end
