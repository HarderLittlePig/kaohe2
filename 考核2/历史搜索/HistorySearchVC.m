//
//  HistorySearchVC.m
//  考核2
//
//  Created by iOS 开发 on 2018/10/9.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "HistorySearchVC.h"
#import "CustomChannelNavigationBar.h"
#import "HistorySearchCell.h"
#import "HistorySearchReusableView.h"

#import "HistorySearchFlowLayout.h"

#import "InformationSearchVC.h"

@interface HistorySearchVC ()<UICollectionViewDelegate,UICollectionViewDataSource,CustomChannelNavigationBarDelegate>
@property (nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *historyArray;
@property(nonatomic,strong)NSMutableArray *hotArray;
@end

@implementation HistorySearchVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //显示就根据数据刷新UI
    [self.collectionView reloadData];
}

//写入文件的路径
- (NSString *)getFilePath{
    NSString *filePath  = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"SearchHistory.plist"];
    NSLog(@"%@",filePath);
    
    //2、判断文件在该路径下是否存在
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:filePath]) {
        //文件存在
        NSLog(@"数据库文件已经存在了,不需要重新创建了!");
    }else{
        //文件不存在
        NSLog(@"数据库文件不存在，需要我们去创建!");
        BOOL isCreateSuccess = [fileManager createFileAtPath:filePath contents:nil attributes:nil];
        if (isCreateSuccess) {
            NSLog(@"文件创建成功!");
            [@[@"推荐",@"机械机械机械",@"服装",@"头条",@"历史",@"军事",@"体育",@"搞逗",@"服装",@"推荐",@"机械"] writeToFile:filePath atomically:YES];
        }
    }
    return filePath;
}
 
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWHITECOLOR;
    
    [self addNavigationBar];
    
    self.historyArray = [NSMutableArray arrayWithContentsOfFile:[self getFilePath]];
    self.hotArray = @[@"推荐",@"机械",@"服装",@"头条",@"历史历史",@"军事",@"体育",@"搞逗",@"推荐",@"机械"].mutableCopy;
    
    HistorySearchFlowLayout *layout = [[HistorySearchFlowLayout alloc] init];
    layout.dataList = @[self.historyArray,self.hotArray];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kNAVIGTAIONBARHEIGHT, kSCREENWIDTH, kSCREENHEIGHT - kNAVIGTAIONBARHEIGHT) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _collectionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
    _collectionView.backgroundColor = kWHITECOLOR;
    
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HistorySearchCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([HistorySearchCell class])];
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HistorySearchReusableView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([HistorySearchReusableView class])];
    [self.view addSubview:_collectionView];
    
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(moveAction:)];
    _collectionView.userInteractionEnabled = YES;
    [_collectionView addGestureRecognizer:longPressGesture];
}

- (void)moveAction:(UILongPressGestureRecognizer *)longGes {
    
    if (longGes.state == UIGestureRecognizerStateBegan) {
        
        NSIndexPath *selectPath = [self.collectionView indexPathForItemAtPoint:[longGes locationInView:longGes.view]];
        if (selectPath.section == 1) {
            return;
        }        
        HistorySearchCell *cell = (HistorySearchCell *)[self.collectionView cellForItemAtIndexPath:selectPath];
        cell.deleteBtn.hidden = NO;
        [cell.deleteBtn addTarget:self action:@selector(deleteItemAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.deleteBtn.tag = selectPath.item;
        [self.collectionView beginInteractiveMovementForItemAtIndexPath:selectPath];
        
    }else if (longGes.state == UIGestureRecognizerStateChanged) {
        [self.collectionView updateInteractiveMovementTargetPosition:[longGes locationInView:longGes.view]];
        
    }else if (longGes.state == UIGestureRecognizerStateEnded) {
        [self.collectionView endInteractiveMovement];
        
    }else  if (longGes.state == UIGestureRecognizerStateCancelled){
        [self.collectionView cancelInteractiveMovement];
    }
}

- (void)deleteItemAction:(UIButton *)btn {
    [self.historyArray removeObjectAtIndex:btn.tag];
    [self.collectionView reloadData];
    [self.historyArray writeToFile:[self getFilePath] atomically:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return self.historyArray.count;
    }else{
        return self.hotArray.count;
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HistorySearchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HistorySearchCell class]) forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.title.text = self.historyArray[indexPath.item];
    }else{
        cell.title.text = self.hotArray[indexPath.item];
    }
    
    cell.deleteBtn.hidden = YES;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HistorySearchCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    //数组不包含,写入
    if (![self.historyArray containsObject:cell.title.text]) {
        [self.historyArray insertObject:cell.title.text atIndex:0];
        [self.historyArray writeToFile:[self getFilePath] atomically:YES];
    //包含就交换位置,保证最近搜索的排在最前面
    }else{
        NSInteger index = [self.historyArray indexOfObject:cell.title.text];
        [self.historyArray exchangeObjectAtIndex:index withObjectAtIndex:0];
    }
    
    InformationSearchVC *information = [[InformationSearchVC alloc]init];
    information.searchBarContent = cell.title.text;
    [self.navigationController pushViewController:information animated:YES];
}

//返回头尾
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    //重用
    HistorySearchReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([HistorySearchReusableView class]) forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        header.sectionLab.text = @"历史搜索";
        header.sectionImg.image = [UIImage imageNamed:@"search_history"];
        header.deleteBtn.hidden = NO;
        
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(22,50,150,25);
        label.text = @"    暂无历史记录";
        label.font = kFONT(14);
        label.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
//        label.hidden = YES;
        [header addSubview:label];
        
        
        header.deleteBlock = ^{
            [self.historyArray removeAllObjects];
            [self.historyArray writeToFile:[self getFilePath] atomically:YES];
//            label.hidden = NO;
            [self.collectionView reloadData];
        };
    }else{
        header.sectionLab.text = @"热门搜索";
        header.sectionImg.image = [UIImage imageNamed:@"search_hot"];
        header.deleteBtn.hidden = YES;
    }
    
    return header;
}

//头尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kSCREENWIDTH, 500);
}

//点击了搜索按钮
-(void)searchBarSearchButtonClicked:(CustomChannelNavigationBar *)searchBar{
    
    if ([searchBar.inputField.text isEqualToString:@""] || searchBar.inputField.text.length == 0) {
        [self.view makeToast:@"请先输入内容" duration:1.0f position:CSToastPositionCenter];
        return;
    }
    
    InformationSearchVC *information = [[InformationSearchVC alloc]init];
    information.searchBarContent = searchBar.inputField.text;
    [self.navigationController pushViewController:information animated:YES];
    
    //数组不包含,写入文件
    if (![self.historyArray containsObject:searchBar.inputField.text]) {
        
        [self.historyArray insertObject:searchBar.inputField.text atIndex:0];
        [self.historyArray writeToFile:[self getFilePath] atomically:YES];
        
    //包含就交换位置,保证最近搜索的排在最前面
    }else{
        NSInteger index = [self.historyArray indexOfObject:searchBar.inputField.text];
        [self.historyArray exchangeObjectAtIndex:index withObjectAtIndex:0];
    }
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
@end
