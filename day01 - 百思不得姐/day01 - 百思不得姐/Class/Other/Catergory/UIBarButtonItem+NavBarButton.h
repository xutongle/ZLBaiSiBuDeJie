//
//  UIBarButtonItem+NavBarButton.h
//  day01 - 百思不得姐
//
//  Created by admin on 16/9/14.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (NavBarButton)

+ (instancetype)ItemWtihImage:(NSString *)image :(NSString *)HighlightedImage WithTarget:(id)target AndEvent:(SEL)event;


@end
