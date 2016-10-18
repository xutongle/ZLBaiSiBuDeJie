//
//  ZLSquare.m
//  day01 - 百思不得姐
//
//  Created by admin on 16/10/14.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import "ZLSquare.h"

@implementation ZLSquare

- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    //过滤不需要的value
}

@end
