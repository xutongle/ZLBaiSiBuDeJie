//
//  WordTableViewCell.m
//  day01 - 百思不得姐
//
//  Created by admin on 16/9/28.
//  Copyright © 2016年 easypay. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "WordTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "pictureView.h"
#import "voiceView.h"
#import "videoView.h"

@interface WordTableViewCell ()
//头像
@property (weak, nonatomic) IBOutlet UIImageView *profile_image;

//昵称
@property (weak, nonatomic) IBOutlet UILabel *screen_name;

// 时间
@property (weak, nonatomic) IBOutlet UILabel *create_time;

@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *repostBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;

@property (weak, nonatomic) IBOutlet UILabel *text;




//图片帖子中间的内容
@property (nonatomic,weak) pictureView *pictureView;
@property (nonatomic,weak) voiceView *voiceView;
@property (nonatomic,weak) videoView *videoView;

//热门评论区
@property (weak, nonatomic) IBOutlet UIView *top_cmtView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top_cmtViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *top_CmtLabel;



@end


@implementation WordTableViewCell



//只创建一个pictureView
- (pictureView *)pictureView{
    
    if (_pictureView == nil) {
        pictureView *pictureV = [[[NSBundle mainBundle]loadNibNamed:@"pictureView" owner:nil options:nil]firstObject];
        [self.contentView addSubview:pictureV];
   
        _pictureView = pictureV;
        
    }
    
    return _pictureView;
    
}


- (voiceView *)voiceView{
    
    if (_voiceView == nil) {
        voiceView *voiceV = [voiceView voiceView];
        [self.contentView addSubview:voiceV];
        
        _voiceView = voiceV;
        
    }
    
    return _voiceView;
    
}

- (videoView *)videoView{
    if (_videoView == nil) {
        videoView *videoV = [videoView videoView];
        [self.contentView addSubview:videoV];
        
        _videoView = videoV;
        
    }
    
    return _videoView;
    
}



- (void)setTopic:(WordTopics *)topic{
    
    
    _topic = topic;
    
    //设置图片
//    [self.profile_image sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    [self.profile_image sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        // 切圆形
        if (image != nil) {
            self.profile_image.image = [image circleImageBezier];
        } else{
            self.profile_image.image = [[UIImage imageNamed:@"defaultUserIcon"] circleImageBezier];
        }
        
        
    }];
    //设置昵称
    self.screen_name.text = topic.screen_name;
   
    // 设置时间
    self.create_time.text = topic.create_time;
    
    
    // 设置按钮
    [self setCellBtnTitle:topic.ding WithButton:self.dingBtn];
    
    [self setCellBtnTitle:topic.cai WithButton:self.caiBtn];
    
    [self setCellBtnTitle:topic.repost WithButton:self.repostBtn];
    
    [self setCellBtnTitle:topic.comment WithButton:self.commentBtn];
    
//    NSLog(@"top_cmt = %@",topic.top_cmt);
    //帖子内容
    self.text.text = topic.text;
    
 
    //根据帖子类型添加相对应的cell中间
    if (topic.type == 10) { //图片帖子
        
        // 设置frame尺寸
        self.pictureView.frame = topic.pictureFrame;
        // 赋值内容
        self.pictureView.topics = topic;
        
        [self.voiceView removeFromSuperview];
        self.pictureView.hidden = NO;
        [self.videoView removeFromSuperview];
     
    } else if(topic.type == 31){ //声音帖子 ---->  //懒加载的同时就添加voiceView;
        
        self.voiceView.frame = topic.voiceFrame;
        self.voiceView.topics = topic;
        
        self.voiceView.hidden = NO;
        [self.pictureView removeFromSuperview];
        [self.videoView removeFromSuperview];
        
    } else if (topic.type == 41){ //视频帖子
        
        self.videoView.frame = topic.videoFrame;
        self.videoView.topics = topic;
    
        self.videoView.hidden = NO;
        [self.pictureView removeFromSuperview];
        [self.voiceView removeFromSuperview];
        
    }
    
    
    else {  //段子帖子
        
        [self.videoView removeFromSuperview];
        [self.pictureView removeFromSuperview];
        [self.voiceView removeFromSuperview];
    }
    
    //热门评论区
    if (topic.top_cmt.count == 0) {
        self.top_cmtView.hidden = YES;
        
        
        
    } else if(topic.top_cmt.count != 0) {

        
        //设置热门评论区内容
        NSString *Content = topic.top_cmt[0][@"content"];
        NSString *Name = topic.top_cmt[0][@"user"][@"username"];
        
        //设置带属性的Label的文字
        NSString *Total = [NSString stringWithFormat:@"%@ : %@",Name,Content];
        
        NSMutableAttributedString *Attribute = [[NSMutableAttributedString alloc]initWithString:Total];
        
        NSRange range = [Total rangeOfString:Name];
        
        [Attribute addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0 green:0 blue:0.4 alpha:1] range:range];
        
        
        self.top_CmtLabel.attributedText = Attribute;
        
        
        
        //设置热门评论区View高度
        [self.top_cmtViewHeight setConstant: 1 + topic.topCmtHeigth + 1];
        
     
        //设置热门评论区头像昵称

//        [self.top_CmtNameLabel setTitle:top_cmtName forState:UIControlStateNormal];
//        
//        CGFloat nameW = self.top_CmtNameLabel.bounds.size.width;
//        nameW = [top_cmtName sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}].width;

        self.top_cmtView.hidden = NO;
        
    }

  
}








// 设置cell底部按钮的数字
- (void)setCellBtnTitle:(int )title WithButton:(UIButton *)btn
{
    if (title != 0) {
        
        
        if (title > 10000) {
            
            
            [btn setTitle:[NSString stringWithFormat:@"%.1f万",title / 10000.0] forState:UIControlStateNormal];
            [btn setTitle:[NSString stringWithFormat:@"%.1f万",title / 10000.0] forState:UIControlStateHighlighted];
            
       
        } else{
            title = title;
            
        }
        
        [btn setTitle:[NSString stringWithFormat:@"%zd",title] forState:UIControlStateNormal];
        [btn setTitle:[NSString stringWithFormat:@"%zd",title] forState:UIControlStateHighlighted];
        
    }
 
   
    
}




- (void)setFrame:(CGRect)frame{
    
    frame.origin.x = 5;
    frame.origin.y += 5;
    frame.size.height -= 10;
    frame.size.width -= 10;
    [super setFrame:frame];
    
    
}

//右上角点击
- (IBAction)moreDetailClick:(id)sender {
    
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"更多内容" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }]];
    
    //展示
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];

    
}



- (void)awakeFromNib {
    


    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
