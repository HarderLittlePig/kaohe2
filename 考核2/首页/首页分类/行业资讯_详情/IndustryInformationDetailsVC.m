//
//  IndustryInformationDetailsVC.m
//  考核2
//
//  Created by iOS 开发 on 2018/10/16.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "IndustryInformationDetailsVC.h"
#import "IndustryInformationDetailsBottomView.h"
#import "IndustryInformationDetailsCell1.h"
#import "IndustryInformationDetailsCell2.h"

#import "IndustryInformationDetailsModel.h"


#import "InformationPersonalPageVC.h"


// U-Share分享面板SDK，未添加分享面板SDK可将此行去掉
#import <UShareUI/UShareUI.h>

@interface IndustryInformationDetailsVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)UIView *line;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,weak)UIButton *userBtn;
@property(nonatomic,strong)NSMutableArray *array;
@end

@implementation IndustryInformationDetailsVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kWHITECOLOR;
    
    [self addBottomView];
    
    [self settingNacigationBar];
    
    [self.view addSubview:self.table];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, kNAVIGTAIONBARHEIGHT - kSTATUSBARHEIGH -1, kSCREENWIDTH, 1)];
    line.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar addSubview:line];
    self.line = line;
    
    IndustryInformationDetailsModel *model = [[IndustryInformationDetailsModel alloc]init];
    
    self.array = @[model,@2].mutableCopy;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IndustryInformationDetailsCell1 *cell1 = [IndustryInformationDetailsCell1 createCellWithTableView:tableView];
    IndustryInformationDetailsCell2 *cell2 = [IndustryInformationDetailsCell2 createCellWithTableView:tableView];
    cell1.jumpBlock = ^{
        [self jumpPersonPageAction];
    };
    
    [cell2.deleteBtn addTarget:self action:@selector(deleleRowAction) forControlEvents:UIControlEventTouchUpInside];
    if (indexPath.row == 0) {
        cell1.model = self.array[0];
        return cell1;
    }else{
        return cell2;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, 65 *Iphone6ScaleHeight)];
        v.backgroundColor = kORANGECOLOR;
        return v;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 65 *Iphone6ScaleHeight;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
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
        IndustryInformationDetailsModel *model = self.array[0];
        return model.cellHeight;
    }else{
        return 294+20;
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

//删除广告
-(void)deleleRowAction{
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:0];
    [self.array removeLastObject];
    [self.table deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view makeToast:@"删除成功" duration:1 position:CSToastPositionCenter];
    });
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
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
        _table.contentInset = UIEdgeInsetsMake(-40, 0, 0, 0);
    }
    return _table;
}

@end
