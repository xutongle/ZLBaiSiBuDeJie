//
//  RecommendViewController.m
//  day01 - 百思不得姐
//
//  Created by admin on 16/9/18.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import "RecommendViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "ZLFriendRecomendList.h"
#import "RecommendTableViewCell.h"
#import "ZLFriendRecommendUser.h"
#import "RecommendUserCell.h"
#import <MJRefresh.h>

@interface RecommendViewController ()<UITableViewDataSource,UITableViewDelegate>
// 左边数据
@property (nonatomic,strong) NSArray *recommendList;
// 左边TableView
@property (weak, nonatomic) IBOutlet UITableView *recommendTableList;

// 右边数据
@property (strong,nonatomic) NSArray *recommendUser;

// 右边TableView
@property (weak, nonatomic) IBOutlet UITableView *recomendUserView;


//UserPage
@property (nonatomic,assign) NSInteger userPage;

//TotalUser ---> 重复覆盖，无法一对一
@property (nonatomic,assign) NSInteger TotalUser;

// 临时存储的发送请求参数
@property (nonatomic,strong) NSMutableDictionary *param;

@end

@implementation RecommendViewController

//懒加载ZLFriendRecomendList
//- (NSArray *)recommendList{
//    
//    if (_recommendList == nil) {
//        
//        
//        
//        
//    }
//    return _recommendList;
//}


/**
 *  推荐关注列表控制器
 */
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = @"推荐关注";
    
    // 设置背景颜色
    self.view.backgroundColor = ZLBackgroundCololr;
    
    [self setUpTableView];
    [self loadLeftRecommendList];
    
    //设置刷新栏
    [self setUpRefresh];

    
    
}

// 初始化Tableview
- (void)setUpTableView{
    
    //注册推荐用户列表tableViewCell -------------
    [self.recommendTableList registerNib:[UINib nibWithNibName:NSStringFromClass([RecommendTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    
    //白色的分割线
    self.recommendTableList.separatorColor = [UIColor whiteColor];
    
    UIView *footView= [[UIView alloc]init];
    //    footView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    self.recommendTableList.tableFooterView = footView;
   
    
    
    //注册推荐用户自定义tableViewCell ---------------
    [self.recomendUserView registerNib:[UINib nibWithNibName:NSStringFromClass([RecommendUserCell class]) bundle:nil] forCellReuseIdentifier:@"user"];
    self.recomendUserView.rowHeight = 70;
//    self.recomendUserView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
//    self.recomendUserView.contentInset = UIEdgeInsetsMake(4, 0, 0, 0);
    
    self.recomendUserView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.recommendTableList.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
      self.automaticallyAdjustsScrollViewInsets = NO;
    
}


// 加载左边的数据
- (void)loadLeftRecommendList{
    
    // 显示蒙版
    [SVProgressHUD showWithStatus:@"正在加载..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    //获取服务器数据
    AFHTTPSessionManager *Session = [AFHTTPSessionManager manager];
    
    //参数
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"a"] = @"category";
    para[@"c"] = @"subscribe";
    
    
    [Session GET:@"http://api.budejie.com/api/api_open.php" parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //获取模型数组
        NSArray *arrayList = responseObject[@"list"];
        NSMutableArray *modelArray = [NSMutableArray array];
        for (NSDictionary *dict in arrayList) {
            
            ZLFriendRecomendList *model = [[ZLFriendRecomendList alloc] initWithDict:dict];
            
            [modelArray addObject:model];
            
        }
        
        self.recommendList = modelArray;
      
        // 去掉蒙版
        [SVProgressHUD dismiss];
        
        //刷新表格重新调用数据源方法
        [self.recommendTableList reloadData];
        
        
        //默认选中第一行
        
        [self.recommendTableList selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        // 做上拉刷新的动作
        [self.recomendUserView.mj_header beginRefreshing];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 显示失败蒙版
        [SVProgressHUD showErrorWithStatus:@"获取数据失败!"];
        
    }];
    
    
   
    
}


- (void)setUpRefresh{
    
    
    
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(downLoadMoreUser)];
    
    [footer setImages:@[[UIImage imageNamed:@"tabBar_publish_click_icon"]] forState:MJRefreshStatePulling];
    [footer setImages:@[[UIImage imageNamed:@"tabBar_publish_icon"]] forState:MJRefreshStateRefreshing];
    
//    self.recomendUserView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(downLoadMoreUser)];
    
    self.recomendUserView.mj_footer = footer;
    
    self.recomendUserView.mj_footer.hidden = YES;
    
    //************* header ********** //
    
    self.recomendUserView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(upLoadNewUser)];
    
    self.recomendUserView.mj_header.automaticallyChangeAlpha = YES;
    
    
}

- (void)upLoadNewUser{

    // 上拉加载新用户 ---> 旧数据删除，重新覆盖新数据User
     // ZLFriendRecomendList *model = self.recommendList[self.recommendTableList.indexPathForSelectedRow.row];
    //旧数据删除
    //[model.users removeAllObjects];
    //重新覆盖新数据User ---> 直接 model.users = 服务器的新数据
    
    
    [self loadRemmendUserData];
    

    [self.recomendUserView.mj_header endRefreshing];
    
    
    NSLog(@"上拉更多用户");
    
    
    
    
}


- (void)downLoadMoreUser{
    // 下拉加载更多用户
    
    
    ZLFriendRecomendList *model = self.recommendList[self.recommendTableList.indexPathForSelectedRow.row];
    
    
    
    NSLog(@"2接收数据users---%zd",model.users.count);
    NSLog(@"2服务器数据TotalUser---%zd",model.TotalUser);
    //如果数据满了，则不加载新的数据
    if (model.TotalUser == model.users.count ) {
        
        [self.recomendUserView.mj_footer endRefreshingWithNoMoreData];
        
    } else { // 如果右侧tableView下面还有数据


        [self secondloadRemmendUserData];
        
   
    NSLog(@"下拉更多用户");
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //左边表格
    if (tableView == self.recommendTableList) {
        return self.recommendList.count;
    }
    //右边表格
    else{
        
        ZLFriendRecomendList *list = self.recommendList[self.recommendTableList.indexPathForSelectedRow.row];
        
        return list.users.count;
        //return self.recommendUser.count;
        
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //左边表格
    if (tableView == self.recommendTableList) {
        
        ZLFriendRecomendList *model = self.recommendList[indexPath.row];
        
        RecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        //    if (cell == nil) {
        //
        //        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        //
        //    }
        
        cell.textLabel.text = model.name;
        
        return cell;
        
    } else{
        

        /*
         * 右边有数据将底部条下拉刷新显示
         */
        self.recomendUserView.mj_footer.hidden = NO;
        
        
        //获取数据
         ZLFriendRecomendList *list = self.recommendList[self.recommendTableList.indexPathForSelectedRow.row];
        
        ZLFriendRecommendUser *model = list.users[indexPath.row];
        
        //ZLFriendRecommendUser *model = self.recommendUser[indexPath.row];
        
        RecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"user"];
        cell.attribute = model;
        
        
        return cell;
       
        
    }
}



#pragma mark - <UITableViewDelegate>
//选中哪一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //一点击就刷新，不显示上一次的残留的数据 -----> 没有效果
    //[self.recomendUserView reloadData];
    
    
     // 点击左边的tableView
    if (tableView == self.recommendTableList){

        // 每点一次重复请求数据，将获得的数据存储下来
        ZLFriendRecomendList *model = self.recommendList[indexPath.row];
        if (model.users.count) {
            
            //不用加载服务器，旧数据加载完毕
            [self.recomendUserView.mj_header endRefreshing];
            
            [self.recomendUserView reloadData];
            NSLog(@"重复加载右边数据");
            
        } else{ //刷新数据
            
           
            /*
             * 点击时候创建蒙版
             */
            [SVProgressHUD showWithStatus:@"正在加载..."];
            
            // 给服务器发送请求，加载推荐用户数据
//            [self loadRemmendUserData];
            
            self.recomendUserView.mj_header.hidden = NO;
            [self.recomendUserView.mj_header beginRefreshing];
            
            
            // 解决NO more data重复问题👇
            [self secondloadRemmendUserData];
            [self.recomendUserView reloadData];
            
        }
        
        
    }
    // 点击右边的tableView
    else{}
    
}


// 给服务器发送请求，第二次加载推荐用户数据
- (void)secondloadRemmendUserData{
    
      ZLFriendRecomendList *model = self.recommendList[self.recommendTableList.indexPathForSelectedRow.row];
    
    //点击发送网络Get请求
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"a"] = @"list";
    param[@"c"] = @"subscribe";
    param[@"page"] = @(self.userPage);
    param[@"category_id"] = @(model.id); //数据类型转化为“对象”类型.
    
    [session GET:@"http://api.budejie.com/api/api_open.php" parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SVProgressHUD dismiss];
        
        //获取右侧数据，转成模型
        // NSLog(@"%@",responseObject[@"list"]);
        NSArray *userList = responseObject[@"list"];
        
        // self.TotalUser = [responseObject[@"total"] integerValue];
        
        NSMutableArray *modelArray = [NSMutableArray array];
        for (NSDictionary *dict in userList) {
            
            ZLFriendRecommendUser *user = [[ZLFriendRecommendUser alloc]initWithDict:dict];
            [modelArray addObject:user];
            
        }
        
        //self.recommendUser = modelArray;
        /**
         * 第一次请求 model.users = modelArray;
         * 第二次请求 model.users 加到后面+ modelArray
         */
        [model.users addObjectsFromArray:modelArray];
        
        if (model.TotalUser == model.users.count)
        {
            [self.recomendUserView.mj_footer endRefreshingWithNoMoreData];
        }
        
        
        
        // 获取数据后，刷新右边数据
        [self.recomendUserView reloadData];
        //结束底部下拉条刷新状态
        [self.recomendUserView.mj_footer endRefreshing];
        
 
        self.userPage++;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"获取数据失败!"];
        //结束底部下拉条刷新状态
        [self.recomendUserView.mj_footer endRefreshing];
        
    }];

}




// 给服务器发送请求，第一次加载推荐用户数据
- (void)loadRemmendUserData
{
    
    ZLFriendRecomendList *model = self.recommendList[self.recommendTableList.indexPathForSelectedRow.row];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        
        //点击发送网络Get请求
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"a"] = @"list";
        param[@"c"] = @"subscribe";
        self.userPage = 1;
        param[@"category_id"] = @(model.id); //数据类型转化为“对象”类型.
        self.param = param;
        
        [session GET:@"http://api.budejie.com/api/api_open.php" parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
            
            if (self.param != param) {
                return ;
            }
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [SVProgressHUD dismiss];
            
            //获取右侧数据，转成模型
            // NSLog(@"%@",responseObject[@"list"]);
            NSArray *userList = responseObject[@"list"];
            NSMutableArray *modelArray = [NSMutableArray array];
            for (NSDictionary *dict in userList) {
                
                ZLFriendRecommendUser *user = [[ZLFriendRecommendUser alloc]initWithDict:dict];
                [modelArray addObject:user];
                
            }
            
            self.recommendUser = modelArray;
            
            /**
             * 第一次请求 model.users = modelArray;
             * 第二次请求 model.users 加到后面+ modelArray
             */
            //[model.users addObjectsFromArray:modelArray];
            model.users = modelArray;
            
            // 获取数据后，刷新右边数据
            [self.recomendUserView reloadData];
            
            model.TotalUser = [responseObject[@"total"] integerValue];
            NSLog(@"1接收数据users---%zd",model.users.count);
            NSLog(@"1服务器数据TotalUser---%zd",model.TotalUser);

           
            self.userPage ++;
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [SVProgressHUD showErrorWithStatus:@"获取数据失败!"];
            
        }];
        
        
    });
    
    
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
