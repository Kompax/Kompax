//
//  KOMDraw.h
//  Kompax
//
//  Created by Bryan on 13-7-30.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KOMConstants.h"

@interface KOMBarDraw : UIControl

@property (assign,nonatomic) double larger;     //larger是计划支出与当前支出中较大者
@property (assign,nonatomic) double smaller;    //smaller是计划支出与当前支出中较小者
@property (assign,nonatomic) OverspendMode drawingMode;   //drawingMode记录画图模式（超过或者没超过计划）
@property (assign,nonatomic) BarMode mode;

@end
