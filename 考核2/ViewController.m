//
//  ViewController.m
//  考核2
//
//  Created by iOS 开发 on 2018/9/30.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "ViewController.h"
#import "HomeVC.h"


// U-Share核心SDK
#import <UMShare/UMShare.h>
// U-Share分享面板SDK，未添加分享面板SDK可将此行去掉
#import <UShareUI/UShareUI.h>

#import "CommonConst.h"
@interface ViewController ()
@property(nonatomic,copy)NSString *userName;
@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    dispatch_queue_t queue = dispatch_queue_create("com.gcd.serial", DISPATCH_QUEUE_SERIAL);
//    dispatch_async(queue, ^{
//        NSLog(@"任务 %@", [NSThread currentThread]);
//        //这里要注意了，并不会死锁！
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            NSLog(@"同步任务%@", [NSThread currentThread]);
//        });
//    });
    
    //dispatch_sync() 造成死锁的条件是：如果在同一个队列(不管是不是主队列)添加同步任务，就会死锁，反之则不会。

    
    NSArray *arr = @[@"无知",@"风云变幻",@"施耐庵",@"唉",@"西门吹雪",@"呵回家回家后呵哒",@"快看看",@"窿窿啦哈哈哈啦",@"一杆禽兽狙",@"合欢花",@"暴走大事件",@"非诚勿扰",@"呵呵呵"];
    CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
    CGFloat h = 200;//用来控制button距离父视图的高
    for (int i = 0; i < arr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tag = 100 + i;
        button.backgroundColor = [UIColor greenColor];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        //根据计算文字的大小
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};
        CGFloat length = [arr[i] boundingRectWithSize:CGSizeMake(kSCREENWIDTH, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
        //为button赋值
        [button setTitle:arr[i] forState:UIControlStateNormal];
        //设置button的frame
        button.frame = CGRectMake(10 + w, h, length + 15 , 30);
        //当button的位置超出屏幕边缘时换行  只是button所在父视图的宽度
        if(10 + w + length + 15 > kSCREENWIDTH){
            w = 0; //换行时将w置为0
            h = h + button.frame.size.height + 10;//距离父视图也变化
            button.frame = CGRectMake(10 + w, h, length + 15, 30);//重设button的frame
        }
        w = button.frame.size.width + button.frame.origin.x;
        [self.view addSubview:button];
        
//        [button addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    //取消授权接口
    //[UMSocialManager defaultManager] cancelAuthWithPlatform:(UMSocialPlatformType) completion:<#^(id result, NSError *error)completion#>
    
    if (![[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Sina]) {
        NSLog(@"新浪微博没有安装");
    }
    
    
//    if (_noteField.text.length > 0) {
//        //先查找是否已存在数据 suiteName就是我们创建的group名称
//        NSArray *myNote = [[[NSUserDefaults alloc] initWithSuiteName:@"group.todayextension.widget"] valueForKey:@"MyNote"];
//        NSMutableArray *note = [NSMutableArray arrayWithArray:myNote];
//        if (!note) {
//            note = [NSMutableArray arrayWithCapacity:0];
//        }
//        [note insertObject:_noteField.text atIndex:0];
//        //存入数据
//        [[[NSUserDefaults alloc] initWithSuiteName:@"group.todayextension.widget"] setValue:note forKey:@"MyNote"];
//        [self.navigationController popViewControllerAnimated:YES];
//    }
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(30, 50, 100, 40);
    [btn setTitle:@"三方分享" forState:UIControlStateNormal];
    [btn setTitleColor:kBLACKCOLOR forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(130, 400, 100, 40);
    [btn1 setTitle:@"微信登录" forState:UIControlStateNormal];
    [btn1 setTitleColor:kBLACKCOLOR forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(getAuthWithUserInfoFromWechat) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(50, 400, 70, 40);
    [btn2 setTitle:@"QQ登录" forState:UIControlStateNormal];
    [btn2 setTitleColor:kBLACKCOLOR forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(getAuthWithUserInfoFromQQ) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(230, 400, 130, 40);
    [btn3 setTitle:@"新浪微博登录" forState:UIControlStateNormal];
    [btn3 setTitleColor:kBLACKCOLOR forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(getAuthWithUserInfoFromSina) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    
    
    
    NSDate *dayTime = [NSDate dateWithTimeIntervalSince1970:60 * 60 * 9];
    NSDate *noonTime = [NSDate dateWithTimeIntervalSince1970:60 * 60 * 12];
    NSDate *eveningTime = [NSDate dateWithTimeIntervalSince1970:60 * 60 * 19];
//    XCTAssertEqual(@"Morning", [testClass getCurrentTimeForDate:dayTime]);
//    XCTAssertEqual(@"Noon", [testClass getCurrentTimeForDate:noonTime]);
//    XCTAssertEqual(@"Evening", [testClass getCurrentTimeForDate:eveningTime]);
    
}

- (NSString *)getCurrentTimeForDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitHour fromDate:date];
    NSInteger hour = [components hour];
    
    if (hour >= 0 && hour < 6) {
        return @"Night";
    } else if (hour >= 6 && hour < 12) {
        return @"Morning";
    } else if (hour >= 12 && hour < 13) {
        return @"Noon";
    } else if (hour >= 13 && hour < 18) {
        return @"Afternoon";
    }
    return @"Evening";
}

-(void)share{
    //显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        [self shareWebPageToPlatformType:platformType];
    }];
}

-(void)shareAction:(UIButton *)sender{
    
    
    switch (sender.tag - 100) {
        case 0:
            // 根据获取的platformType确定所选平台进行下一步操作
            [self shareWebPageToPlatformType:UMSocialPlatformType_Sina];//新浪
            
            break;
        case 1:
            
            // 根据获取的platformType确定所选平台进行下一步操作
            [self shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];//微信聊天
            break;
        case 2:
            // 根据获取的platformType确定所选平台进行下一步操作
            [self shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine];//微信朋友圈
            
            break;
        case 3:
            // 根据获取的platformType确定所选平台进行下一步操作
            [self shareWebPageToPlatformType:UMSocialPlatformType_WechatFavorite];//微信收藏
            
            break;
        case 4:
            // 根据获取的platformType确定所选平台进行下一步操作
            [self shareWebPageToPlatformType:UMSocialPlatformType_QQ];//QQ聊天页面
            
            break;
        case 5:
            // 根据获取的platformType确定所选平台进行下一步操作
            [self shareWebPageToPlatformType:UMSocialPlatformType_Qzone];//qq空间
            
            break;
        case 6:
            // 根据获取的platformType确定所选平台进行下一步操作
            [self shareWebPageToPlatformType:UMSocialPlatformType_AlipaySession];//支付宝聊天页面
            
            break;
        case 7:
            // 根据获取的platformType确定所选平台进行下一步操作
            [self shareWebPageToPlatformType:UMSocialPlatformType_DingDing];//钉钉
            
            break;
        case 8:
            // 根据获取的platformType确定所选平台进行下一步操作
            [self shareWebPageToPlatformType:UMSocialPlatformType_EverNote];//印象笔记
            
            break;
        default:
            break;
    }
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    HomeVC *h = [[HomeVC alloc]init];
    [self.navigationController pushViewController:h animated:YES];
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



#pragma mark - 登录
- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:nil completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse *resp = result;
        // 第三方登录数据(为空表示平台未提供)
        // 授权数据
        NSLog(@" uid: %@", resp.uid);
        NSLog(@" openid: %@", resp.openid);
        NSLog(@" accessToken: %@", resp.accessToken);
        NSLog(@" refreshToken: %@", resp.refreshToken);
        NSLog(@" expiration: %@", resp.expiration);
        // 用户数据
        NSLog(@" name: %@", resp.name);
        NSLog(@" iconurl: %@", resp.iconurl);
        NSLog(@" gender: %@", resp.unionGender);
        // 第三方平台SDK原始数据
        NSLog(@" originalResponse: %@", resp.originalResponse);
    }];
}

//新浪微博：   在需要进行获取用户信息的UIViewController中加入如下代码
- (void)getAuthWithUserInfoFromSina{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Sina currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"Sina uid: %@", resp.uid);
            NSLog(@"Sina accessToken: %@", resp.accessToken);
            NSLog(@"Sina refreshToken: %@", resp.refreshToken);
            NSLog(@"Sina expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"Sina name: %@", resp.name);
            NSLog(@"Sina iconurl: %@", resp.iconurl);
            NSLog(@"Sina gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"Sina originalResponse: %@", resp.originalResponse);
            
            
            [self.view makeToast:[NSString stringWithFormat:@"用户%@,登录成功",self.userName] duration:1.0f position:CSToastPositionCenter];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.userName) {
                    [NSThread sleepForTimeInterval:1.0f];
                    HomeVC *h = [[HomeVC alloc]init];
                    [self.navigationController pushViewController:h animated:YES];
                }else{
                    [self.view makeToast:@"登录失败" duration:1.0f position:CSToastPositionCenter];
                }
            });
        }
    }];
}

//QQ： 授权并获取用户信息(获取uid、access token及用户名等)
- (void)getAuthWithUserInfoFromQQ{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"QQ uid: %@", resp.uid);
            NSLog(@"QQ openid: %@", resp.openid);
            NSLog(@"QQ unionid: %@", resp.unionId);
            NSLog(@"QQ accessToken: %@", resp.accessToken);
            NSLog(@"QQ expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"QQ name: %@", resp.name);
            NSLog(@"QQ iconurl: %@", resp.iconurl);
            NSLog(@"QQ gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"QQ originalResponse: %@", resp.originalResponse);
            
            
            [self.view makeToast:[NSString stringWithFormat:@"用户%@,登录成功",self.userName] duration:1.0f position:CSToastPositionCenter];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.userName) {
                    [NSThread sleepForTimeInterval:1.0f];
                    HomeVC *h = [[HomeVC alloc]init];
                    [self.navigationController pushViewController:h animated:YES];
                }else{
                    [self.view makeToast:@"登录失败" duration:1.0f position:CSToastPositionCenter];
                }
            });
        }
    }];
}

//微信： 授权并获取用户信息(获取uid、access token及用户名等)
//注意这里的uid为unionID
// 在需要进行获取用户信息的UIViewController中加入如下代码
- (void)getAuthWithUserInfoFromWechat{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid);
            NSLog(@"Wechat unionid: %@", resp.unionId);
            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            NSLog(@"Wechat expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"Wechat name: %@", resp.name);
            self.userName = resp.name;
            NSLog(@"Wechat iconurl: %@", resp.iconurl);
            NSLog(@"Wechat gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
            
            
            [self.view makeToast:[NSString stringWithFormat:@"用户%@,登录成功",self.userName] duration:1.0f position:CSToastPositionCenter];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.userName) {
                    [NSThread sleepForTimeInterval:1.0f];
                    HomeVC *h = [[HomeVC alloc]init];
                    [self.navigationController pushViewController:h animated:YES];
                }else{
                    [self.view makeToast:@"登录失败" duration:1.0f position:CSToastPositionCenter];
                }
            });
            
        }
    }];
}

@end
