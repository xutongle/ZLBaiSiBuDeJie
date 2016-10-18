//
//  User.h
//  day01 - 百思不得姐
//
//  Created by admin on 16/10/10.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

//用户头像
@property (nonatomic,copy) NSString *profile_image;
//用户昵称
@property (nonatomic,copy) NSString *username;
//用户性别
@property (nonatomic,copy) NSString *sex;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
