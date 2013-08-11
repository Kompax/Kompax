//
//  KOMAppDelegate.h
//  Kompax
//
//  Created by Bryan on 13-7-17.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@interface KOMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic) AFHTTPClient *client;   //全局的http客户请求

@end
