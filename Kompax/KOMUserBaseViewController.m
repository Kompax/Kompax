//
//  KOMUserBaseViewController.m
//  Kompax
//
//  Created by Bryan on 13-9-15.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import "KOMUserBaseViewController.h"
#import "KOMDepositInforViewController.h"

@interface KOMUserBaseViewController ()

@end

@implementation KOMUserBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *depositTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loadDeposit)];
    [_deposit setUserInteractionEnabled:YES];
    [_deposit addGestureRecognizer:depositTap];
    
    UITapGestureRecognizer *creditTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loadCredit)];
    [_credit setUserInteractionEnabled:YES];
    [_credit addGestureRecognizer:creditTap];
    
    UITapGestureRecognizer *netTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loadNet)];
    [_net setUserInteractionEnabled:YES];
    [_net addGestureRecognizer:netTap];
    
    UITapGestureRecognizer *stockTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loadStock)];
    [_stock setUserInteractionEnabled:YES];
    [_stock addGestureRecognizer:stockTap];
    
    UITapGestureRecognizer *managingTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loadManaging)];
    [_managing setUserInteractionEnabled:YES];
    [_managing addGestureRecognizer:managingTap];
    
    UITapGestureRecognizer *receiveTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loadReceive)];
    [_receive setUserInteractionEnabled:YES];
    [_receive addGestureRecognizer:receiveTap];
    
    UITapGestureRecognizer *payTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loadPay)];
    [_pay setUserInteractionEnabled:YES];
    [_pay addGestureRecognizer:payTap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(iniHead) name:@"iniHead" object:nil];
}

-(void)loadDeposit {
   _depositVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DepositInfo"];
    _depositVC.view.frame = CGRectMake(0, 0, 320, 480);
    
    [_head setText:@"账户信息-储蓄卡"];
    [self.display addSubview:_depositVC.view];
}

-(void)loadCredit {
    _creditVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CreditInfo"];
    _creditVC.view.frame = CGRectMake(0, 0, 320, 480);
    
    [_head setText:@"账户信息-信用卡"];
    [self.display addSubview:_creditVC.view];
}

-(void)loadNet {
    _netVC = [self.storyboard instantiateViewControllerWithIdentifier:@"NetInfo"];
    _netVC.view.frame = CGRectMake(0, 0, 320, 480);
    
    [_head setText:@"账户信息-网上账户"];
    [self.display addSubview:_netVC.view];
}

-(void)loadStock {
    _stockVC = [self.storyboard instantiateViewControllerWithIdentifier:@"StockInfo"];
    _stockVC.view.frame = CGRectMake(0, 0, 320, 480);
    [_head setText:@"账户信息-股票账户"];
    [self.display addSubview:_stockVC.view];
}

-(void)loadManaging {
    _managingVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ManagingInfo"];
    _managingVC.view.frame = CGRectMake(0, 0, 320, 480);
    [_head setText:@"账户信息-理财账户"];
    [self.display addSubview:_managingVC.view];
}

-(void)loadReceive {
    _receiveVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ReceiveInfo"];
    _receiveVC.view.frame = CGRectMake(0, 0, 320, 480);
    [_head setText:@"账户信息-应收款"];
    [self.display addSubview:_receiveVC.view];
}

-(void)loadPay {
    _payVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PayInfo"];
    _payVC.view.frame = CGRectMake(0, 0, 320, 480);
    [_head setText:@"账户信息-应付款"];
    [self.display addSubview:_payVC.view];
}

-(void)iniHead {
    [self.head setText:@"账户信息"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
