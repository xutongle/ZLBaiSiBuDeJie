//
//  NewViewController.m
//  day01 - 百思不得姐
//
//  Created by admin on 16/9/14.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import "NewViewController.h"
#import "WordTableViewController.h"

@interface NewViewController ()

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor whiteColor];
//    UIImageView *titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
//    self.navigationItem.titleView = titleView;
//    
//    
//    // 左边的NavBarButton
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem ItemWtihImage:@"MainTagSubIcon" :@"MainTagSubIconClick" WithTarget:self AndEvent:@selector(NewMainTagSubIconClick)];
//    
//    // 设置背景颜色
//    self.view.backgroundColor = ZLBackgroundCololr;
    
    
    
    
    
}

- (void)setUpTableViewController{
    
    
    self.paramA = @"newlist";
    
    WordTableViewController *allTableView = [[WordTableViewController alloc]init];
    allTableView.type = ZLWordTableViewTypeAll;
    allTableView.paramA = self.paramA;
    [self addChildViewController:allTableView];
    
    WordTableViewController *videoTableView = [[WordTableViewController alloc]init];
    videoTableView.type = ZLWordTableViewTypeVideo;
    videoTableView.paramA = self.paramA;
    [self addChildViewController:videoTableView];
    
    WordTableViewController *picTableView = [[WordTableViewController alloc]init];
    picTableView.type = ZLWordTableViewTypePicture;
    picTableView.paramA = self.paramA;
    [self addChildViewController:picTableView];
    
    WordTableViewController *soundTableView = [[WordTableViewController alloc]init];
    soundTableView.type = ZLWordTableViewTypeSound;
    soundTableView.paramA = self.paramA;
    [self addChildViewController:soundTableView];
    
    WordTableViewController *wordTableView = [[WordTableViewController alloc]init];
    wordTableView.type = ZLWordTableViewTypeWord;
    wordTableView.paramA = self.paramA;
    [self addChildViewController:wordTableView];

    
    
    
    
}


//- (void)NewMainTagSubIconClick
//{
//    NSLog(@"NewMainTagSubIconClick");
//}

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
