//
//  ZLNavigationController.m
//  day01 - 百思不得姐
//
//  Created by admin on 16/9/18.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import "ZLNavigationController.h"

@interface ZLNavigationController ()

@end

@implementation ZLNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //设置导航条背景图
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
}

// 统一设置Navigation导航栏返回样式
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
 
    
    if (self.viewControllers.count > 0) {
        
        UIButton *button = [[UIButton alloc]init];
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        [button setTitle:@"返回" forState:UIControlStateNormal];
        
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        
        [button sizeToFit];
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -12, 0, 0);
        
        
        
        [button addTarget:self action:@selector(backPop) forControlEvents:UIControlEventTouchUpInside];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
        
        
        
        //隐藏底部tabBar栏，当push的时候
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    
    // 重写，覆盖上面👆的设置
    [super pushViewController:viewController animated:animated];
    
//    if (self.na) {
//         self.tabBarController.tabBar.hidden = YES;
//    }
 
}

- (void)backPop
{
    [self popViewControllerAnimated:YES];
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
