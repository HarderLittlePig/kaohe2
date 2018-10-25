//
//  InformationDetailsVC.m
//  考核2
//
//  Created by iOS 开发 on 2018/10/23.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "InformationDetailsVC.h"
#import "IndustryInformationDetailsBottomView.h"
#import "InformationDetailsSectionHeader.h"
#import "InformationDetailsSectionFooter.h"
#import "InformationDetailsCell1.h"
#import "InformationDetailsCell2.h"
#import "InformationDetailsCell3.h"
#import "InformationDetailsCell4.h"
#import "ClassModel.h"

#import "InformationPersonalPageVC.h"

#import <WebKit/WebKit.h>

// U-Share分享面板SDK，未添加分享面板SDK可将此行去掉
#import <UShareUI/UShareUI.h>
@interface InformationDetailsVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,WKNavigationDelegate>
@property(nonatomic,weak)UIView *line;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,weak)UIButton *userBtn;
@property(nonatomic,strong)NSMutableArray *array;
@property(nonatomic,strong)WKWebView *webView;


@property (nonatomic, strong) UIScrollView  *containerScrollView;
@property (nonatomic, strong) UIView        *contentView;
@end

@implementation InformationDetailsVC{
    CGFloat _lastWebViewContentHeight;
    CGFloat _lastTableViewContentHeight;
}


- (void)initView{
    
    _lastWebViewContentHeight = 0;
    _lastTableViewContentHeight = 0;
    
    
    [self.contentView addSubview:self.webView];
//    [self.contentView addSubview:self.table];
    
    [self.view addSubview:self.containerScrollView];
    [self.containerScrollView addSubview:self.contentView];
    
    self.contentView.frame = CGRectMake(0, 0, self.view.width, self.view.height * 2);
    self.webView.y = 0;
    self.webView.height = self.view.height;
    self.table.y = self.webView.height;
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [self.contentView addSubview:self.table];
}

#pragma mark - Observers
- (void)addObservers{
    [self.webView addObserver:self forKeyPath:@"scrollView.contentSize" options:NSKeyValueObservingOptionNew context:nil];
    [self.table addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeObservers{
    [self.webView removeObserver:self forKeyPath:@"scrollView.contentSize"];
    [self.table removeObserver:self forKeyPath:@"contentSize"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (object == _webView) {
        if ([keyPath isEqualToString:@"scrollView.contentSize"]) {
            [self updateContainerScrollViewContentSize:0 webViewContentHeight:0];
        }
    }else if(object == _table) {
        if ([keyPath isEqualToString:@"contentSize"]) {
            [self updateContainerScrollViewContentSize:0 webViewContentHeight:0];
        }
    }
}

- (void)updateContainerScrollViewContentSize:(NSInteger)flag webViewContentHeight:(CGFloat)inWebViewContentHeight{
    
    CGFloat webViewContentHeight = flag==1 ?inWebViewContentHeight :self.webView.scrollView.contentSize.height;
    CGFloat tableViewContentHeight = self.table.contentSize.height;
    
    if (webViewContentHeight == _lastWebViewContentHeight && tableViewContentHeight == _lastTableViewContentHeight) {
        return;
    }
    
    _lastWebViewContentHeight = webViewContentHeight;
    _lastTableViewContentHeight = tableViewContentHeight;
    
    self.containerScrollView.contentSize = CGSizeMake(self.view.width, webViewContentHeight + tableViewContentHeight);
    
    CGFloat webViewHeight = (webViewContentHeight < self.view.height) ?webViewContentHeight :self.view.height ;
    CGFloat tableViewHeight = tableViewContentHeight < self.view.height ?tableViewContentHeight :self.view.height;
    self.webView.height = webViewHeight <= 0.1 ?0.1 :webViewHeight;
    self.contentView.height = webViewHeight + tableViewHeight;
    self.table.height = tableViewHeight;
    self.table.y = self.webView.height;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_containerScrollView != scrollView) {
        return;
    }
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    CGFloat webViewHeight = self.webView.height;
    CGFloat tableViewHeight = self.table.height;
    
    CGFloat webViewContentHeight = self.webView.scrollView.contentSize.height;
    CGFloat tableViewContentHeight = self.table.contentSize.height;
    
    if (offsetY <= 0) {
        self.contentView.y = 0;
        self.webView.scrollView.contentOffset = CGPointZero;
        self.table.contentOffset = CGPointZero;
//        NSLog(@"11111111111111");
    }else if(offsetY < webViewContentHeight - webViewHeight){
        self.contentView.y = offsetY;
        self.webView.scrollView.contentOffset = CGPointMake(0, offsetY);
        self.table.contentOffset = CGPointZero;
//        NSLog(@"2222222222222");
    }else if(offsetY < webViewContentHeight){
        self.contentView.y = webViewContentHeight - webViewHeight;
        self.webView.scrollView.contentOffset = CGPointMake(0, webViewContentHeight - webViewHeight);
        self.table.contentOffset = CGPointZero;
//        NSLog(@"333333333333");
    }else if(offsetY < webViewContentHeight + tableViewContentHeight - tableViewHeight){
        self.contentView.y = offsetY - webViewHeight;
        self.table.contentOffset = CGPointMake(0, offsetY - webViewContentHeight);
        self.webView.scrollView.contentOffset = CGPointMake(0, webViewContentHeight - webViewHeight);
        
//        NSLog(@"444444444444");
    }else if(offsetY <= webViewContentHeight + tableViewContentHeight ){
        self.contentView.y = self.containerScrollView.contentSize.height - self.contentView.height;
        self.webView.scrollView.contentOffset = CGPointMake(0, webViewContentHeight - webViewHeight);
        self.table.contentOffset = CGPointMake(0, tableViewContentHeight - tableViewHeight);

//        NSLog(@"555555");
    }else {
//        NSLog(@"do nothing");
    }
    
    
    
    
    if (scrollView.contentOffset.y > 200) {
        self.line.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1];
        //
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"返回"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];

        UIImage *img = [UIImage imageNamed:@"moment_pic_2"];
        UIButton *userBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        userBtn.titleLabel.font = kFONT(17);
        userBtn.hidden = NO;
        userBtn.adjustsImageWhenHighlighted = NO;
        [userBtn setTitle:@" 谈资天下" forState:UIControlStateNormal];
        [userBtn setImage:img.cutHeaderImage forState:UIControlStateNormal];
        [userBtn setTitleColor:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1] forState:UIControlStateNormal];
        [userBtn addTarget:self action:@selector(jumpPersonPageAction) forControlEvents:UIControlEventTouchUpInside];
        self.userBtn = userBtn;
        UIBarButtonItem *userItem2 = [[UIBarButtonItem alloc]initWithCustomView:userBtn];
        self.navigationItem.leftBarButtonItems = @[backItem,userItem2];
        //分享
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"xwzx_details_fx_p"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(shareAction)];
    }else{
        //重新设置bar上的按钮
        [self settingNacigationBar];
        
        self.line.backgroundColor = [UIColor clearColor];
        self.userBtn.hidden = YES;
    }
    
}
#pragma mark - private
- (WKWebView *)webView{
    if (!_webView) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, kNAVIGTAIONBARHEIGHT, kSCREENWIDTH, kSCREENHEIGHT - kNAVIGTAIONBARHEIGHT - 52 - HOME_INDICATOR_HEIGHT) configuration:configuration];
        _webView.scrollView.scrollEnabled = NO;
        _webView.navigationDelegate = self;
        _webView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
        NSString *path = @"https://www.jianshu.com/p/f31e39d3ce41";
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:path]];
        request.cachePolicy = NSURLRequestReloadIgnoringCacheData;
        [_webView loadRequest:request];
    }
    return _webView;
}
- (UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, kNAVIGTAIONBARHEIGHT, kSCREENWIDTH, kSCREENHEIGHT - kNAVIGTAIONBARHEIGHT - 52 - HOME_INDICATOR_HEIGHT) style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        _table.scrollEnabled = NO;
        _table.tableFooterView = [[UIView alloc]init];
        _table.contentInset = UIEdgeInsetsMake(0, 0, 18, 0);
    }
    return _table;
}
- (UIScrollView *)containerScrollView{
    if (_containerScrollView == nil) {
        _containerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNAVIGTAIONBARHEIGHT, kSCREENWIDTH, kSCREENHEIGHT - kNAVIGTAIONBARHEIGHT - 52 - HOME_INDICATOR_HEIGHT)];
        _containerScrollView.delegate = self;
        _containerScrollView.alwaysBounceVertical = YES;
        _containerScrollView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    }
    return _containerScrollView;
}

- (UIView *)contentView{
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kWHITECOLOR;
    
    [self initView];
    [self addObservers];
    
    
    [self addBottomView];
    [self settingNacigationBar];
    
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, kNAVIGTAIONBARHEIGHT - kSTATUSBARHEIGH -1, kSCREENWIDTH, 1)];
    line.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar addSubview:line];
    self.line = line;
    
//    IndustryInformationDetailsModel *model = [[IndustryInformationDetailsModel alloc]init];
//    self.array = @[model,@2].mutableCopy;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.array.count;
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InformationDetailsCell1 *cell1 = [InformationDetailsCell1 createCellWithTableView:tableView];
    InformationDetailsCell2 *cell2 = [InformationDetailsCell2 createCellWithTableView:tableView];
    InformationDetailsCell3 *cell3 = [InformationDetailsCell3 createCellWithTableView:tableView];
    InformationDetailsCell4 *cell4 = [InformationDetailsCell4 createCellWithTableView:tableView];
    
    if (indexPath.row == 0) {
        return cell1;
    }else if (indexPath.row == 1) {
        return cell2;
    }else if (indexPath.row == 2) {
        return cell3;
    }else {
        return cell4;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    InformationDetailsSectionHeader *header = [[InformationDetailsSectionHeader alloc]initWithFrame:CGRectZero];
    return header;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 65 *Iphone6ScaleHeight;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    InformationDetailsSectionFooter *footer = [[InformationDetailsSectionFooter alloc]initWithFrame:CGRectZero];
    footer.lookMoreBtn = ^{
        [self.view makeToast:@"加载更多" duration:1.0f position:CSToastPositionCenter];
    };
    return footer;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 57 *Iphone6ScaleHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 123;
    }else if (indexPath.row == 1) {
        return 205;
    }else if (indexPath.row == 2) {
        return 325;
    }else {
        return 113;
    }
}

-(void)shareAction{
    //显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        [self shareWebPageToPlatformType:platformType];
    }];
}

#pragma mark - 分享LinkCard(网页链接)
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString* thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"欢迎使用【友盟+】社会化组件U-Share" descr:@"欢迎使用【友盟+】社会化组件U-Share，SDK包最小，集成成本最低，助力您的产品开发、运营与推广！" thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = @"http://mobile.umeng.com/social";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
    }];
}

-(void)jumpPersonPageAction{
    InformationPersonalPageVC *personal = [[InformationPersonalPageVC alloc]init];
    [self.navigationController pushViewController:personal animated:YES];
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)settingNacigationBar{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"xwzx_details_fh"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    //分享
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"xwzx_details_fx"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(shareAction)];
    
    self.navigationController.navigationBar.barTintColor = kWHITECOLOR;
    
    //去除UINavigationBar的黑线
    [[UINavigationBar appearance]setShadowImage:[UIImage new]];
    [[UINavigationBar appearance]setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}

-(void)addBottomView{
    IndustryInformationDetailsBottomView *bottomV = [[IndustryInformationDetailsBottomView alloc]init];
    [self.view addSubview:bottomV];
}

@end
