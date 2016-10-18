//
//  BigPictureViewController.m
//  day01 - 百思不得姐
//
//  Created by admin on 16/10/4.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import "BigPictureViewController.h"
#import "WordTopics.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>

@interface BigPictureViewController ()<UIScrollViewDelegate>

@property (nonatomic,weak) UIImageView *imageView;



@end

@implementation BigPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backClick:(id)sender {
 
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    
//    [self dismissViewControllerAnimated:YES completion:nil];
//    
//    
//    
//}

//给大图片视图控制器赋值
- (void)setTopics:(WordTopics *)topics{
    _topics = topics;
    
    
    if (topics.height < [UIScreen mainScreen].bounds.size.height) { //图片小于一个屏幕
        
        CGFloat pictureH  = topics.height * [UIScreen mainScreen].bounds.size.width / topics.width;
        
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.frame = [UIScreen mainScreen].bounds;
        UIImageView *image = [[UIImageView alloc]init];
        self.imageView = image;
      
      
//        CGSize imageSize = image.bounds.size;
//        CGPoint imageCenter = image.center;
//        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, pictureH);
//        image.center = CGPointMake([UIScreen mainScreen].bounds.size.width *0.5, [UIScreen mainScreen].bounds.size.height * 0.5);
        
        image.frame = CGRectMake(0, ([UIScreen mainScreen].bounds.size.height *0.5 - pictureH *0.5), [UIScreen mainScreen].bounds.size.width, pictureH);
        

//        [self.view insertSubview:image atIndex:0];
        [self.view insertSubview:scrollView atIndex:0];
        [scrollView addSubview:image];
        
        
        if (topics.width > [UIScreen mainScreen].bounds.size.width) {
            
            scrollView.maximumZoomScale = topics.height / pictureH;
            scrollView.minimumZoomScale = 1;
           
        }
       
        
        scrollView.delegate = self;
        
        //设置图片下载路径
        [image sd_setImageWithURL:[NSURL URLWithString:topics.image1]];
        
        image.userInteractionEnabled = YES;
        [image addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeBigPicture)]];
        
        
    } else  { //图片大于一个屏幕
        
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.frame = [UIScreen mainScreen].bounds;
//        [self.view addSubview:scrollView];
        [self.view insertSubview:scrollView atIndex:0];
   
        
        CGFloat pictureH  = topics.height * [UIScreen mainScreen].bounds.size.width / topics.width;
        
        
        
        UIImageView *image = [[UIImageView alloc]init];
        self.imageView = image;
        
        //设置图片下载路径
        [image sd_setImageWithURL:[NSURL URLWithString:topics.image1]];
        
//        CGSize imageSize = image.bounds.size;
//        CGPoint imageCenter = image.center;
//        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, pictureH);
//        imageCenter = self.view.center;
//        
        image.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, pictureH);
        
        
        if (pictureH < [UIScreen mainScreen].bounds.size.height) { //缩小之后的高小于屏幕，放在中间
            image.frame = CGRectMake(0, ([UIScreen mainScreen].bounds.size.height *0.5 - pictureH *0.5), [UIScreen mainScreen].bounds.size.width, pictureH);
        }
        
  
        [scrollView addSubview:image];
        scrollView.contentSize = CGSizeMake(0, pictureH);
        
        image.userInteractionEnabled = YES;
        [image addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeBigPicture)]];
        
    }
    
    
}



- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    

    return self.imageView;
    
    
}

// 点击图片关闭大图
- (void)closeBigPicture{
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}


//将图片保存到相册
- (IBAction)saveBigPicture:(id)sender {
    
    
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
   
    
    
}

//保存图片后调用此方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"图片保存失败!"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    } else{
        
        [SVProgressHUD showSuccessWithStatus:@"图片保存成功!"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    }
    
    
    
    
}



- (BOOL)prefersStatusBarHidden
{
    
    return YES;
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
