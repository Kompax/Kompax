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

static NSString *baseURL = @"http://1.guhaiyue.sinaapp.com/index.php";  //基础URL地址

@implementation KOMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //初始化并正确设置client的值
     NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"390840760@qq.com",@"email",@"123456",@"password", nil];

    NSURL *url = [NSURL URLWithString:baseURL];
    _client = [[AFHTTPClient alloc]initWithBaseURL:url];
    [_client setParameterEncoding:AFJSONParameterEncoding];
    
    //Login/login
    //
    NSMutableURLRequest *request = [_client requestWithMethod:@"POST" path:@"Login/login" parameters:dict];

    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"%@",JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"%@",error);
    }];
    
    
    [operation start];
    
    
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
