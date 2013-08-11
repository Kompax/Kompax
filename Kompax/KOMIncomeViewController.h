//
//  KOMIncomeViewController.h
//  Kompax
//
//  Created by Bryan on 13-7-27.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KOMAccountTableViewController.h"
#import "KOMTimePickerViewController.h"
#import "KOMMemberTableViewController.h"
#import "KOMIncomeCategoryTableViewController.h"


@interface KOMIncomeViewController : UIViewController<KOMAccountTableViewDelegate,KOMTimePickerDelegate,KOMMemberTableViewDelegate,KOMIncomeCategoryDelegate>
{
@private
    double planedEarn;              //本月计划支出
    double didEarn;                 //本月已支出
}

@property (strong, nonatomic) IBOutlet UITextField *cash;
@property (strong, nonatomic) IBOutlet UILabel *accountLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong,nonatomic) IBOutlet UILabel *memberLabel;
@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;

-(void)calculateAndDraw ;

@end
