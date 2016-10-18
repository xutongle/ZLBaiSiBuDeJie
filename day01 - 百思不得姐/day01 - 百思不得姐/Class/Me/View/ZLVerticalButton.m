//
//  ZLVerticalButton.m
//  day01 - 百思不得姐
//
//  Created by admin on 16/10/14.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import "ZLVerticalButton.h"
#import "ZLSquare.h"
#import "UIButton+WebCache.h"

@implementation ZLVerticalButton


- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    
    CGFloat topMagin = self.bounds.size.width * 0.15;
    CGFloat imageW = self.bounds.size.width * 0.5;
    CGFloat leftMagin = self.bounds.size.width * (1 - 0.5) / 2;
    
    //调整图片位置
    self.imageView.frame = CGRectMake(leftMagin, topMagin, imageW, imageW);
    
    
    CGFloat titleY = CGRectGetMaxY(self.imageView.frame) + 2;
    //调整文字位置
    self.titleLabel.frame = CGRectMake(0, titleY, self.frame.size.width, self.frame.size.height - titleY);
    
    //文字居中
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
   
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    

}

- (void)setSquare:(ZLSquare *)square{
    
    
    _square = square;
    
    //设置按钮文字
    [self setTitle:square.name forState:UIControlStateNormal];
    //设置按钮文字颜色
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    //设置按钮图片
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];
    
    
    //设置按钮背景图片
    [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
    
    
    
    
    
}

@end
