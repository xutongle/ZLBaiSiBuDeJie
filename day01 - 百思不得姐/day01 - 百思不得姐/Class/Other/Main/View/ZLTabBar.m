//
//  ZLTabBar.m
//  day01 - 百思不得姐
//
//  Created by admin on 16/9/14.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import "ZLTabBar.h"
#import "PublishViewController.h"



@interface ZLTabBar()

@property (nonatomic,weak)UIButton *publish;

@end


@implementation ZLTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        // 添加publish按钮
        UIButton *publish = [UIButton buttonWithType:UIButtonTypeCustom];
        [publish setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publish setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        // 设置publish按钮位置和大小 ---> 这里的frame并未初始化，是空值.
        /*
         self.publish.center = CGPointMake(self.frame.size.width *0.5, self.frame.size.height*0.5);
         
         self.publish.bounds = CGRectMake(0, 0, self.publish.currentImage.size.width, self.publish.currentImage.size.height);
         */
     
        
        self.publish = publish;
        [self addSubview:self.publish];
        
        
        //为发布按钮添加点击事件
        [self.publish addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}


//点击发布按钮
- (void)publishClick{
    
    PublishViewController *publish = [[PublishViewController alloc]init];
    
    [self.window.rootViewController presentViewController:publish animated:NO completion:nil];
    
}



- (void)layoutSubviews{
    
    [super layoutSubviews];

  // 设置publish按钮位置和大小
//    self.publish.center = self.center;  ---> 这里tabBar并未加到父视图。center值不存在.

    self.publish.center = CGPointMake(self.frame.size.width *0.5, self.frame.size.height*0.5);
    
    self.publish.bounds = CGRectMake(0, 0, self.publish.currentImage.size.width, self.publish.currentImage.size.height);
    
    
    NSInteger index = 0;
    CGFloat tabBarBtnY = 0;
    CGFloat tabBarBtnW = self.frame.size.width /5;
    CGFloat tabBarBtnH = self.frame.size.height;
    // 重新布局tabBarItems
    for (UIView *tabBarBtn in self.subviews) {
        
        if ([tabBarBtn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            CGFloat tabBarBtnX = 0 + index * tabBarBtnW;
            
            tabBarBtn.frame  = CGRectMake(tabBarBtnX, tabBarBtnY, tabBarBtnW, tabBarBtnH);
            
            
            if (index != 1) {
                index++;
            } else{
                index = index +2;
            }
            
            
        }
    }
    
    
}

@end
