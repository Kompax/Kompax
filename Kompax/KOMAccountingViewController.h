//
//  KOMAccountingViewController.h
//  Kompax
//
//  Created by Bryan on 13-7-22.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableView+DataSourceBlocks.h"

#import "KOMCostViewController.h"
#import "KOMIncomeViewController.h"
#import "KOMDebitViewController.h"
#import "KOMCreditViewController.h"

@class TableViewWithBlock;
@interface KOMAccountingViewController : UIViewController{
    BOOL isOpened;
}
@property (strong,nonatomic) UIViewController *currentVC;

@property (strong, nonatomic) IBOutlet UIView *accView;

@property (retain, nonatomic) IBOutlet UIButton *openButton;
@property (retain, nonatomic) IBOutlet UILabel *inputTextField;
@property (retain, nonatomic) IBOutlet TableViewWithBlock *tb;
- (IBAction)changeOpenStatus:(id)sender;

@property (strong,nonatomic)   NSArray *way;
@property (strong,nonatomic) NSArray *controllers;


- (IBAction)backgroundTap:(id)sender;

@end
