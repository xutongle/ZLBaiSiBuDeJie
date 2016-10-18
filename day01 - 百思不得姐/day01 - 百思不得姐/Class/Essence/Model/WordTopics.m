//
//  WordTopics.m
//  day01 - 百思不得姐
//
//  Created by admin on 16/9/28.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import "WordTopics.h"

@implementation WordTopics


- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
   
    }
    return  self;
    
}




//重写，过滤掉不存在的属性赋值
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
//    NSLog(@"不需要的key值 ---- %@",key);
    
    
}

// 新的ID代替就得id，避免系统重复.
- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
        return;
    }
    [super setValue:value forKey:key];
}





//计算cell的高度.
- (CGFloat)cellHeigth
{
    //非空判断只计算一次
    if (!_cellHeigth ) {
        CGFloat headY = 60;
        
        CGFloat bottomY = 50;
        
        
        CGSize textSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 30, MAXFLOAT);
        //    CGFloat textH = [topic.text sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:textSize].height;
        CGFloat textH  = [self.text boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
        self.textH = textH;
        
        _cellHeigth = headY + textH + 15 + bottomY;
        
    
        if (self.top_cmt.count) { //热门评论区,加上评论区的高度
            
            
            NSString *top_cmtContent = self.top_cmt[0][@"content"];
            NSString *top_cmtName = self.top_cmt[0][@"user"][@"username"];
            top_cmtContent = [NSString stringWithFormat:@"%@ : %@",top_cmtName,top_cmtContent];
   
            CGFloat topConentH = [top_cmtContent boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width -20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size.height;
            
            //热评论区高度
            self.topCmtHeigth = topConentH + 12;
           
        }

        //加上评论区的高度 + 间隙
        self.cellHeigth += self.topCmtHeigth + 5;
      
        
        if (self.type == 10) { //如果是10,帖子有图片，加上图片的高度
            
            if (self.height < 1000)
            { //如果图片不太长
                CGFloat pictureH = textSize.width * self.height / self.width;
                
                CGRect pictureFrame = CGRectMake(10, 60+15+textH, textSize.width, pictureH);
                self.pictureFrame = pictureFrame;
                
    
                _cellHeigth += pictureH + 15;
                
            } else
            {  //如果图片太长
                
                CGFloat pictureH = 200;  //图片指定缩小
                
                CGRect pictureFrame = CGRectMake(10, 60+15+textH, textSize.width, pictureH);
                self.pictureFrame = pictureFrame;
                
                _cellHeigth += pictureH + 15;
                
                
                
            }

            
        } else if(self.type == 31){ //声音帖子
            
            //计算声音帖子的高度
            CGFloat voiceH = textSize.width * self.height / self.width;
            
            self.voiceFrame = CGRectMake(10, 60+15+textH, textSize.width, voiceH);
            
             _cellHeigth += voiceH + 15;
            
        } else if(self.type == 41){ //视频帖子
            
            //计算声音帖子的高度
            CGFloat videoH = textSize.width * self.height / self.width;
            
            self.videoFrame = CGRectMake(10, 60+15+textH, textSize.width, videoH);
            
            _cellHeigth += videoH + 15;
        }
       
    }
    
  
    
    return _cellHeigth;
    
    
}

- (NSString *)create_time{
    
   
    //创建时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    
    
    NSDate *creat = [formatter dateFromString:_create_time];
    NSDate *now = [NSDate date];
  
    //当前时间
    NSCalendar *currentCalender = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [currentCalender components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:creat toDate:now options:0];

    //判断时间
    if (components.day == 0 && components.month == 0 && components.year == 0) { //今天 ->年月日相等
        if (components.hour <= 1) { //这个小时
            
            formatter.dateFormat = [NSString stringWithFormat:@"%ld分钟前",components.minute];
            return [formatter stringFromDate:creat];
            
        }  else { //不是这个小时
            
//            formatter.dateFormat = @"今天 HH:mm:ss";
            formatter.dateFormat = [NSString stringWithFormat:@"%ld小时前",components.hour];
            return [formatter stringFromDate:creat];
            
        }
    } else if(components.day == 1 && components.month == 0 && components.year == 0){ //昨天->年月相等，日期差一天
        
        [formatter setDateFormat:@"昨天 HH:mm:ss"];
        return [formatter stringFromDate:creat];
        
        
    } else { //以前
        
        [formatter setDateFormat:@"yyyy年MM月dd号"];
        return  [formatter stringFromDate:creat];
        
    }
 
    
}

@end
