//
//  KOMCircleDraw.m
//  Kompax
//
//  Created by Bryan on 13-8-2.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import "KOMCircleDraw.h"

@implementation KOMCircleDraw

static double kSmallestRadius = 60;
static double kLargestRadius = 115;

static double kCostCircleY = 250;       //支出圆圆心Y坐标
static double kEarnCircleY = 264;       //收入圆圆心Y坐标
static double kFontSize = 15;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    _totalEarn = 3000;
    _totalCost = 1200;
    
    //初始化常量字符串
    _costStateLabel = [NSString stringWithFormat:@"本月支出"];
    _earnStateLabel = [NSString stringWithFormat:@"本月收入"];
    _difStateLabel= [NSString stringWithFormat:@"收支差额"];
    
    double absDif,costRadius,earnRadius;
    double movement = 0;        //差额圆偏移量
    
    if(_totalCost == _totalEarn) {
        _isLargerEarn = YES;
        earnRadius = kSmallestRadius+20;
        costRadius = kSmallestRadius+20;
    }
    else if (_totalEarn > _totalCost ) {
        _isLargerEarn = YES;

        if (_totalEarn/3 >= _totalCost) {
            earnRadius = kLargestRadius;
            costRadius = kSmallestRadius;
        }
        else {
            double smallest = _totalEarn/3;  //设立最小边界
            costRadius = (kSmallestRadius-20) * _totalCost / smallest;
            earnRadius = (kSmallestRadius-20) * _totalEarn / smallest;
        }
        
    }   //收入大于支出
    else {
        _isLargerEarn = NO;
        
        if (_totalCost/3 >= _totalEarn) {
            costRadius = kLargestRadius;
            earnRadius = kSmallestRadius;
        }
        else {
            double smallest = _totalCost/3;  //设立最小边界
            earnRadius = (kSmallestRadius-20) * _totalEarn / smallest;
            costRadius = (kSmallestRadius-20) * _totalCost / smallest;
        }
    }   //支出大于收入

    if (fabs(earnRadius-costRadius)>30)
        absDif = fabs(earnRadius-costRadius);    //差额绝对值
    else
        absDif = 30;

    /*画图*/
    //设置字体
    UIFont *costNumberFont = [UIFont boldSystemFontOfSize:9.5+costRadius/7-3];
    UIFont *earnNumberFont= [UIFont boldSystemFontOfSize:9.5+earnRadius/7-3];
    UIFont *difNumberFont= [UIFont boldSystemFontOfSize:9.5+absDif/7-3];

    CGContextRef context=UIGraphicsGetCurrentContext();

    //画支出半圆并写字--------------------------------------------------------------------------------------
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:248/255.0 green:149/255.0 blue:64/255.0 alpha:1.0].CGColor);//填充颜色
    CGContextFillEllipseInRect(context,CGRectMake(320-costRadius,kCostCircleY-costRadius,2*costRadius, 2*costRadius));
    
    //写字
    NSString *costLabel  = [self conversion:_totalCost];
    CGRect costDrawRect = CGRectMake(320-costRadius, kCostCircleY-kFontSize/2, costRadius , kFontSize);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);//填充颜色
    [costLabel drawInRect:costDrawRect withFont:costNumberFont lineBreakMode:NSLineBreakByCharWrapping alignment:NSTextAlignmentCenter];
    


    //画收入半圆-------------------------------------------------------------------------------------------
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:105/255.0 green:167/255.0 blue:203/255.0 alpha:1.0].CGColor);//设置线的颜色
    CGContextFillEllipseInRect(context,CGRectMake(-earnRadius,kEarnCircleY-earnRadius,2*earnRadius, 2*earnRadius));
    
    //写字
    NSString *earnLabel  = [self conversion:_totalEarn];
    CGRect earnDrawRect = CGRectMake(0, kEarnCircleY-kFontSize/2, earnRadius, kFontSize);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);//填充颜色
    [earnLabel drawInRect:earnDrawRect withFont:earnNumberFont lineBreakMode:NSLineBreakByCharWrapping alignment:NSTextAlignmentCenter];

    if (_isLargerEarn) {
        movement = 0;
    }
    else {
        movement = -70;
    }

    //画差额圆---------------------------------------------------------------------------------------------
    if (_isLargerEarn) {
        CGContextSetFillColorWithColor(context, [UIColor colorWithRed:84/255.0 green:152/255.0 blue:69/255.0 alpha:1.0].CGColor);//盈余填充颜色：绿色
    }
    else {
        CGContextSetFillColorWithColor(context, [UIColor colorWithRed:128/255.0 green:135/255.0 blue:147/255.0 alpha:1.0].CGColor);//亏损填充颜色: 灰色
    }
    CGContextFillEllipseInRect(context,CGRectMake(145+movement,280,2*absDif, 2*absDif));
    //写字
    NSString *difLabel = [self conversion:fabs(_totalEarn-_totalCost)];
    CGRect difLabelRect = CGRectMake(145+movement+3, 280+absDif-kFontSize/2, 2*absDif-kFontSize/2, kFontSize);
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);//填充颜色
    [difLabel drawInRect:difLabelRect withFont:difNumberFont lineBreakMode:NSLineBreakByCharWrapping alignment:NSTextAlignmentCenter];
    
    //写常量字符串-------------------------------------------------------------------------------------------
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:171/255.0 green:175/255.0 blue:183/255.0 alpha:1.0].CGColor);//灰色
    UIFont *stateFont = [UIFont boldSystemFontOfSize:kFontSize];
    CGRect costStateRect = CGRectMake(320-costRadius*4/5-85, kCostCircleY-costRadius*3/5, 80, 12);
    CGRect earnStateRect = CGRectMake(earnRadius*0.8, kEarnCircleY-earnRadius*3/5, 80, 12);
    CGRect difStateRect = CGRectMake(75 + movement, 280+absDif*1.25, 80, 12);
    [_costStateLabel drawInRect:costStateRect withFont:stateFont lineBreakMode:NSLineBreakByCharWrapping alignment:NSTextAlignmentCenter];
    [_earnStateLabel drawInRect:earnStateRect withFont:stateFont lineBreakMode:NSLineBreakByCharWrapping alignment:NSTextAlignmentCenter];
    [_difStateLabel drawInRect:difStateRect withFont:stateFont lineBreakMode:NSLineBreakByCharWrapping alignment:NSTextAlignmentCenter];

    CGContextStrokePath(context);//把线在界面上绘制出来
}

//换算
-(NSString *)conversion:(double)num {
    
    //大于1兆的，直接以“兆”做单位，小数点后精确两位
    if (num > 1000000000000) {
        double temp = round(num/10000000000)/100;
        NSString *res = [NSString stringWithFormat:@"%2.f兆",temp];
        return res;
    }
    //大于1亿的，直接以“亿”做单位，小数点后精确两位    
    if (num > 100000000) {
        double temp = round(num/1000000)/100;
        NSString *res = [NSString stringWithFormat:@"%2.f亿",temp];
        return res;
    }
    //大于1万的，直接以“万”做单位，小数点后精确两位
    else if (num > 10000) {
        
        double temp = round(num/100)/100;
        NSString *res = [NSString stringWithFormat:@"%2.f万",temp];
        return res;
    }
    return  [NSString stringWithFormat:@"%.2f",num];
}

@end
