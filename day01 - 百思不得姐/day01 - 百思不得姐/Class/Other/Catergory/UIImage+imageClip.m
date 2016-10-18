//
//  UIImage+imageClip.m
//  day01 - 百思不得姐
//
//  Created by admin on 16/10/12.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import "UIImage+imageClip.h"

@implementation UIImage (imageClip)

- (UIImage *)circleImage{
    
    
    //开启图形上下文
    //UIGraphicsBeginImageContext(self.profile_image.bounds.size); 不透明的图形上下文
    //NO代表透明
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    //画在上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //添加一个圆形
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    //裁剪
    CGContextClip(ctx);
    
    
    //将图片画上去
    [self drawInRect:rect];
    
    // 获取图片上下文的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束上下文
    UIGraphicsEndImageContext();
    
    
    
    return image;
}


- (UIImage *)circleImageBezier{
    
    
    //开启图形上下文
    //UIGraphicsBeginImageContext(self.profile_image.bounds.size); 不透明的图形上下文
    //NO代表透明
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.size.width, self.size.height), NO, 0.0);
    
    // 2.画大圆，把圆的线条加到clip。就可以裁切图片
    UIBezierPath *roundPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    [roundPath addClip];
   
    //将图片画上去
    [self drawAtPoint:CGPointZero];
    
    // 获取图片上下文的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束上下文
    UIGraphicsEndImageContext();
    
//    NSLog(@"Bimage = %@",image);
    
    
//    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    
    return image;
    
    

    
    
}






//保存图片后调用此方法
//- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
//    
//    if (error) {
//        NSLog(@"%@",error);
//    } else{
//        
//         NSLog(@"图片保存成功!");
//    }
//    
//}


@end
