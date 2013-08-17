//
//  KOMSettingAccountListTableViewController.h
//  Kompax
//
//  Created by Bryan on 13-8-17.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KOMSettingAccountListTableViewController : UITableViewController

@property (strong,nonatomic) NSMutableDictionary *accountList;
@property(strong,nonatomic) NSArray *keys;

@end
