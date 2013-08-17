//
//  KOMAppDelegate.m
//  Kompax
//
//  Created by Bryan on 13-7-17.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import "KOMAppDelegate.h"
#import "AFNetworking.h"
#import "KOMConstants.h"

//服务器基础地址
static NSString *baseURL = @"http://1.guhaiyue.sinaapp.com/index.php";

@implementation KOMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //初始化本地文件account_list，用于存储用户已登录历史账户信息文件
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    _accountListFilePath = [documentsDirectory stringByAppendingPathComponent:ACCOUNT_LIST];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];            //文件管理者
    
    //第一次运行程序时，初始化account_list文件
    if (![fileManager fileExistsAtPath:_accountListFilePath]) {
        [NSKeyedArchiver archiveRootObject:nil toFile:_accountListFilePath];
    }
    
    
    //初始化网络信息
    NSURL *url = [NSURL URLWithString:baseURL];
    _client = [[AFHTTPClient alloc]initWithBaseURL:url];
    [_client setParameterEncoding:AFJSONParameterEncoding];
    
    return YES;
}

-(void)customizeiPhoneTheme
{
    [[UIApplication sharedApplication]
     setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:NO];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
