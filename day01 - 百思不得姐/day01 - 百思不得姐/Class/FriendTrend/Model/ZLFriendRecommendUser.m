//
//  ZLFriendRecommendUser.m
//  day01 - 百思不得姐
//
//  Created by admin on 16/9/21.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import "ZLFriendRecommendUser.h"

@implementation ZLFriendRecommendUser

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
    }
    return self;
    
}

+ (instancetype)userWithDict:(NSDictionary *)dict{
    
    
    return [[self alloc]initWithDict:dict];
    
    
}

@end
