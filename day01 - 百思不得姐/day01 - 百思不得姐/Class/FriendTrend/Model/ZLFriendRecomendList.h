//
//  ZLFriendRecomendList.h
//  day01 - 百思不得姐
//
//  Created by admin on 16/9/18.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLFriendRecomendList : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic,assign) NSInteger id;
@property (nonatomic,assign) NSInteger count;


// 储存已下载的用户数据
@property (nonatomic,strong) NSMutableArray *users;

// 粗糙数据的count属性
@property (nonatomic,assign) NSInteger TotalUser;


- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)listWithDict:(NSDictionary *)dict;




@end
