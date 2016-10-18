//
//  PublishViewController.m
//  day01 - 百思不得姐
//
//  Created by admin on 16/10/5.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import "PublishViewController.h"
#import "UIVerticalButton.h"



@interface PublishViewController ()
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@end

@implementation PublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.cancelBtn.layer.cornerRadius = 5;
    self.cancelBtn.layer.masksToBounds = YES;
    
    
    //加slogan标语
    UIImageView *slogan = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    
    slogan.center = CGPointMake([UIScreen mainScreen].bounds.size.width * 0.5, [UIScreen mainScreen].bounds.size.height * 0.2);
    
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position.y";
    
    animation.fromValue = @(-50);
    animation.toValue = @([UIScreen mainScreen].bounds.size.height * 0.2);
    
//    animation.keyPath = @"transform.scale";
//    animation.toValue = @0.5;
    
    animation.removedOnCompletion = NO;
    
    //时间间隔
    animation.duration = 0.70;
    
    [slogan.layer addAnimation:animation forKey:nil];
    
    
    
    [self.view addSubview:slogan];
    
    //加6个按钮
    NSArray *btnTitle = @[@"发视频",@"发图片",@"发段子",@"发声音",@"审帖",@"离线下载"];
    NSArray *btnImage = @[@"publish-video",@"publish-picture",@"publish-text",@"publish-audio",@"publish-review",@"publish-offline"];
    
    
    CGFloat buttonW = 72 ;
    CGFloat buttonH = buttonW+30;
    CGFloat Xmagin = ([UIScreen mainScreen].bounds.size.width - 3*buttonW - 40)*0.5;
    CGFloat buttonY = [UIScreen mainScreen].bounds.size.height*0.5 - buttonH;
    for (int i = 0; i < btnImage.count; i++) {
        
        int Hor = i/3; //行号
        int Ver = i%3; //列号
        
  
        UIVerticalButton *button = [[UIVerticalButton alloc]init];
        [button setImage:[UIImage imageNamed:btnImage[i]] forState:UIControlStateNormal];
        [button setTitle:btnTitle[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        
        
        button.frame = CGRectMake(20+ Ver*(Xmagin+buttonW), buttonY + Hor*buttonH , buttonW, buttonH);
        
        [self.view addSubview:button];
        

        
        //添加动画
        CABasicAnimation *anim = [CABasicAnimation animation];
        anim.keyPath = @"transform.scale";
        anim.fromValue = @(0.25);
        anim.toValue = @(1);
        anim.duration = 0.5+(i*0.05);
        anim.removedOnCompletion = NO;
        [button.layer addAnimation:anim forKey:nil];
        
        
        
    }
    
   
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    [self dismissViewControllerAnimated:NO completion:nil];
    
}
- (IBAction)cancel:(id)sender {
    
    
    [self dismissViewControllerAnimated:NO completion:nil];
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
