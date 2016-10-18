//
//  FriendViewController.m
//  day01 - 百思不得姐
//
//  Created by admin on 16/9/14.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import "FriendViewController.h"
#import "RecommendViewController.h"
#import "ZLLoginViewController.h"

@interface FriendViewController ()



@end

@implementation FriendViewController



// 立即注册/登录
- (IBAction)loginRegister:(id)sender {
    
    ZLLoginViewController *login = [[ZLLoginViewController alloc]init];
    
    
    [self presentViewController:login animated:YES completion:nil];
    NSLog(@"立即注册/登录");
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的关注";
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem ItemWtihImage:@"friendsRecommentIcon" :@"friendsRecommentIcon-click" WithTarget:self AndEvent:@selector(addRecommend)];
    
    // 设置背景颜色
    self.view.backgroundColor = ZLBackgroundCololr;
    
    
    
}

- (void)addRecommend
{
  
    
    RecommendViewController *recommend = [[RecommendViewController alloc]init];
    
    [self.navigationController pushViewController:recommend animated:YES];
    
    
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
