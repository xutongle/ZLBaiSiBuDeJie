//
//  Comment.m
//  day01 - 百思不得姐
//
//  Created by admin on 16/10/10.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import "Comment.h"

@implementation Comment


- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
        User *user = [[User alloc]initWithDict:dict[@"user"]];
        self.user = user;
  
      
    }
    return self;
}


+ (instancetype)commentWithDict:(NSDictionary *)dict{
    
    return [[self alloc]initWithDict:dict] ? [[self alloc] initWithDict:dict] : @"";
    
    
    
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    //忽略不需要的字典的属性
    
}


// 新的ID代替就得id，避免系统重复.
- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
        return;
    }
    [super setValue:value forKey:key];
}











//- (void)setValue:(id)value forKey:(NSString *)key{
//    if ([key isEqualToString:@"user"]) {
//        
//        User *user = [[User alloc]initWithDict:(NSDictionary *)value[@"user"]];
//        
//        NSLog(@"dict == %@",(NSDictionary *)value[@"user"]);
//        
//        self.user = user;
//     
//        return;
//    }
//    [super setValue:value forKey:key];
//}
//


@end
