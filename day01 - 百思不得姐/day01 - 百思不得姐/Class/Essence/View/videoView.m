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

@interface videoView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

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
    
 
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
