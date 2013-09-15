//
//  KOMPayInforViewController.m
//  Kompax
//
//  Created by Bryan on 13-9-15.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import "KOMPayInforViewController.h"

@interface KOMPayInforViewController ()

@end

@implementation KOMPayInforViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)goBack:(id)sender {
     [[NSNotificationCenter defaultCenter] postNotificationName:@"iniHead" object:nil];
    [self.view removeFromSuperview];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _scrollView.contentSize = CGSizeMake(300, 380);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
