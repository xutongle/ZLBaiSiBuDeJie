//
//  videoView.m
//  day01 - 百思不得姐
//
//  Created by admin on 16/10/8.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import "videoView.h"
#import <UIImageView+WebCache.h>
#import "WordTopics.h"
#import <AVKit/AVPlayerViewController.h>
#import <AVFoundation/AVPlayer.h>


@interface videoView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


//视频的URL
@property (nonatomic,assign) NSString *videouri;

@end

@implementation videoView



+ (instancetype)videoView{
    
    return [[[NSBundle mainBundle]loadNibNamed:@"videoView" owner:nil options:nil]firstObject];
    
    
    
}

- (void)awakeFromNib{
    
    self.imageView.autoresizingMask = UIViewAutoresizingNone;
    
}

- (void)setTopics:(WordTopics *)topics{
    
    _topics = topics;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topics.image1]];
    
    self.videouri = topics.videouri;


}

//点击播放视频
- (IBAction)videoPlay:(id)sender {
    
    NSURL *vURL = [NSURL URLWithString:self.videouri];
    
    AVPlayerViewController *player = [[AVPlayerViewController alloc]init];
    
    player.player = [AVPlayer playerWithURL:vURL];
    
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:player animated:YES completion:nil];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
