//
//  ZLLoginViewController.m
//  day01 - 百思不得姐
//
//  Created by admin on 16/9/24.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import "ZLLoginViewController.h"

@interface ZLLoginViewController ()


@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shuRuViewleading;


@end

@implementation ZLLoginViewController


// 立即注册按钮切换
- (IBAction)registerBtn:(UIButton *)sender {
    //退出编辑状态
    [self.view endEditing:YES];
    
    if (self.shuRuViewleading.constant == 0) {
        //左移动一个屏幕距离
        self.shuRuViewleading.constant = - self.view.frame.size.width ;
        sender.selected = YES;
    } else{
        
        self.shuRuViewleading.constant = 0;
         sender.selected = NO;
    }
    
    
    // 动画重新布局
    [UIView animateWithDuration:0.25 animations:^{
        
        [self.view layoutIfNeeded];
        
    }];
 
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //退出编辑状态
    [self.view endEditing:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    /*
     clipsToBounds
     是指视图上的子视图,如果超出父视图的部分就截取掉,
     masksToBounds
     却是指视图的图层上的子图层,如果超出父图层的部分就截取掉
     */
    self.loginBtn.layer.cornerRadius = 5;
    self.loginBtn.layer.masksToBounds = YES;
    
    self.registerBtn.layer.cornerRadius = 5;
    self.registerBtn.layer.masksToBounds = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 顶部栏亮色
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
    
}



- (IBAction)dismissLogin:(id)sender {
    
    
    [self dismissViewControllerAnimated:self completion:nil];
    
    
    
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
