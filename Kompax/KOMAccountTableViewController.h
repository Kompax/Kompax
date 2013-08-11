//
//  KOMAccountTableViewController.h
//  Kompax
//
//  Created by Bryan on 13-7-28.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KOMAccountTableViewDelegate <NSObject>

-(void)changeAccount:(NSString *)text;

@end

@interface KOMAccountTableViewController : UITableViewController

@property (strong,nonatomic) NSMutableArray *data;
@property (assign,nonatomic) id<KOMAccountTableViewDelegate> delegate;

@end
