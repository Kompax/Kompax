//
//  KOMTimePickerViewController.m
//  Kompax
//
//  Created by Bryan on 13-7-29.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import "KOMTimePickerViewController.h"

static NSString *GLOBAL_TIMEFORMAT = @"yyyy-MM-dd HH:mm:ss";

@interface KOMTimePickerViewController ()

@end

@implementation KOMTimePickerViewController

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
    self.title = @"时间" ;
    //初始化formatter，一定要设置显示模式，否则无法显示
    NSTimeZone* localzone = [NSTimeZone localTimeZone];
    _formatter = [[NSDateFormatter alloc]init];
    [_formatter setDateFormat:GLOBAL_TIMEFORMAT];
    [_formatter setTimeZone:localzone];
    
    //初始化label时间
    _timeLabel.text = [_formatter stringFromDate:_timePicker.date];
    
    [_timePicker addTarget:self action:@selector(timeChanged) forControlEvents:UIControlEventValueChanged];
    
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(backUp:)];
    self.navigationItem.leftBarButtonItem = back;
    
    UIBarButtonItem *finish = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(finish:)];
    self.navigationItem.rightBarButtonItem = finish;

    
}

-(void)timeChanged {
    
    //设置本地时区
    self.timeLabel.text = [_formatter stringFromDate:self.timePicker.date];
}

//返回函数
- (void)backUp:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//完成函数
-(void)finish:(id)sender {
    [self.delegate changeTimeText:self.timeLabel.text];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
