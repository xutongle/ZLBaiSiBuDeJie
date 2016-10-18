//
//  WordTopics.h
//  day01 - 百思不得姐
//
//  Created by admin on 16/9/28.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Comment.h"

// 段子的模型数据
@interface WordTopics : NSObject
//typedef enum{
//    
//    WordTableViewTypeAll = 1,
//    WordTableViewTypeVideo = 41,
//    WordTableViewTypePicture = 10,
//    WordTableViewTypeSound = 31,
//    WordTableViewTypeWord =29,
//    
//} ZLWordTableViewType;



// ID
@property (nonatomic,copy) NSString *ID;

// 昵称
@property (nonatomic,copy) NSString *screen_name;

// 头像
@property (nonatomic,copy) NSString *profile_image;

// 发布时间
@property (nonatomic,copy) NSString *create_time;

//帖子内容
@property (nonatomic,copy) NSString *text;


// 顶贴数量
//@property (nonatomic,copy) NSString *ding;
@property (nonatomic,assign) int ding;

// 踩贴数量
//@property (nonatomic,copy) NSString *cai;
@property (nonatomic,assign) int cai;

// 转发数量
//@property (nonatomic,copy) NSString *repost;
@property (nonatomic,assign) int repost;

// 转发数量
//@property (nonatomic,copy) NSString *comment;
@property (nonatomic,assign) int comment;

@property (nonatomic,assign) NSInteger type;

// 帖子图片小图
@property (nonatomic,copy) NSString *image0;
// 帖子图片大图
@property (nonatomic,copy) NSString *image1;
// 帖子图片中图
@property (nonatomic,copy) NSString *image2;

@property (nonatomic,assign) NSInteger height;

@property (nonatomic,assign) NSInteger width;

//热评
@property (nonatomic,strong) NSArray *top_cmt;
//@property (nonatomic,strong) Comment *top_cmt;


/***** 额外的属性 *****/
//cell的高度
@property (nonatomic,assign) CGFloat cellHeigth;
//热门评论区的高度
@property (nonatomic,assign) CGFloat topCmtHeigth;

@property (nonatomic,assign) CGFloat textH;

@property (nonatomic,assign) CGRect pictureFrame;
@property (nonatomic,assign) CGRect voiceFrame;
@property (nonatomic,assign) CGRect videoFrame;


//视频的URL
@property (nonatomic,copy) NSString *videouri;
@property (nonatomic,copy) NSString *videotime;

//播放次数
@property (nonatomic,copy) NSString *playcount;
@property (nonatomic,copy) NSString *voicetime;

- (instancetype)initWithDict:(NSDictionary *)dict;







@end
