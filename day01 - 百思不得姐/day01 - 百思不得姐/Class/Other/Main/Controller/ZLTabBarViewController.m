
//
//  ZLViewController.m
//  day01 - 百思不得姐
//
//  Created by admin on 16/9/13.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import "ZLTabBarViewController.h"
#import "EssenceViewController.h"
#import "NewViewController.h"
#import "FriendViewController.h"
#import "MeViewController.h"
#import "ZLTabBar.h"


@interface ZLTabBarViewController ()

@end

@implementation ZLTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self setUpTabBar];
    
    [self setUpTabBarFontColor];
    
    //通过KVO设置tabBar
    ZLTabBar *tabBar = [[ZLTabBar alloc]init];
    [self setValue:tabBar forKeyPath:@"tabBar"];

    // 设置tabBar背景图
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar-light"];

}


- (void)setUpTabBar{
    
    // 第一个tabBar视图Essence
    EssenceViewController *essence = [[EssenceViewController alloc]init];
    [self setUpChildViewControllers:essence WithImage:@"tabBar_essence_icon" AndSelectedImage:@"tabBar_essence_click_icon" AndTitle:@"精华"];
    
    // 第二个tabBar视图New
    NewViewController *new = [[NewViewController alloc]init];
    [self setUpChildViewControllers:new WithImage:@"tabBar_new_icon" AndSelectedImage:@"tabBar_new_click_icon" AndTitle:@"新帖"];
    
    // 第三个tabBar视图New
    FriendViewController *friend = [[FriendViewController alloc]init];
    [self setUpChildViewControllers:friend WithImage:@"tabBar_friendTrends_icon" AndSelectedImage:@"tabBar_friendTrends_click_icon" AndTitle:@"关注"];
    
    // 第四个tabBar视图New
    MeViewController *me = [[MeViewController alloc]init];
    [self setUpChildViewControllers:me WithImage:@"tabBar_me_icon" AndSelectedImage:@"tabBar_me_click_icon" AndTitle:@"我"];
    
}


// 设置TabBar
- (void)setUpChildViewControllers:(UIViewController *)Vc WithImage:(NSString *)Image AndSelectedImage:(NSString *)selectedImage AndTitle:(NSString *)title
{
    
    
    ZLNavigationController *nav = [[ZLNavigationController alloc]initWithRootViewController:Vc];
    
    
    nav.tabBarItem.title = title;
    nav.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    nav.tabBarItem.image = [UIImage imageNamed:Image];
    
    [self addChildViewController:nav];

}

// 设置tabBar字体渲染模式-->灰色
- (void)setUpTabBarFontColor
{
    
    NSMutableDictionary *attrib = [NSMutableDictionary dictionary];
    attrib[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    
    //tabBar字的样式
    UITabBarItem *apprence = [UITabBarItem appearance];
    [apprence setTitleTextAttributes:attrib forState:UIControlStateSelected];
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
