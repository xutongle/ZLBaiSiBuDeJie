//
//  ZLFriendRecommendUser.h
//  day01 - 百思不得姐
//
//  Created by admin on 16/9/21.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLFriendRecommendUser : NSObject
/*  ***** API *****
 "fans_count" = 100152;
 gender = 0;
 header = "http://wimg.spriteapp.cn/profile/20160405162926.jpg";
 introduction = "";
 "is_follow" = 0;
 "is_vip" = 0;
 "screen_name" = "30\U79d2\U61c2\U8f66";
 "tiezi_count" = 693;
 uid = 14026235;
 */


@property (nonatomic,assign) NSInteger uid;
//@property (nonatomic,copy) NSString *uid;
//@property (nonatomic,copy) NSString *fans_count;
@property (nonatomic,assign) NSInteger fans_count;
@property (nonatomic,assign) NSInteger is_follow;
@property (nonatomic,assign) NSInteger is_vip;
@property (nonatomic,assign) NSInteger gender;

@property (nonatomic,copy) NSString *screen_name;
@property (nonatomic,copy) NSString *header;
@property (nonatomic,copy) NSString *introduction;
@property (nonatomic,assign) NSInteger tiezi_count;
@property (nonatomic,assign) NSInteger total;
@property (nonatomic,assign) NSInteger next_page;
@property (nonatomic,assign) NSInteger total_page;



- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)userWithDict:(NSDictionary *)dict;

@end
