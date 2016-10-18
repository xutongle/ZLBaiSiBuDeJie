//
//  ZLSquare.h
//  day01 - 百思不得姐
//
//  Created by admin on 16/10/14.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLSquare : NSObject

//“我”内容的头像
@property (nonatomic,copy) NSString *icon;

@property (nonatomic,copy) NSString *name;

@property (nonatomic,copy) NSString *url;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
