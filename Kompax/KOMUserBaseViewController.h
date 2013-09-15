//
//  KOMUserBaseViewController.h
//  Kompax
//
//  Created by Bryan on 13-9-15.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KOMUserBaseViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *deposit;
@property (strong, nonatomic) IBOutlet UILabel *credit;
@property (strong, nonatomic) IBOutlet UILabel *net;
@property (strong, nonatomic) IBOutlet UILabel *stock;
@property (strong, nonatomic) IBOutlet UILabel *managing;
@property (strong, nonatomic) IBOutlet UILabel *receive;
@property (strong, nonatomic) IBOutlet UILabel *pay;

@property (strong, nonatomic) IBOutlet UIView *display;
@property (strong, nonatomic) IBOutlet UILabel *head;

@property(strong,nonatomic) UIViewController *depositVC;
@property(strong,nonatomic) UIViewController *creditVC;
@property (strong,nonatomic) UIViewController *netVC;
@property (strong,nonatomic) UIViewController *stockVC;
@property (strong,nonatomic) UIViewController *managingVC;
@property (strong,nonatomic) UIViewController *receiveVC;
@property (strong,nonatomic) UIViewController *payVC;

@end
