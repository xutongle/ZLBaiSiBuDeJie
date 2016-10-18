//
//  UIBarButtonItem+NavBarButton.m
//  day01 - 百思不得姐
//
//  Created by admin on 16/9/14.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import "UIBarButtonItem+NavBarButton.h"

@implementation UIBarButtonItem (NavBarButton)


+ (instancetype)ItemWtihImage:(NSString *)image :(NSString *)HighlightedImage WithTarget:(id)target AndEvent:(SEL)event
{
    //设置左BarButton
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:HighlightedImage] forState:UIControlStateHighlighted];
    // 必须设置按钮的大小才能显示
    button.bounds = CGRectMake(0, 0, button.currentImage.size.width, button.currentImage.size.height);
    [button addTarget:target action:event forControlEvents:UIControlEventTouchUpInside];
    
    
    
    return [[UIBarButtonItem alloc]initWithCustomView:button];

    
}

@end
