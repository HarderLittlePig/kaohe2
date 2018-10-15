//
//  HistoryRecordVC.m
//  考核2
//
//  Created by iOS 开发 on 2018/10/9.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "HistoryRecordVC.h"
#import "HistoryRecordNavigationBar.h"
#import "MyChannelCell.h"
#import "HistoryRecordReusableView.h"
#import "HistoryRecordCell.h"
#import "ClassSearchVC.h"

@interface HistoryRecordVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,HistoryRecordNavigationBarDelegate>
@property (nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *titleArray;
@property(nonatomic,weak)UITableView *leftTable;
@property(nonatomic,weak)UITableView *rightTable;
@end
//
@implementation HistoryRecordVC

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWHITECOLOR;
    
    [self addNavigationBar];
    
    self.titleArray = @[@"111",@"333",@"555",@"777",@"999"].mutableCopy;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 15;
    layout.minimumInteritemSpacing = 15;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kNAVIGTAIONBARHEIGHT, kSCREENWIDTH, 189) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.contentInset = UIEdgeInsetsMake(0, 15, 30, 15);
    _collectionView.backgroundColor = kWHITECOLOR;
    [_collectionView registerNib:[UINib nibWithNibName:@"MyChannelCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:_collectionView];
    [_collectionView registerNib:[UINib nibWithNibName:@"HistoryRecordReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    
    UIView *separatorV = [[UIView alloc]initWithFrame:CGRectMake(0, kNAVIGTAIONBARHEIGHT + 189, kSCREENWIDTH, 10)];
    separatorV.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    [self.view addSubview:separatorV];
    
    
    UIImageView *img1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wdpd_dzpd_zs"]];
    [separatorV addSubview:img1];
    [img1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(30);
        make.top.offset(-20);
        make.size.mas_equalTo(CGSizeMake(13, 50));
    }];
    
    UIImageView *img2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wdpd_dzpd_zs"]];
    [separatorV addSubview:img2];
    [img2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-30);
        make.top.offset(-20);
        make.size.mas_equalTo(CGSizeMake(13, 50));
    }];
    
    CGFloat listHeight = kSCREENHEIGHT - kNAVIGTAIONBARHEIGHT - _collectionView.height - 10-20-13.5;
    //背景的view
    UIView *listView = [[UIView alloc]init];
    listView.backgroundColor = kWHITECOLOR;
    [self.view addSubview:listView];
    [listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(img1.mas_bottom).offset(13.5);
        make.height.offset(listHeight);
    }];
    
    UITableView *leftTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kSCREENWIDTH * 0.5, listHeight) style:UITableViewStylePlain];
    leftTable.showsVerticalScrollIndicator = NO;
    leftTable.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    leftTable.rowHeight = 55;
    leftTable.delegate = self;
    leftTable.dataSource = self;
    [listView addSubview:leftTable];
    self.leftTable = leftTable;
    
    UITableView *rightTable = [[UITableView alloc]initWithFrame:CGRectMake(kSCREENWIDTH * 0.5, 0, kSCREENWIDTH * 0.5, listHeight) style:UITableViewStylePlain];
    rightTable.showsVerticalScrollIndicator = NO;
    rightTable.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    rightTable.rowHeight = 55;
    rightTable.delegate = self;
    rightTable.dataSource = self;
    [listView addSubview:rightTable];
    self.rightTable = rightTable;
    
    [self.leftTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    [self.rightTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    
    
    //默认时索引列文本的颜色
//    leftTable.sectionIndexColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];;
//    //修改索引条字体大小,修改索引条字体大小没有public的api调用修改，遍历子控件找到UITableViewIndex后，需要使用kvc，keypath是font。
//    for (UIView *subView in leftTable.subviews) {
//        if ([subView isKindOfClass:NSClassFromString(@"UITableViewIndex")]) {
//            [subView setValue:[UIFont systemFontOfSize:15.0] forKey:@"font"];
//        }
//    }

//    if ([leftTable respondsToSelector:@selector(setSectionIndexColor:)]) {
//        //默认时，索引的背景颜色
//        leftTable.sectionIndexBackgroundColor = kORANGECOLOR;
//        //选中时，索引背景颜色
//        leftTable.sectionIndexTrackingBackgroundColor = kREDCOLOR;
//    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.rightTable) {
        return 10;
    }else{
        return 1;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.rightTable) {
        return 10;
    }else{
        return 10;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld组第%ld行",indexPath.section,indexPath.row];
    cell.textLabel.font = kFONT(15);
    cell.textLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    cell.textLabel.highlightedTextColor = [UIColor colorWithRed:219/255.0 green:49/255.0 blue:23/255.0 alpha:1];
    
    
    HistoryRecordCell *history = [HistoryRecordCell createCellWithTableView:tableView];
    history.textLabel.text = [NSString stringWithFormat:@"第%ld组",indexPath.section];
    history.textLabel.font = kFONT(15);
    history.textLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    history.textLabel.highlightedTextColor = [UIColor colorWithRed:219/255.0 green:49/255.0 blue:23/255.0 alpha:1];
    
    if (tableView == self.leftTable) {
        return history;
    }else{
        return cell;
    }
}

#pragma mark - Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTable) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
        [self.rightTable scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:NO];
        [self.rightTable selectRowAtIndexPath:path animated:NO scrollPosition:UITableViewScrollPositionTop];
    }else{
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [self.titleArray addObject:cell.textLabel.text];
        [_collectionView reloadData];
        
        [self noDataBackground];
        
    }
}

//方法好像不太对啊
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView == self.rightTable) {
        //取出当前显示的最顶部的cell的indexpath
        //当前tableview页面可见的分区属性 indexPathsForVisibleRows
        // 取出显示在 视图 且最靠上 的 cell 的 indexPath
        // 判断tableView是否滑动到最底部
        CGFloat height = scrollView.frame.size.height;
        CGFloat contentOffsetY = scrollView.contentOffset.y;
        CGFloat bottomOffset = scrollView.contentSize.height - contentOffsetY;
        
        if (bottomOffset <= height) {
            //
            NSIndexPath *bottomIndexPath = [[self.rightTable indexPathsForVisibleRows] lastObject];
            NSIndexPath *moveIndexPath = [NSIndexPath indexPathForRow:0 inSection:bottomIndexPath.section];
            [self.leftTable selectRowAtIndexPath:moveIndexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
        } else {
            
            //rightTable 滚动的时候,获取当前页面可见的分区行数
            NSIndexPath *topIndexPath = [[self.rightTable indexPathsForVisibleRows]firstObject];
            NSIndexPath *moveIndexPath = [NSIndexPath indexPathForRow:0 inSection:topIndexPath.section];
            
            [self.leftTable selectRowAtIndexPath:moveIndexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
        }
    }
}

//添加索引栏标题数组
//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
//    if (tableView == self.leftTable) {
//        //    NSMutableArray *resultArray =[NSMutableArray arrayWithObject:UITableViewIndexSearch];
//        NSArray *arr = @[@"B",@"C",@"D",@"B",@"C",@"D",@"B",@"C",@"D",@"B"];
//        return arr;
//    }
//    return nil;
//}

// 点击索引栏标题时执行
//-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
//    if (tableView == self.leftTable) {
//        // 获取所点目录对应的indexPath值
//        NSIndexPath *selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:index];
//        // 让table滚动到对应的indexPath位置
//        [tableView scrollToRowAtIndexPath:selectIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//        [tableView selectRowAtIndexPath:selectIndexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
//
//
//        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:index];
//        [self.rightTable scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:NO];
//        [self.rightTable selectRowAtIndexPath:path animated:NO scrollPosition:UITableViewScrollPositionTop];
//        return index;
//    }
//    return 0;
//}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((kSCREENWIDTH - 60)/3, 40);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyChannelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.title.text = self.titleArray[indexPath.item];
    cell.deleteBtn.tag = indexPath.item + 1000;
    [cell.deleteBtn addTarget:self action:@selector(deleteItemAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

//单个删除
-(void)deleteItemAction:(UIButton *)sender{
    [self.titleArray removeObjectAtIndex:sender.tag - 1000];
    if (self.titleArray.count == 0) {
        [self noDataBackground];
    }
    [self.collectionView reloadData];
}

//返回头尾
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    //重用
    HistoryRecordReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    header.frame = CGRectMake(0, 0, kSCREENWIDTH, 60);
    header.deleteBlock = ^{
        [self.titleArray removeAllObjects];
        //无数据的背景
        [self noDataBackground];
    };
    return header;
}

-(void)noDataBackground{
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(22,141,81.5,13.5);
    label.text = @"    暂无历史记录";
    label.font = kFONT(14);
    label.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    if (self.titleArray.count == 0) {
        self.collectionView.backgroundView = label;
        label.hidden = NO;
    }else{
        label.hidden = YES;
    }
    [self.collectionView reloadData];
}

//头尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kSCREENWIDTH, 60);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MyChannelCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    ClassSearchVC *searc = [[ClassSearchVC alloc]init];
    searc.searchBarContent = cell.title.text;
    [self.navigationController pushViewController:searc animated:YES];
}

-(void)textFieldDidBeginEditing:(HistoryRecordNavigationBar *)searchBar{
    ClassSearchVC *searc = [[ClassSearchVC alloc]init];
    [self.navigationController pushViewController:searc animated:YES];
}

-(void)addNavigationBar{
    HistoryRecordNavigationBar *bar = [[HistoryRecordNavigationBar alloc]initWithFrame:CGRectZero];
    bar.delegate = self;
    bar.backBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    [self.view addSubview:bar];
}
@end
