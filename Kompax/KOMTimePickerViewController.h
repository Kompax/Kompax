//
//  KOMTimePickerViewController.h
//  Kompax
//
//  Created by Bryan on 13-7-29.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KOMTimePickerDelegate <NSObject>

-(void)changeTimeText:(NSString *)text;

@end

@interface KOMTimePickerViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIDatePicker *timePicker;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property(strong,nonatomic) NSDateFormatter *formatter;
@property(assign,nonatomic) id<KOMTimePickerDelegate> delegate;


@end
