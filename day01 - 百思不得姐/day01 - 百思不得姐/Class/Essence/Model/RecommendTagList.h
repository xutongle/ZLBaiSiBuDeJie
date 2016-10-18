//
//  RecommendTagList.h
//  day01 - 百思不得姐
//
//  Created by admin on 16/9/23.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 "image_list" = "http://img.spriteapp.cn/ugc/2015/01/09/183519_52127.png";
 "is_default" = 0;
 "is_sub" = 0;
 "sub_number" = 119441;
 "theme_id" = 335;
 "theme_name" = "\U7537\U795e";
 */

@interface RecommendTagList : NSObject

@property (nonatomic,copy) NSString *image_list;
@property (nonatomic,assign) NSInteger is_default;
@property (nonatomic,assign) NSInteger is_sub;
@property (nonatomic,assign) NSInteger sub_number;
@property (nonatomic,assign) NSInteger theme_id;
@property (nonatomic,copy) NSString *theme_name;



- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)tagWithDict:(NSDictionary *)dict;


@end
