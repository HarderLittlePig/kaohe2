//
//  HomeVC.m
//  考核2
//
//  Created by iOS 开发 on 2018/9/30.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "HomeVC.h"
#import "HomeNavigationBar.h"

#import "ClassVC.h"
//我的频道
#import "MyChannelVC.h"
//历史记录
#import "HistoryRecordVC.h"
#import "NavigationController.h"
//历史搜索
#import "HistorySearchVC.h"


@interface HomeVC ()<UIScrollViewDelegate,HomeNavigationBarDelegate>
@property(nonatomic,strong)NSMutableArray<UIButton *> *buttonArray;
@property(nonatomic,strong)UIButton *selectButton;
@property(nonatomic,strong)UIScrollView *contentView;
@property(nonatomic,strong)UIScrollView *titleView;
/** 标题栏底部的指示器   小红条 */
@property (nonatomic, strong) UIView *titleBottomView;

@end

@implementation HomeVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWHITECOLOR;
    
    //添加导航栏
    [self addNavigationBar];
    
//    //添加子控制器
    [self addChildVCS];
    
    UIView *titleBGView = [[UIView alloc]initWithFrame:CGRectMake(0, kNAVIGTAIONBARHEIGHT, kSCREENWIDTH, 40)];
    titleBGView.backgroundColor = kWHITECOLOR;
    [self.view addSubview:titleBGView];
    
    //添加头部滚动视图
    UIScrollView *titleView = [[UIScrollView alloc] init];
    titleView.bounces = NO;
    titleView.showsVerticalScrollIndicator = NO;
    titleView.showsHorizontalScrollIndicator = NO;
    //不减58这里是因为大约有一个渐变效果
    titleView.frame = CGRectMake(0,0,kSCREENWIDTH - 60,40);
    [titleBGView addSubview:titleView];
    self.titleView = titleView;
    
    UIButton *channelBtn = [[UIButton alloc]initWithFrame:CGRectMake(kSCREENWIDTH - 60, 0, 60, 40)];
    [channelBtn setImage:[UIImage imageNamed:@"xwzx_dz"] forState:UIControlStateNormal];
    channelBtn.adjustsImageWhenHighlighted = NO;
    [channelBtn addTarget:self action:@selector(jumpChannelAction) forControlEvents:UIControlEventTouchUpInside];
    [titleBGView addSubview:channelBtn];
    
    
    NSInteger count = self.childViewControllers.count;
    self.buttonArray = [NSMutableArray array];
    
    for (int i = 0; i < count; i++) {
        UIButton *titleButton = [[UIButton alloc]init];
        [titleButton setTitle:self.childViewControllers[i].title forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1] forState:UIControlStateSelected];
        [titleButton setTitleColor:[UIColor colorWithRed:139/255.0 green:150/255.0 blue:158/255.0 alpha:1] forState:UIControlStateNormal];
        titleButton.titleLabel.font = kFONT(15);
        [titleButton.titleLabel sizeToFit];
        [titleButton.titleLabel sizeThatFits:CGSizeMake(kSCREENWIDTH, 2)];
        
        //算出文字的的宽度 + 按钮本该有的间距
        CGFloat buttonW = [self.childViewControllers[i].title boundingRectWithSize:CGSizeMake(MAXFLOAT, titleView.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil].size.width + 30;
        
//        NSLog(@"%f",buttonW);
        titleButton.frame = CGRectMake(buttonW * i, 0, buttonW, titleView.height);
        [titleButton addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:titleButton];
        
        //按钮放进数组里
        [self.buttonArray addObject:titleButton];
    }
    ////////////////
    titleView.contentSize = CGSizeMake(self.buttonArray.firstObject.width * self.buttonArray.count, 0);
    
    
    
    //添加内容滚动视图
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.delegate = self;
    contentView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    contentView.showsVerticalScrollIndicator = NO;
    contentView.showsHorizontalScrollIndicator = NO;
    contentView.pagingEnabled = YES;
    contentView.contentSize = CGSizeMake(self.childViewControllers.count * kSCREENWIDTH, 0);
    contentView.frame = CGRectMake(0,kNAVIGTAIONBARHEIGHT + titleView.height,kSCREENWIDTH,kSCREENHEIGHT - kNAVIGTAIONBARHEIGHT - titleView.height);
    [self.view addSubview:contentView];
    self.contentView = contentView;
    
    // 默认显示第0个控制器,其实是手动调用了一次滑动的代理方法,相当于已经滑动了一次
    [self scrollViewDidEndScrollingAnimation:contentView];
    
    
    // 标签栏底部的指示器控件
    UIView *titleBottomView = [[UIView alloc] init];
    titleBottomView.backgroundColor = [UIColor colorWithRed:253/255.0 green:73/255.0 blue:73/255.0 alpha:1];
    titleBottomView.height = 3;
    titleBottomView.layer.cornerRadius = 2;
    titleBottomView.y = titleView.height - titleBottomView.height;
    [titleView addSubview:titleBottomView];
    self.titleBottomView = titleBottomView;
    
    
    
    
    UIButton *firstButton = self.buttonArray.firstObject;
    [self tapAction:firstButton];
}

/**
 * 当滚动动画完毕的时候调用（通过代码setContentOffset:animated:让scrollView滚动完毕后，就会调用这个方法）
 * 如果执行完setContentOffset:animated:后，scrollView的偏移量并没有发生改变的话，就不会调用scrollViewDidEndScrollingAnimation:方法
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    // 取出对应的子控制器       当前滑到了第几页
    int index = scrollView.contentOffset.x / scrollView.width;
    UIViewController *willShowChildVc = self.childViewControllers[index];
    
    // 如果控制器的view已经被创建过，就直接返回
    if (willShowChildVc.isViewLoaded) return;
//    if (willShowChildVc.viewIfLoaded) return;
//    if (willShowChildVc.view.superview) return;
    
    // 添加子控制器的view到scrollView身上
    willShowChildVc.view.frame = scrollView.bounds;
    [scrollView addSubview:willShowChildVc.view];
}

/**
 * 当减速完毕的时候调用（人为拖拽scrollView，手松开后scrollView慢慢减速完毕到静止）
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //再次手动调用代理方法
    [self scrollViewDidEndScrollingAnimation:scrollView];

    // 判断具体点击的哪个点击按钮
    int index = scrollView.contentOffset.x / scrollView.width;

    //调用按钮的点击方法
    [self tapAction:self.buttonArray[index]];
}

#pragma mark - 标题按钮居中
-(void)makeTitleButtonCenter:(UIButton *)button{
    
    CGFloat offsetX = button.centerX - kSCREENWIDTH * 0.5;
    if (offsetX < 0) {
        offsetX = 0;
    }
    
    //多加60是因为标题背景视图没有全屏的宽
    CGFloat maxoffsetX = self.titleView.contentSize.width - kSCREENWIDTH + 60;
    if (offsetX > maxoffsetX) {
        offsetX = maxoffsetX;
    }
    
    [self.titleView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}


-(void)textFieldDidBeginEditing:(HomeNavigationBar *)searchBar{
    HistorySearchVC *ccc = [[HistorySearchVC alloc]init];
    [self.navigationController pushViewController:ccc animated:YES];
}

//频道按钮的点击方法
-(void)tapAction:(UIButton *)sender{
    self.selectButton.selected = NO;
    sender.selected = YES;
    self.selectButton = sender;
    
    // 底部控件的位置和尺寸
    [UIView animateWithDuration:0.25 animations:^{
        self.titleBottomView.width = sender.titleLabel.width;
        self.titleBottomView.centerX = sender.centerX;
    }];
    
    // 让scrollView滚动到对应的位置
    CGPoint offset = self.contentView.contentOffset;
    offset.x = self.view.width * [self.buttonArray indexOfObject:sender];
    [self.contentView setContentOffset:offset animated:YES];
    
    //标题按钮居中
    [self makeTitleButtonCenter:sender];
}

 //跳转到我的频道
-(void)jumpChannelAction{
    MyChannelVC *channel = [[MyChannelVC alloc]init];
    NavigationController *nav = [[NavigationController alloc]initWithRootViewController:channel];

    channel.changeChannelBlock = ^(NSInteger index) {
        
        //移除所有的子控制器和子视图,重新添加
        for (UIViewController *vc in self.childViewControllers) {
            [vc removeFromParentViewController];
        }
        
        for (UIView *v in self.view.subviews) {
            [v removeFromSuperview];
        }
        
        //重新加载
        [self viewDidLoad];
        
        //滚动到想看的频道
        if (index != 0) {
            UIButton *firstButton = self.buttonArray[index];
            [self tapAction:firstButton];
        }
    };
    [self presentViewController:nav animated:YES completion:nil];
}

//写入文件的路径
- (NSString *)getFilePath{
    NSString *filePath  = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"MyChannelPlist.plist"];
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
            [@[@"推荐",@"机械",@"服装",@"电子",@"石材",@"电磁",@"头条",@"历史",@"军事",@"体育",@"搞逗"] writeToFile:filePath atomically:YES];
        }
    }
    return filePath;
}


-(void)addChildVCS{
    NSMutableArray *titleArray = [NSMutableArray arrayWithContentsOfFile:[self getFilePath]];
    for (NSString *title in titleArray) {
        ClassVC *childvc = [[ClassVC alloc]init];
        childvc.title = title;
        [self addChildViewController:childvc];
    }
}

-(void)addNavigationBar{
    HomeNavigationBar *bar = [[HomeNavigationBar alloc]initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, kNAVIGTAIONBARHEIGHT)];
    bar.delegate = self;
    bar.backBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    bar.classBlock = ^{
        HistoryRecordVC *history = [[HistoryRecordVC alloc]init];
        [self.navigationController pushViewController:history animated:YES];
    };
    
    [self.view addSubview:bar];
}
@end
