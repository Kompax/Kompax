//
//  Constants.h
//  Kompax
//
//  Created by Bryan on 13-7-31.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ACCOUNT_LIST        @"account_list.arc"     //用户历史登录账号储存文件名

#define ACCOUNT_INFO    @"accountInfo"
#define EMAIL           @"email"
#define PASSWORD        @"password"

//NSUserDefaults关键字
#define LAST_ACCOUNT    @"last_account"      //上一次登录用户名


//登录阶段服务器反馈信息
#define PASSWORD_WRONG  @"Email or password is wrong!"
#define ALREADY_LOGGIN  @"This user has already logged in!"
#define SUCCESS         @"Succeeded!"


typedef enum {
    kNotOverspent = 0,
    kOverspent,
    kNotOverearned,
    kOverearned
} OverspendMode;

typedef enum {
    kCostMode = 0,
    kEarnMode
} BarMode;



@interface KOMConstants : NSObject

@end
