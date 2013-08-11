//
//  KOMDebitViewController.h
//  Kompax
//
//  Created by Bryan on 13-7-27.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KOMAccountTableViewController.h"
#import "KOMTimePickerViewController.h"
#import "KOMMemberTableViewController.h"
#import "KOMCreditorTableViewController.h"
#import "KOMCategoryTableViewController.h"
#import "KOMRepaymentViewController.h"

@interface KOMDebitViewController : UIViewController<KOMAccountTableViewDelegate,KOMTimePickerDelegate,KOMCreditorTableViewDelegate,KOMCategoryTableViewDelegate>


@property (strong, nonatomic) IBOutlet UITextField *cash;

@property (strong, nonatomic) IBOutlet UILabel *accountLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong,nonatomic) IBOutlet UILabel *creditorLabel;
@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;
@property(assign,nonatomic) int category;                             //还款类别tag
@property(strong,nonatomic) KOMRepaymentViewController *repayVC;      //还款界面控制器

- (IBAction)bgTap:(id)sender;

@end
