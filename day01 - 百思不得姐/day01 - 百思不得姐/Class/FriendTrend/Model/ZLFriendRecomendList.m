//
//  ZLFriendRecomendList.m
//  day01 - 百思不得姐
//
//  Created by admin on 16/9/18.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import "ZLFriendRecomendList.h"

@implementation ZLFriendRecomendList



- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
    }
    return self;
    
}

+ (instancetype)listWithDict:(NSDictionary *)dict{
    
    
    return [[self alloc]initWithDict:dict];
    
    
}
@end
