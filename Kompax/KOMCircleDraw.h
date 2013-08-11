//
//  KOMCircleDraw.h
//  Kompax
//
//  Created by Bryan on 13-8-2.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KOMCircleDraw : UIControl


@property (assign,nonatomic) double totalCost;
@property (assign,nonatomic) double totalEarn;
@property (assign,nonatomic) BOOL isLargerEarn;     //收入是否大于支出

@property (copy,nonatomic) NSString *costStateLabel;    //"本月支出"字符串
@property (copy,nonatomic) NSString *earnStateLabel;    //"本月收入"字符串
@property (copy,nonatomic) NSString *difStateLabel;     //"收支差额"字符串

@end
