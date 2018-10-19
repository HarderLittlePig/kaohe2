//
//  AppDelegate.m
//  考核2
//
//  Created by iOS 开发 on 2018/9/30.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "NavigationController.h"

/*
 *应用启动后进行U-Share和第三方平台的初始化工作以下代码将所有平台初始化示例放出，开发者根据平台需要选取相应代码，并替换为所属注册的appKey和appSecret。
 
 注意并不是所有分享平台都需要配置对应的Appkey，比如WhatsApp、印象笔记平台会直接通过AirDrop方式分享，而短信和邮件会直接调用系统自带的应用进行分享，这两种分享方式均不需要配置对应的三方Appkey
 */
#import <UMShare/UMShare.h>


//#import "UMengComDemoUIHeaders.h"
//#import "UMNaviViewController.h"
#import <UMCommon/UMCommon.h>
#import <UMPush/UMessage.h>
#import <UMShare/UMShare.h>
//#import <UMAnalytics/MobClick.h>
#import <UserNotifications/UserNotifications.h>
#import <UMCommonLog/UMCommonLogHeaders.h>

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    ViewController *v = [[ViewController alloc]init];
    NavigationController *nav = [[NavigationController alloc]initWithRootViewController:v];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    
    //开发者需要显式的调用此函数，日志系统才能工作
//    [UMCommonLogManager setUpUMCommonLogManager];
//    [UMConfigure setLogEnabled:YES];
    
    [UMConfigure initWithAppkey:@"5bc980d0f1f556d704000314" channel:@"App Store"];
    
//    [MobClick setScenarioType:E_UM_GAME|E_UM_DPLUS];
    
    // Push组件基本功能配置
    UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
    //type是对推送的几个参数的选择，可以选择一个或者多个。默认是三个全部打开，即：声音，弹窗，角标
    entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionSound|UMessageAuthorizationOptionAlert;
    [UNUserNotificationCenter currentNotificationCenter].delegate=self;
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity completionHandler:^(BOOL granted, NSError * _Nullable error) {
        
        if (granted) {
            }else{
                
        }
    }];
    

    //如果你期望使用交互式(只有iOS 8.0及以上有)的通知，请参考下面注释部分的初始化代码
    if (([[[UIDevice currentDevice] systemVersion]intValue]>=8)&&([[[UIDevice currentDevice] systemVersion]intValue]<10)) {
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title=@"打开应用";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title=@"忽略";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;
        UIMutableUserNotificationCategory *actionCategory1 = [[UIMutableUserNotificationCategory alloc] init];
        actionCategory1.identifier = @"category1";//这组动作的唯一标示
        [actionCategory1 setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
        NSSet *categories = [NSSet setWithObjects:actionCategory1, nil];
        entity.categories=categories;
    }
    //如果要在iOS10显示交互式的通知，必须注意实现以下代码
    if ([[[UIDevice currentDevice] systemVersion]intValue]>=10) {
        UNNotificationAction *action1_ios10 = [UNNotificationAction actionWithIdentifier:@"action1_identifier" title:@"打开应用" options:UNNotificationActionOptionForeground];
        UNNotificationAction *action2_ios10 = [UNNotificationAction actionWithIdentifier:@"action2_identifier" title:@"忽略" options:UNNotificationActionOptionForeground];
        
        //UNNotificationCategoryOptionNone
        //UNNotificationCategoryOptionCustomDismissAction  清除通知被触发会走通知的代理方法
        //UNNotificationCategoryOptionAllowInCarPlay       适用于行车模式
        UNNotificationCategory *category1_ios10 = [UNNotificationCategory categoryWithIdentifier:@"category1" actions:@[action1_ios10,action2_ios10]   intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
        NSSet *categories = [NSSet setWithObjects:category1_ios10, nil];
        entity.categories=categories;
    }
    [UNUserNotificationCenter currentNotificationCenter].delegate=self;
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
        }else{
        }
    }];
    
    
    //给设备打的标签
    
    //获取所有标签
    [UMessage getTags:^(NSSet * _Nonnull responseTags, NSInteger remain, NSError * _Nonnull error) {
    }];
    
    //添加标签
    [UMessage addTags:@"体育" response:^(id  _Nonnull responseObject, NSInteger remain, NSError * _Nonnull error) {
    }];
    
    //删除标签
    [UMessage deleteTags:@"体育" response:^(id  _Nonnull responseObject, NSInteger remain, NSError * _Nonnull error) {
    }];
    
    
    
    //获取所有加权标签
    [UMessage getWeightedTags:^(NSDictionary * _Nonnull responseWeightedTags, NSInteger remain, NSError * _Nonnull error) {
    }];
    //添加加权标签
    [UMessage addWeightedTags:@{@"汽车":@3} response:^(id  _Nonnull responseObject, NSInteger remain, NSError * _Nonnull error) {
    }];
    //删除加权标签
    [UMessage deleteWeightedTags:@{@"汽车":@3} response:^(id  _Nonnull responseObject, NSInteger remain, NSError * _Nonnull error) {
    }];
    
    
    //绑定别名
    [UMessage addAlias:@"test@umeng.com" type:@"UMENGTEST" response:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
    }];
    //重置别名
    [UMessage setAlias:@"test@umeng.com" type:@"UMENGTEST" response:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
    }];
    //移除别名
    [UMessage removeAlias:@"test@umeng.com" type:@"UMENGTEST" response:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
    }];
    

    
    
    [UMessage openDebugMode:YES];
    [UMessage addLaunchMessage];
    
    
    // UMConfigure 通用设置，请参考SDKs集成做统一初始化。
    // 以下仅列出U-Share初始化部分
    // U-Share 平台设置
    [self configUSharePlatforms];
    [self confitUShareSettings];
    
    return YES;
}

- (void)confitUShareSettings{
    /*
     * 打开图片水印
     */
    [UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
}

- (void)configUSharePlatforms{
    /*
     设置微信的appKey和appSecret
     [微信平台从U-Share 4/5升级说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_1
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxdc1e388c3822c80b" appSecret:@"3baf1193c85774b3fd9d18447d76cab0" redirectURL:@"http://mobile.umeng.com/social"];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     100424468.no permission of union id
     [QQ/QZone平台集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_3
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105821097"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
    /*
     设置新浪的appKey和appSecret
     [新浪微博集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_2
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    
    /* 钉钉的appKey */
    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_DingDing appKey:@"dingoalmlnohc0wggfedpk" appSecret:nil redirectURL:nil];
    
    /* 支付宝的appKey */
    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_AlipaySession appKey:@"2015111700822536" appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

# pragma mark - 设置系统回调
/*
 *注：此方法在swift4.1(Xcode 9.3)已废弃，Objective-C项目不影响。 新浪 平台外的其他平台可在swift项目中使用下面两种回调方法。
 仅支持iOS9以上系统，iOS8及以下系统不会回调
 */
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

//支持目前所有iOS系统
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

/*
 *若想了解更多U-Share接口，如判断平台安装等，请参考U-Share API说明
 */




//iOS10以下使用这两个方法接收通知
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    //设置是否允许SDK当应用在前台运行收到Push时弹出Alert框
    [UMessage setAutoAlert:NO];
    
    if([[[UIDevice currentDevice] systemVersion]intValue] < 10){
        [UMessage didReceiveRemoteNotification:userInfo];
    }
    completionHandler(UIBackgroundFetchResultNewData);
    
    
    //是否允许SDK自动清空角标
    //[UMessage setBadgeClear:NO];
    
    
    /** 为某个消息发送点击事件
     */
    //[UMessage sendClickReportForRemoteNotification:<#(NSDictionary * _Nullable)#>]
}

//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler API_AVAILABLE(ios(10.0)){
    
    NSDictionary * userInfo = notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            //应用处于前台时的远程推送接受
            //关闭U-Push自带的弹出框
            [UMessage setAutoAlert:NO];
            //必须加这句代码
            [UMessage didReceiveRemoteNotification:userInfo];
            
        }else{
            //应用处于前台时的本地推送接受
        }
    } else {
        // Fallback on earlier versions
    }
    
    //当应用处于前台时提示设置，需要哪个可以设置哪一个
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}

//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler API_AVAILABLE(ios(10.0)){
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
    }else{
        //应用处于后台时的本地推送接受
    }
    
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
