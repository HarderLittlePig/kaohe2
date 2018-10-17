//
//  MyChannelVC.m
//  考核2
//
//  Created by iOS 开发 on 2018/9/30.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "MyChannelVC.h"
#import "CustomChannelVC.h"
#import "MyChannelCell.h"

@interface MyChannelVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,weak)UILabel *promptLab;
@property(nonatomic,weak)UIButton *resetChannelBtn;
@property(nonatomic,weak)UIButton *customChannelBtn;
@property (nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *titleArray;
@property(nonatomic,assign)BOOL isBack;
@end

@implementation MyChannelVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWHITECOLOR;
    self.navigationItem.title = @"我的频道";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"xwzx_close"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(dismissAction)];
    self.navigationController.navigationBar.barTintColor = kWHITECOLOR;
    
    
    [self addsubViews];
}

-(void)addsubViews{
    //59.5
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, kNAVIGTAIONBARHEIGHT, kSCREENWIDTH, kSCREENHEIGHT - kNAVIGTAIONBARHEIGHT)];
    bgView.backgroundColor = kWHITECOLOR;
    [self.view addSubview:bgView];
    
    UILabel *promptLab = [[UILabel alloc]init];
    promptLab.text = @"点击进入频道";
    promptLab.font = kFONT(13);
    promptLab.textColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1];
    [bgView addSubview:promptLab];
    [promptLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(14.5);
        make.top.offset(20.5);
    }];
    self.promptLab = promptLab;
    
    
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn setTitle:@"完成" forState:UIControlStateSelected];
    editBtn.titleLabel.font = kFONT(13);
    [editBtn setTitleColor:[UIColor colorWithRed:237/255.0 green:49/255.0 blue:49/255.0 alpha:1] forState:UIControlStateNormal];
    editBtn.layer.borderWidth = 2;
    editBtn.layer.borderColor = [UIColor colorWithRed:237/255.0 green:49/255.0 blue:49/255.0 alpha:1].CGColor;
    editBtn.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    editBtn.layer.cornerRadius = 23*0.5;
    [editBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:editBtn];
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(55, 23));
        make.top.offset(15);
        make.right.offset(-15);
    }];
    
    NSString *path  = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"MyChannelPlist.plist"];
    self.titleArray = [NSMutableArray arrayWithContentsOfFile:path];
    _isBack = YES;
    
    /*
    //每一行的数
    int Count = 3;
    //四个间距都是30，总间距是120
    CGFloat width = (kSCREENWIDTH - 60)/Count;
    
    for (int i = 0; i < titleArray.count; i++) {
        NSString *btnTitle = titleArray[i];
        UIButton *channelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [channelBtn setTitle:btnTitle forState:UIControlStateNormal];
        [channelBtn setBackgroundImage:[UIImage imageNamed:@"wdpd_nr_bg"] forState:UIControlStateNormal];
        channelBtn.titleLabel.font = kFONT(15);
        channelBtn.adjustsImageWhenHighlighted = NO;
        [channelBtn setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1] forState:UIControlStateNormal];
        [channelBtn addTarget:self action:@selector(jumpToChannelAction:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:channelBtn];
        
        CGFloat y = 59.5 + i / Count * 50;
        int loc = i % Count;
        CGFloat x = 15 + (15 + width) * loc;
        channelBtn.frame = CGRectMake(x, y, width, 40);
    }
    */
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 15;
    layout.minimumInteritemSpacing = 15;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 59.5, kSCREENWIDTH, 318) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.contentInset = UIEdgeInsetsMake(0, 15, 0, 15);
    _collectionView.backgroundColor = kWHITECOLOR;
    [_collectionView registerNib:[UINib nibWithNibName:@"MyChannelCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [bgView addSubview:_collectionView];
    
    
    
    UIButton *resetChannelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [resetChannelBtn setTitle:@" 重 置" forState:UIControlStateNormal];
    [resetChannelBtn setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1] forState:UIControlStateNormal];
    resetChannelBtn.titleLabel.font = kFONT(15);
    resetChannelBtn.adjustsImageWhenHighlighted = NO;
    [resetChannelBtn setImage:[UIImage imageNamed:@"wdpd_cz_icon"] forState:UIControlStateNormal];
    resetChannelBtn.backgroundColor = [UIColor colorWithRed:246/255.0 green:247/255.0 blue:251/255.0 alpha:1];
    resetChannelBtn.layer.cornerRadius = 20;
    [resetChannelBtn addTarget:self action:@selector(resetChannelAction) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:resetChannelBtn];
    [resetChannelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(50);
        make.size.mas_equalTo(CGSizeMake(120, 40));
        make.top.offset(318);
    }];
    self.resetChannelBtn = resetChannelBtn;
    
    
    UIButton *customChannelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [customChannelBtn setTitle:@" 定制频道" forState:UIControlStateNormal];
    [customChannelBtn setTitleColor:[UIColor colorWithRed:219/255.0 green:49/255.0 blue:23/255.0 alpha:1] forState:UIControlStateNormal];
    customChannelBtn.titleLabel.font = kFONT(15);
    customChannelBtn.adjustsImageWhenHighlighted = NO;
    [customChannelBtn setImage:[UIImage imageNamed:@"组 4"] forState:UIControlStateNormal];
    customChannelBtn.backgroundColor = [UIColor colorWithRed:255/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    customChannelBtn.layer.cornerRadius = 20;
    [customChannelBtn addTarget:self action:@selector(jumpToCustomChannelVC) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:customChannelBtn];
    [customChannelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-50);
        make.size.mas_equalTo(CGSizeMake(120, 40));
        make.top.offset(318);
    }];
    self.customChannelBtn = customChannelBtn;
    
    
    UIImageView *bottomImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wdpd_bottom_bl"]];
    [bgView addSubview:bottomImageV];
    [bottomImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.offset(0);
        make.height.offset(96);
    }];
}

- (void)moveAction:(UILongPressGestureRecognizer *)longGes {

    if (longGes.state == UIGestureRecognizerStateBegan) {
        
        NSIndexPath *selectPath = [self.collectionView indexPathForItemAtPoint:[longGes locationInView:longGes.view]];
        MyChannelCell *cell = (MyChannelCell *)[self.collectionView cellForItemAtIndexPath:selectPath];
        cell.deleteBtn.hidden = NO;
        [cell.deleteBtn addTarget:self action:@selector(deleteItemAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.deleteBtn.tag = selectPath.item;
        [self.collectionView beginInteractiveMovementForItemAtIndexPath:selectPath];

    }else if (longGes.state == UIGestureRecognizerStateChanged) {
        [self.collectionView updateInteractiveMovementTargetPosition:[longGes locationInView:longGes.view]];

    }else if (longGes.state == UIGestureRecognizerStateEnded) {
        [self.collectionView endInteractiveMovement];

    }else {
        [self.collectionView cancelInteractiveMovement];

    }
}


- (void)deleteItemAction:(UIButton *)btn {
    [self.titleArray removeObjectAtIndex:btn.tag];
    [self.collectionView reloadData];
    NSString *path  = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"MyChannelPlist.plist"];
    [self.titleArray writeToFile:path atomically:YES];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((kSCREENWIDTH - 60)/3, 40);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyChannelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.title.text = self.titleArray[indexPath.item];
    cell.deleteBtn.hidden = YES;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [self.titleArray exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
    [self.collectionView reloadData];
    
    NSString *path  = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"MyChannelPlist.plist"];
    [self.titleArray writeToFile:path atomically:YES];
}

//选择想看的频道
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_isBack) {
        self.changeChannelBlock ? self.changeChannelBlock(indexPath.item) : nil;
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

//重置
-(void)resetChannelAction{
    self.titleArray = @[@"推荐",@"机械",@"服装",@"电子",@"石材",@"电磁",@"头条",@"历史",@"军事",@"体育",@"搞逗"].mutableCopy;
    [self.collectionView reloadData];
    NSString *path  = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"MyChannelPlist.plist"];
    [self.titleArray writeToFile:path atomically:YES];
}

//定制频道
-(void)jumpToCustomChannelVC{
    CustomChannelVC *custom = [[CustomChannelVC alloc]init];
    [self.navigationController pushViewController:custom animated:YES];
}

-(void)editAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    
    //按钮是否显示
    self.resetChannelBtn.hidden = sender.selected;
    self.customChannelBtn.hidden = sender.selected;   
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(moveAction:)];
    
    if (sender.selected) {
        self.promptLab.text = @"拖动频道可以排序";
        [_collectionView addGestureRecognizer:longPressGesture];
        //标记是否可以返回
        _isBack = NO;
        
    }else{
        self.promptLab.text = @"点击进入频道";
        [_collectionView removeGestureRecognizer:longPressGesture];
        _isBack = YES;
    }

}

-(void)dismissAction{
    self.changeChannelBlock ? self.changeChannelBlock(0) : nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
