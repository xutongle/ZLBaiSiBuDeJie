//
//  UIVerticalButton.m
//  day01 - 百思不得姐
//
//  Created by admin on 16/9/24.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import "UIVerticalButton.h"

@implementation UIVerticalButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews{
    
    [super layoutSubviews];
    //调整图片位置
    self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
    
    //调整文字位置
    self.titleLabel.frame = CGRectMake(0, self.frame.size.width, self.frame.size.width, self.frame.size.height - self.frame.size.width);
    
    //文字居中
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
}

@end
