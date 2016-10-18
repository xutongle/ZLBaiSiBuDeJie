//
//  EssenceViewController.m
//  day01 - 百思不得姐
//
//  Created by admin on 16/9/14.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import "EssenceViewController.h"
#import "ZLRecommendTagController.h"

#import "WordTableViewController.h"

@interface EssenceViewController ()<UIScrollViewDelegate>
//底部指示器
@property (nonatomic,weak)UIView *redView;

@property (nonatomic,weak) UIButton *tempBtn;

@property (nonatomic,weak) UIScrollView *contentView;

@property (nonatomic,weak) UIView *titleView;

//储存按钮的数组
@property (nonatomic,assign) NSMutableArray *btnArray;


//第一页tableview
@property (nonatomic,strong) UITableViewController *firstTableVc;

@end

@implementation EssenceViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpTableViewController];
    
    [self setUpViewController];
    
    
    [self setUpTitleView];

    
    [self setUpContentScrollView];
    
    
    // 首次加载
    self.firstTableVc = [self.childViewControllers firstObject];
    
    //    tableVc.tableView.frame = CGRectMake(scrollView.contentOffset.x, 40, self.view.frame.size.width, self.view.frame.size.height - 64 - 84);
    self.firstTableVc.tableView.frame = CGRectMake(self.contentView.contentOffset.x, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self.contentView addSubview:self.firstTableVc.tableView];
    
    
    
}



// tableView的初始化添加
- (void)setUpTableViewController{
    
    
    self.paramA = @"list";
    
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




// 设置横向滚动的内容Views
- (void)setUpContentScrollView
{
    UIScrollView *content = [[UIScrollView alloc]init];
    
    content.frame = self.view.frame;

    content.contentSize = CGSizeMake(self.view.bounds.size.width * 5, 0);
    
    content.pagingEnabled = YES;
  
    [self.view insertSubview:content atIndex:0];
    
    self.contentView = content;
    
    self.contentView.delegate = self;
    
    //隐藏横向拉动条
    self.contentView.showsHorizontalScrollIndicator = NO;
    
}

#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   
    
}
// 拖动停止加载数据，调用动画
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //拖动停止，顶部条动画
    NSInteger i = scrollView.contentOffset.x / self.view.bounds.size.width;
    if (i == 0) {
        
        [self titleBtnClick:self.titleView.subviews[i+1]];
        [self.contentView addSubview:self.firstTableVc.tableView];
        
    } else{
    
    //拖动scrollView ---> 带动点击按钮
    [self titleBtnClick:self.titleView.subviews[i+1]];
    
    //拖动停止加载数据
    UITableViewController *tableVc = self.childViewControllers[i];

//    tableVc.tableView.frame = CGRectMake(scrollView.contentOffset.x, 40, self.view.frame.size.width, self.view.frame.size.height - 64 - 84);
    tableVc.tableView.frame = CGRectMake(scrollView.contentOffset.x, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self.contentView addSubview:tableVc.tableView];
    
//    NSLog(@"frame ---- %@",NSStringFromCGRect(tableVc.tableView.frame));
//    NSLog(@"count -- %ld",self.contentView.subviews.count);
    
    }
    
    
}

// 手指松开
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
   
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
}

//设置顶部条
- (void)setUpTitleView{
    //顶部View
    UIView *titleView = [[UIView alloc]init];
    self.titleView = titleView;
    titleView.frame = CGRectMake(0, 64, self.view.frame.size.width, 40);
    titleView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
    
    [self.view addSubview:titleView];
    
    NSArray *titles = @[@"全部",@"视频",@"图片",@"声音",@"段子"];
    CGFloat titleBtnW = self.view.frame.size.width / self.childViewControllers.count;
    
    
    //底部指示器
    UIView *redView = [[UIView alloc]init];
    redView.backgroundColor = [UIColor redColor];
    self.redView = redView;
    self.redView.frame = CGRectMake(0, titleView.frame.size.height -3 , 0, 3); //初始位置
   
    [titleView addSubview:redView];
    

    for (int i = 0 ; i < self.childViewControllers.count; i++) {
        
        UIButton *titleBtn = [[UIButton alloc]initWithFrame:CGRectMake(titleBtnW * i, 0, titleBtnW, 40)];
        
       
        
        [titleBtn setTitle:titles[i] forState:UIControlStateNormal];
        
        [titleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [titleBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [titleView addSubview:titleBtn];
        
        // 记下按钮的标记第i个
        titleBtn.tag = i;
        
       //按钮添加点击事件
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [titleBtn layoutIfNeeded]; // 强制布局(强制更新子控件的frame)
        

        
        //默认选中第一行
        if (i == 0) {
            [self titleBtnClick:titleBtn];
            
//            [titleBtn.titleLabel sizeToFit];
            
        }
        
    }
    
    
}

//顶部按钮添加点击事件
- (void)titleBtnClick:(UIButton *)btn{
    
    
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    // 这一次点击的按钮设置为选中
    btn.selected  = YES;
    self.tempBtn.selected = NO;
    //底部指示器长宽高尺寸位置
    
    // 如果从零开始第一次进来
    if (self.redView.frame.size.width == 0) {
        self.redView.frame = CGRectMake(0, btn.frame.size.height - 3, btn.titleLabel.bounds.size.width, 3); // ---> Btn的frame宽度,X,不一样？
        
        self.redView.center = btn.center;
        self.redView.center = CGPointMake(btn.center.x, btn.frame.size.height - 3);
        // NSLog(@"1redView -- %@",NSStringFromCGRect(self.redView.frame));
  
        
        
    } else{
        
        [UIView animateWithDuration:0.1 animations:^{ //动画方式显示
            self.redView.frame = CGRectMake(0, btn.frame.size.height - 3, btn.titleLabel.bounds.size.width, 3);
            self.redView.center = btn.center;
            self.redView.center = CGPointMake(btn.center.x, btn.frame.size.height - 3);
           // NSLog(@"2redView -- %@",NSStringFromCGRect(self.redView.frame));

            
            
        }];
    }
    
    //上一次点击的按钮设置为不选中
    self.tempBtn = btn;
    

    /*
     *点击滚动scrollView
     */
    CGPoint scrollOffset = self.contentView.contentOffset;
    
    scrollOffset.x = btn.tag * self.view.bounds.size.width;
    
    [self.contentView setContentOffset:scrollOffset animated:YES];
    
   
    
    
}


- (void)setUpViewController
{
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.titleView = titleView;
    
    [self setUpNavBarButtonItem];
    
    self.view.backgroundColor = ZLBackgroundCololr;
    
}



- (void)setUpNavBarButtonItem{
    
    //设置左BarButton
//    UIButton *MainTagSubIconClick = [UIButton buttonWithType:UIButtonTypeCustom];
//    [MainTagSubIconClick setImage:[UIImage imageNamed:@"MainTagSubIcon"] forState:UIControlStateNormal];
//    [MainTagSubIconClick setImage:[UIImage imageNamed:@"MainTagSubIconClick"] forState:UIControlStateHighlighted];
//    // 必须设置按钮的大小才能显示
//    MainTagSubIconClick.bounds = CGRectMake(0, 0, MainTagSubIconClick.currentImage.size.width, MainTagSubIconClick.currentImage.size.height);
//    [MainTagSubIconClick addTarget:self action:@selector(MainTagClick) forControlEvents:UIControlEventTouchUpInside];
  
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem ItemWtihImage:@"MainTagSubIcon" :@"MainTagSubIconClick" WithTarget:self AndEvent:@selector(MainTagSubIconClick)];
}



- (void)MainTagSubIconClick
{
    
    ZLRecommendTagController *tagController = [[ZLRecommendTagController alloc]init];
   
    
    [self.navigationController pushViewController:tagController animated:YES];

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
