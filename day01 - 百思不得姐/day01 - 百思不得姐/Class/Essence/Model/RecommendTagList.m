//
//  RecommendTagList.m
//  day01 - 百思不得姐
//
//  Created by admin on 16/9/23.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import "RecommendTagList.h"

@implementation RecommendTagList


- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
    
}

+ (instancetype)tagWithDict:(NSDictionary *)dict{
    
    
    return [[self alloc]initWithDict:dict] ? [[self alloc] initWithDict:dict] : @"";
}


@end
