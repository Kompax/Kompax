//
//  KOMRegisterViewController.h
//  Kompax
//
//  Created by Bryan on 13-7-19.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KOMRegisterViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *mailText;
@property (strong, nonatomic) IBOutlet UITextField *passwordText;
@property (strong, nonatomic) IBOutlet UITextField *againText;

- (IBAction)backgroundTap:(id)sender;
- (IBAction)textFieldDoneEditing:(id)sender;

@end
