//
//  Comment.h
//  day01 - 百思不得姐
//
//  Created by admin on 16/10/10.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"


@interface Comment : NSObject



@property (nonatomic,copy) NSString *ID;
//评论内容
@property (nonatomic,copy) NSString *content;

@property (nonatomic,copy) NSString *like_count;


@property (nonatomic,strong) User *user;

//评论帖子的高度
@property (nonatomic,assign) CGFloat commentH;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
