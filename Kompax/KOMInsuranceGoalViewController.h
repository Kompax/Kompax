//
//  KOMInsuranceGoalViewController.h
//  Kompax
//
//  Created by Bryan on 13-9-13.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KOMInsuranceGoalViewController : UIViewController

- (IBAction)backgroundTap:(id)sender;

//月、季、年选项框
@property (strong, nonatomic) IBOutlet UILabel *monthButton;
@property (strong, nonatomic) IBOutlet UILabel *seasonButton;
@property (strong, nonatomic) IBOutlet UILabel *yearButton;
@property (strong,nonatomic) NSArray *timeArray;
@property (assign,nonatomic) int timeSelect;

//人寿险、健康险、意外险选项框
@property (strong, nonatomic) IBOutlet UILabel *ageInsurance;
@property (strong, nonatomic) IBOutlet UILabel *healthInsurance;
@property (strong, nonatomic) IBOutlet UILabel *accidentInsurance;
@property (strong,nonatomic) NSArray *insuranceArray;
@property (assign,nonatomic) int insuranceSelect;




@end
