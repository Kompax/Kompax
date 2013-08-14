//
//  NSMutableDictionary+MutableDeepCopy.m
//  Kompax
//
//  Created by Bryan on 13-8-15.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import "NSMutableDictionary+MutableDeepCopy.h"

@implementation NSMutableDictionary (MutableDeepCopy)

-(NSMutableDictionary *)mutableDeepCopy {
    
    NSMutableDictionary *ret = [[NSMutableDictionary alloc]initWithCapacity:[self count]];
    
    NSArray *keys = [self allKeys];
    
    for(id key in keys) {
        
        id oneValue = [self valueForKey:key];  //设置oneValue为源值
        
        id oneCopy = nil;
        
        if ([oneValue respondsToSelector:@selector(mutableDeepCopy)])
            
            oneCopy = [oneValue mutableDeepCopy];
        
        else if ([oneValue respondsToSelector:@selector(mutableCopy)])
            
            oneCopy = [oneValue mutableCopy];
        
        if (oneCopy == nil)
            
            oneCopy = [oneValue copy];
        
        [ret setValue:oneCopy forKey:key];
        
    }
    
    return ret;
}


@end
