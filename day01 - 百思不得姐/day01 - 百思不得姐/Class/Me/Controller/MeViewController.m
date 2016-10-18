//
//  MeViewController.m
//  day01 - 百思不得姐
//
//  Created by admin on 16/9/14.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import "MeViewController.h"
#import "ZLMeTableView.h"
#import "ZLMeCustomViewCell.h"
#import "ZLSquare.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "ZLWebViewController.h"


#import "ZLVerticalButton.h"


@interface MeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray *square;

@property (nonatomic,strong) ZLMeTableView *tableView;




@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的";
    // Do any additional setup after loading the view.
    
    
    // 设置导航栏BarButtonItem
    UIBarButtonItem *setting = [UIBarButtonItem ItemWtihImage:@"mine-setting-icon" :@"mine-setting-icon-click" WithTarget:self AndEvent:nil];
    UIBarButtonItem *moon = [UIBarButtonItem ItemWtihImage:@"mine-moon-icon" :@"mine-moon-icon-click" WithTarget:self AndEvent:nil];
    
    self.navigationItem.rightBarButtonItems = @[
                                                setting,
                                                moon
                                                ];
    
    // 设置背景颜色
    self.view.backgroundColor = ZLBackgroundCololr;
   
    [self setUpTableView];
    
    //接收服务器数据
    [self loadNewData];
}


//接收服务器数据
- (void)loadNewData{
    
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    NSDictionary *param = @{@"a":@"square",
                            @"c":@"topic"
                            };
    
    [session GET:@"http://api.budejie.com/api/api_open.php" parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *square_list = responseObject[@"square_list"];
        NSMutableArray *modelArray = [NSMutableArray array];
        for (NSDictionary *dict in square_list) {
            
            ZLSquare *square = [[ZLSquare alloc] initWithDict:dict];
            [modelArray addObject:square];
            
        }
        self.square = modelArray;
        
       //接收数据重新加载数据
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}





- (void)setUpTableView{
    
    ZLMeTableView *MeTableView = [[ZLMeTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    
    [self.view addSubview:MeTableView];
    self.tableView = MeTableView;
    
    MeTableView.dataSource = self;
    MeTableView.delegate = self;
    
    
    MeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    MeTableView.showsVerticalScrollIndicator = NO;
    
    MeTableView.contentInset = UIEdgeInsetsMake(-35 + 10, 0, 0, 0);
    
}

#pragma mark --- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"me"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"me"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"登录/注册";
        
        
        return cell;
    } else if (indexPath.section == 1){
        cell.textLabel.text = @"离线下载";
        return cell;
        
    } else{

        
        
        
        ZLMeCustomViewCell *customCell = [[ZLMeCustomViewCell alloc]init];
        cell.textLabel.text = @"自定义VIew";
        
        
        CGFloat btnW = [UIScreen mainScreen].bounds.size.width / 4;
        CGFloat btnH = btnW;
        for (int i = 0;i < self.square.count ; i++) {
            
            int col = i / 4;    //行
            int row = i % 4;    //列
            
            
            
            
           ZLSquare *square = self.square[i];
            
            ZLVerticalButton *btn = [ZLVerticalButton buttonWithType:UIButtonTypeCustom];

            btn.frame = CGRectMake(row * btnW, col * btnH, btnW, btnH);
            
            btn.square = square;
            
            
            if (![btn.square.url containsString:@"http"]) {
                [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            }
            
            [btn addTarget:self action:@selector(squareButonClick:) forControlEvents:UIControlEventTouchUpInside];
        
            
            [customCell addSubview:btn];
            
           
            customCell.selectionStyle = UITableViewCellSelectionStyleNone;
           
        }
 
        
        return customCell;
    }
    
    
    
    
}

//点击跳转页面
- (void)squareButonClick:(ZLVerticalButton *)btn{
    
    
    
    if ([btn.square.url containsString:@"http"]) {
      
  
        
        //应用的主要窗口的根控制器是UITabBarController
        UITabBarController *tabBar = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        
        
        UINavigationController *nav =  tabBar.selectedViewController;
        
        

        ZLWebViewController *web = [[ZLWebViewController alloc]init];
        web.square = btn.square;
     
        //获得导航控制器 --> push
        [nav pushViewController:web animated:YES];
        
        //赋值
//        web.square = btn.square;
        

        
    } else {
        
        

        [SVProgressHUD showErrorWithStatus:@"自定义URL"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
      
        
    }
    
    
    
    
    
}

#pragma mark --- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2) {
        
        CGFloat btnW = [UIScreen mainScreen].bounds.size.width / 4;
        NSInteger left = self.square.count % 4;
        NSInteger hang = self.square.count / 4;
   
        if ( left == 0) {
       
            return btnW * hang;
           
            
        } else{
           
            return btnW * (hang + 1);
            
        }
        
        
        
    } else{
        
        return 40;
        
    }
    
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
