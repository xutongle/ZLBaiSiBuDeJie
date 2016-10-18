//
//  User.m
//  day01 - 百思不得姐
//
//  Created by admin on 16/10/10.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
    }
    return self;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    //忽略不需要的字典的属性
    
}


@end
