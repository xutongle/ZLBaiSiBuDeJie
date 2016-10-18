//
//  pictureView.m
//  day01 - 百思不得姐
//
//  Created by admin on 16/10/3.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import "pictureView.h"
#import <UIImageView+WebCache.h>
#import "BigPictureViewController.h"


@interface pictureView ()

@property (weak, nonatomic) IBOutlet UIButton *seeBigPicBtn;
@property (weak, nonatomic) IBOutlet UIImageView *gifTag;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end



@implementation pictureView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)picture{
    
    
    return [[[NSBundle mainBundle]loadNibNamed:@"pictureView" owner:nil options:nil] firstObject];
}

- (void)setTopics:(WordTopics *)topics{
    
    _topics = topics;

    
    if (topics.type == 10) {
        //是否显示大图按钮
        if (topics.height < 1000) {
            self.seeBigPicBtn.hidden = YES;
        } else{
             self.seeBigPicBtn.hidden = NO;
            self.imageView.contentMode = UIViewContentModeScaleAspectFill;
//            self.imageView.clipsToBounds = YES;
        }
      
        
        //是否显示gif标签
        self.gifTag.hidden = ([topics.image0.pathExtension isEqualToString:@"gif"]) ? NO :YES ;
        
        
        
        //如果是大图
        if (topics.height < 1000 ) {
            
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:topics.image1]];
        } else{
            
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:topics.image1] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
                // 开启图形上下文,与imageView一样大
                UIGraphicsBeginImageContextWithOptions(topics.pictureFrame.size, YES, 0.0);
                
                //把图片绘制到图形上下文，保持图片大小，绘画尺寸比保持足够
                
                CGFloat width = topics.pictureFrame.size.width;
                CGFloat height = topics.height * width / topics.width;
                [image drawInRect:CGRectMake(0, 0, width, height)];
                
                //覆盖原来的图片
                self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
                
                //结束上下文
                UIGraphicsEndImageContext();
                
            }];
            
            
        }
        
        //点击图片增加事件  ---> imageView默认不能交互
        self.imageView.userInteractionEnabled = YES;
        [self.imageView addGestureRecognizer: [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigPicture)]];
        
        
    }


}
- (IBAction)seeBigPictureClick:(id)sender {
    
    
    [self showBigPicture];
    
}

//点击查看大图
- (void)showBigPicture{
    
    
    BigPictureViewController *bigPicutre = [[BigPictureViewController alloc]init];
    
    //赋值
    bigPicutre.topics = self.topics;

    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:bigPicutre animated:YES completion:nil];
    
}

- (void)awakeFromNib{
    
    self.autoresizingMask = UIViewAutoresizingNone;
    
  
}

@end
