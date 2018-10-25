//
//  IndexTableView.m
//  考核2
//
//  Created by iOS 开发 on 2018/10/24.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "IndexTableView.h"
#import "IndexTableViewCell.h"

@implementation IndexTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        self.rowHeight = 15;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.showsVerticalScrollIndicator = NO;
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    
//        self.array = [NSArray array];
//        UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
//        self.array = collation.sectionTitles;
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IndexTableViewCell *cell = [IndexTableViewCell createCellWithTableView:tableView];
    cell.title.text = self.array[indexPath.section];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
    IndexTableViewCell *cell = [tableView cellForRowAtIndexPath:path];
    cell.title.backgroundColor = [UIColor colorWithRed:219/255.0 green:49/255.0 blue:23/255.0 alpha:1];
    cell.title.textColor = kWHITECOLOR;
    
    self.clickIndexBlock ? self.clickIndexBlock(indexPath.section) : nil;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
    IndexTableViewCell *cell = [tableView cellForRowAtIndexPath:path];
    cell.title.backgroundColor = kWHITECOLOR;
    cell.title.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1];
}
@end
