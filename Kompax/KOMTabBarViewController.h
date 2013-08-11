//
//  KOMTabBarViewController.h
//  Kompax
//
//  Created by Bryan on 13-7-23.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KOMMainPageViewController.h"

@interface KOMTabBarViewController : UITabBarController

@property (strong,nonatomic) UIImageView *selectView;   //选中框
@property  NSMutableArray *buttonArray;                 //存放tabbaritem按钮

@end
