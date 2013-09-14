//
//  KOMCarGoalViewController.m
//  Kompax
//
//  Created by Bryan on 13-9-13.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import "KOMCarGoalViewController.h"

@interface KOMCarGoalViewController ()

@end

@implementation KOMCarGoalViewController

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
    // Do any additional setup after loading the view from its nib.
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
