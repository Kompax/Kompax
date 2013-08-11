//
//  KOMCostViewController.h
//  Kompax
//
//  Created by Bryan on 13-7-27.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KOMAccountTableViewController.h"
#import "KOMTimePickerViewController.h"
#import "KOMMemberTableViewController.h"
#import "KOMCategoryTableViewController.h"



@interface KOMCostViewController : UIViewController<KOMAccountTableViewDelegate,KOMTimePickerDelegate,KOMMemberTableViewDelegate,KOMCategoryTableViewDelegate>
{
    @private
    double planedCost;              //本月计划支出
    double didCost;                 //本月已支出
}

@property (strong, nonatomic) IBOutlet UITextField *cash;
@property (strong, nonatomic) IBOutlet UILabel *accountLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong,nonatomic) IBOutlet UILabel *memberLabel;
@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;

-(void)calculateAndDraw ;

@end
