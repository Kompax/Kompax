//
//  KOMDraw.m
//  Kompax
//
//  Created by Bryan on 13-7-30.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import "KOMBarDraw.h"

@implementation KOMBarDraw

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
    if (_larger == 0) {
        return;
    }
    
    //获取画布
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //计算大小矩形的大小
    double large = 160;
    double small = large * _smaller / _larger ;
    
    CGRect largerRect = CGRectMake(135, 107, large, 12);
    CGRect smallRect = CGRectMake(135, 107, small, 12);

    if (_drawingMode == kNotOverspent || _drawingMode == kNotOverearned) {
        
        CGContextSetRGBFillColor(context, 195/255.0, 205/255.0, 215/255.0 , 1.0); //大底框颜色为灰色
        //填充大矩形
        CGContextFillRect(context,largerRect);
        
        //画灰线
        {
            CGContextSetLineWidth(context, 1.0);//画线宽度
            CGContextMoveToPoint(context, 135+large-1, 107+12);//画线起始点
            CGContextAddLineToPoint(context, 135+large-1, 107+12+5);//画线结束点，可这里添加多个结束点，就形成了线性连接的线段
            CGContextSetRGBStrokeColor(context, 195/255.0, 205/255.0, 215/255.0 , 1.0);
            CGContextStrokePath(context);//执行描画动作
        }
        //写灰字
        {
            CGContextSetLineWidth(context, 0.0);//去掉外框
            UIFont *font = [UIFont boldSystemFontOfSize:13];
            
            CGRect largeTextRect = CGRectMake(135+large-120, 107+12+5, 130, 15);
             CGContextAddRect(context, largeTextRect);
            NSString *largeText = [NSString stringWithFormat:@"%.2lf",_larger];

            [largeText drawInRect:largeTextRect withFont:font lineBreakMode:NSLineBreakByCharWrapping alignment:NSTextAlignmentRight];
            CGContextStrokePath(context);//执行描画动作
        }
        if (_drawingMode == kNotOverspent) {    
            if (_smaller / _larger <= 0.9) {
                CGContextSetRGBFillColor(context, 254/255.0, 125/255.0, 93/255.0 , 1.0); //小顶框颜色为橙色
                CGContextSetRGBStrokeColor(context, 254/255.0, 125/255.0, 93/255.0 , 1.0); //小顶框颜色为橙色
            }   //未超过80%，设置为橙色
            else {
                CGContextSetRGBFillColor(context, 253/255.0, 69/255.0, 53/255.0 , 1.0);  //小顶框颜色为红色
                CGContextSetRGBStrokeColor(context, 253/255.0, 69/255.0, 53/255.0 , 1.0);  //小顶框颜色为红色
            }   //超过80%，设置为鲜红色
        }//未超支模式
        else {
            if (_smaller / _larger <= 0.9) {
                //小顶框颜色为蓝色
                CGContextSetRGBFillColor(context, 0/255.0, 92/255.0, 255/255.0 , 1.0);
                CGContextSetRGBStrokeColor(context, 0/255.0, 92/255.0, 255/255.0 , 1.0);
            }   //未超过80%，设置为蓝色
            else {
                //小顶框颜色为靛青色
                CGContextSetRGBFillColor(context, 0/255.0, 194/255.0, 242/255.0 , 1.0);
                CGContextSetRGBStrokeColor(context, 0/255.0, 194/255.0, 242/255.0 , 1.0);
            }   //超过80%，设置为靛青色
            
        }//未超挣模式
        
        //填充小矩形
        CGContextFillRect(context,smallRect);
        
        //画红（蓝）线
        {
            CGContextSetLineWidth(context, 1.0);//画线宽度
            CGContextMoveToPoint(context, 135+small-1, 107-5);//画线起始点
            CGContextAddLineToPoint(context, 135+small-1, 107);//画线结束点，可这里添加多个结束点，就形成了线性连接的线段
            CGContextStrokePath(context);//执行描画动作
        }
        //写红（蓝）字
        {
            CGContextSetLineWidth(context, 0.0);//去掉外框
            UIFont *font = [UIFont boldSystemFontOfSize:13];
            
            CGRect smallTextRect = CGRectMake(135+small-120, 107-20, 130, 15);
            CGContextAddRect(context, smallTextRect);
            NSString *smallText = [NSString stringWithFormat:@"%.2lf",_smaller];
            
            [smallText drawInRect:smallTextRect withFont:font lineBreakMode:NSLineBreakByCharWrapping alignment:NSTextAlignmentRight];
            CGContextStrokePath(context);//执行描画动作
        }

    }   //未超支或者未超挣
    else {
        //画警告框
        if (_mode == kCostMode) {
            UIImage *bar = [UIImage imageNamed:@"超支"];
            [bar drawInRect:largerRect];
            
            //红色
            CGContextSetRGBFillColor(context, 1.0, 0, 0 , 1.0);
            CGContextSetRGBStrokeColor(context, 1.0, 0, 0, 1.0);
        }   //超支
        else {
            //绿色
            CGContextSetRGBFillColor(context, 0, 194/255.0, 0 , 1.0);
            CGContextSetRGBStrokeColor(context, 0, 194/255.0, 0, 1.0);
            //填充大矩形
            CGContextFillRect(context,largerRect);
            
        }   //超挣
        
        //画红(绿)线
        {
            CGContextSetLineWidth(context, 1.0);//画线宽度
            CGContextMoveToPoint(context, 135+large-1, 107-5);//画线起始点
            CGContextAddLineToPoint(context, 135+large-1, 107);//画线结束点，可这里添加多个结束点，就形成了线性连接的线段
            CGContextStrokePath(context);//执行描画动作
        }
        
        //写红(绿)字
        {
            CGContextSetLineWidth(context, 0.0);//去掉外框

            UIFont *font = [UIFont boldSystemFontOfSize:13];
            
            CGRect largeTextRect = CGRectMake(135+large-120, 107-20, 130, 15);
            CGContextAddRect(context, largeTextRect);
            NSString *largeText = [NSString stringWithFormat:@"%.2lf",_larger];
            
            [largeText drawInRect:largeTextRect withFont:font lineBreakMode:NSLineBreakByCharWrapping alignment:NSTextAlignmentRight];
            CGContextStrokePath(context);//执行描画动作
        }

        if (_mode == kEarnMode) {
            //靛青色
            CGContextSetRGBFillColor(context, 0, 194/255.0, 242/255.0 , 1.0);
            CGContextSetRGBStrokeColor(context, 0, 194/255.0, 242/255.0, 1.0);
        }
        //填充小矩形
        CGContextFillRect(context,smallRect);
        
        //画灰线
        {
            CGContextSetLineWidth(context, 1.0);//画线宽度
            CGContextMoveToPoint(context, 135+small-1, 107);//画线起始点
            CGContextAddLineToPoint(context, 135+small-1, 107+12+5);//画线结束点，可这里添加多个结束点，就形成了线性连接的线段
            CGContextSetRGBStrokeColor(context, 195/255.0, 205/255.0, 215/255.0 , 1.0);
            CGContextStrokePath(context);//执行描画动作
        }
        //写灰字
        {
            CGContextSetRGBFillColor(context, 195/255.0, 205/255.0, 215/255.0 , 1.0); //灰色字
            CGContextSetLineWidth(context, 0.0);//去掉外框
            UIFont *font = [UIFont boldSystemFontOfSize:13];
            
            CGRect smallTextRect = CGRectMake(135+small-120, 107+12+5, 130, 15);
            CGContextAddRect(context, smallTextRect);
            NSString *smallText = [NSString stringWithFormat:@"%.2lf",_smaller];
            
            [smallText drawInRect:smallTextRect withFont:font lineBreakMode:NSLineBreakByCharWrapping alignment:NSTextAlignmentRight];
            CGContextStrokePath(context);//执行描画动作
        }
    }   //超支或者超挣
}

@end
