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
@interface InformationDetailsVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)UIView *line;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,weak)UIButton *userBtn;
@property(nonatomic,strong)NSMutableArray *array;
@property(nonatomic,strong)WKWebView *webView;
@end

@implementation InformationDetailsVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kWHITECOLOR;
    
    [self addBottomView];
    
    [self settingNacigationBar];
    
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, kNAVIGTAIONBARHEIGHT, kSCREENWIDTH, kSCREENHEIGHT - kNAVIGTAIONBARHEIGHT - 52 - HOME_INDICATOR_HEIGHT)];
    self.webView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.jianshu.com/u/738706c0a028"]];
    [self.webView loadRequest:request];
//    [self.view addSubview:self.webView];
    
    self.table.tableHeaderView = self.webView;
    [self.view addSubview:self.table];
    
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
    return 55 *Iphone6ScaleHeight;
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.table) {
        if (scrollView.contentOffset.y > 200) {
            self.line.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1];
            //
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"返回"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
            //
            //            UIImageView *iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 23, 23)];
            //            iconImage.userInteractionEnabled = YES;
            //            iconImage.image = [[UIImage imageNamed:@"moment_pic_2"] imageWithRenderingMode:UIImageRenderingModeAutomatic];
            //            iconImage.layer.cornerRadius = 23*0.5;
            //            iconImage.layer.masksToBounds = YES;
            
            
            UIButton *userBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            userBtn.titleLabel.font = kFONT(17);
            userBtn.hidden = NO;
            [userBtn setTitle:@"谈资天下" forState:UIControlStateNormal];
            [userBtn setTitleColor:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1] forState:UIControlStateNormal];
            [userBtn addTarget:self action:@selector(jumpPersonPageAction) forControlEvents:UIControlEventTouchUpInside];
            self.userBtn = userBtn;
            //            UIBarButtonItem *userItem1 = [[UIBarButtonItem alloc]initWithCustomView:iconImage];
            UIBarButtonItem *userItem2 = [[UIBarButtonItem alloc]initWithCustomView:userBtn];
            //userItem1
            self.navigationItem.leftBarButtonItems = @[backItem,userItem2];
            //分享
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"xwzx_details_fx_p"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(shareAction)];
        }else{
            [self settingNacigationBar];
            
            self.line.backgroundColor = [UIColor clearColor];
            self.userBtn.hidden = YES;
        }
    }
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

-(UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, kNAVIGTAIONBARHEIGHT, kSCREENWIDTH, kSCREENHEIGHT - kNAVIGTAIONBARHEIGHT - 52 - HOME_INDICATOR_HEIGHT) style:UITableViewStyleGrouped];
        _table.tableFooterView = [[UIView alloc]init];
//        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
//        _table.contentInset = UIEdgeInsetsMake(-40, 0, 0, 0);
    }
    return _table;
}

@end
