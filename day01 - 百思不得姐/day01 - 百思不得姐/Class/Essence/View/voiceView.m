//
//  voiceView.m
//  day01 - 百思不得姐
//
//  Created by admin on 16/10/8.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import "voiceView.h"
#import "WordTopics.h"
#import <UIImageView+WebCache.h>

@interface voiceView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;


@end


@implementation voiceView


+ (instancetype)voiceView{
    
    return [[[NSBundle mainBundle]loadNibNamed:@"voiceView" owner:nil options:nil] firstObject];
    
    
}


- (void)setTopics:(WordTopics *)topics{
    
    _topics = topics;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topics.image1]];
    
    self.playCountLabel.text = [NSString stringWithFormat:@"%@播放",topics.playcount];
    
    NSInteger mintue = topics.voicetime.integerValue / 60;
    NSInteger second = topics.voicetime.integerValue % 60;
    self.voiceTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld",mintue,second];
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
