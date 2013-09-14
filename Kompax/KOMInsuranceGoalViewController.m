//
//  KOMInsuranceGoalViewController.m
//  Kompax
//
//  Created by Bryan on 13-9-13.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import "KOMInsuranceGoalViewController.h"

@interface KOMInsuranceGoalViewController ()

@end

@implementation KOMInsuranceGoalViewController

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
    
    _timeArray = [NSArray arrayWithObjects:_monthButton,_seasonButton,_yearButton, nil];
    _timeSelect = 0;    //时间段默认为月
    _insuranceArray = [NSArray arrayWithObjects:_ageInsurance,_healthInsurance,_accidentInsurance,nil];
    _insuranceSelect = 0;   //保险类型默认为人寿险
    
    //保险按钮设置点击事件
    for(int i = 0;i<3;i++) {
        UILabel *tempInsuranceLabel = [_insuranceArray objectAtIndex:i];
        [tempInsuranceLabel setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reloadInsuranceButton:)];
        [tempInsuranceLabel addGestureRecognizer:tap];
    }
    
    for(int i = 0;i<3;i++) {
        UILabel *tempTimeLabel = [_timeArray objectAtIndex:i];
        [tempTimeLabel setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reloadTimeButton:)];
        [tempTimeLabel addGestureRecognizer:tap];
    }
    
    
    [self reloadTimeButton:[_monthButton.gestureRecognizers objectAtIndex:0]];
    [self reloadInsuranceButton:[_ageInsurance.gestureRecognizers objectAtIndex:0]];
}

-(void)reloadTimeButton:(id)sender {
    
    _timeSelect = ((UITapGestureRecognizer *)sender).view.tag - 100;
    
    for(int i = 0;i<3;i++) {
        UILabel *tempTimeLabel = [_timeArray objectAtIndex:i];
        if (i == _timeSelect) {
            
            [tempTimeLabel setTextColor:[UIColor whiteColor]];
            [tempTimeLabel setBackgroundColor:[UIColor colorWithRed:248/255.0 green:149/255.0 blue:64/255.0 alpha:1.0]];
        }
        else {

            [tempTimeLabel setBackgroundColor:[UIColor colorWithRed:238/255.0 green:241/255.0 blue:236/255.0 alpha:1.0]];
            [tempTimeLabel setTextColor:[UIColor blackColor]];
        }
    }
}

-(void)reloadInsuranceButton:(id)sender {
    
    _insuranceSelect = ((UITapGestureRecognizer *)sender).view.tag;
    
    for(int i = 0;i<3;i++) {
        UILabel *tempInsuranceLaebel = [_insuranceArray objectAtIndex:i];
        if (i == _insuranceSelect) {
            
            [tempInsuranceLaebel setTextColor:[UIColor colorWithRed:246/255.0 green:186/255.0 blue:168/255.0 alpha:1.0]];
        }
        else {
            [tempInsuranceLaebel setTextColor:[UIColor blackColor]];
        }
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backgroundTap:(id)sender {
    [sender resignFirstResponder];
}
@end
