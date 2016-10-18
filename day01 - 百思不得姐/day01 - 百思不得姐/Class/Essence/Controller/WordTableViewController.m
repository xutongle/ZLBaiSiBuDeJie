//
//  WordTableViewController.m
//  day01 - 百思不得姐
//
//  Created by admin on 16/9/28.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import "WordTableViewController.h"
#import <AFNetworking.h>
#import "WordTopics.h"
#import "WordTableViewCell.h"
#import <MJRefresh.h>
#import "ZLCommentViewController.h"



@interface WordTableViewController ()


// 存储帖子数组
@property (nonatomic,strong) NSMutableArray *Topics;

@property (nonatomic,copy) NSString *maxtime;

//@property (nonatomic,assign) NSInteger page;

@end

@implementation WordTableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化tableview
    [self setUpTableView];
    
    
    //设置上拉下拉刷新
    [self setUpRefresh];
    
    
    //加载最新数据，发送请求
    [self loadNewWord];
}

//设置上拉下拉刷新
- (void)setUpRefresh
{
    
    self.tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(upLoadMoreUser)];
    
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    //下拉条
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(downLoadMoreUser)];
    self.tableView.mj_footer.automaticallyChangeAlpha = YES;
    
}

// 上拉加载新用户
- (void)upLoadMoreUser
{
    //加载最新数据，发送请求
    [self loadNewWord];
    
    NSLog(@"上拉加载新用户");
    
}

// 下拉更多数据
- (void)downLoadMoreUser{

    
    
    [self secondLoadNewWord];
 
    NSLog(@"下拉更多数据");
    
    
}

//初始化tableview
- (void)setUpTableView{
    
    self.tableView.backgroundColor = ZLBackgroundCololr;
    
    //问题，顶部的NavigationBar不计入tableview的尺寸。
    //设置内边距
    self.tableView.contentInset = UIEdgeInsetsMake(40, 0, 64 + 49, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.showsVerticalScrollIndicator = NO;
    
    
}

//加载第一页数据
- (void)loadNewWord
{
 
//    self.page = 0;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = self.paramA;
        params[@"c"] = @"data";
        params[@"type"] = @(self.type); // 包装成对象
//        params[@"page"] = @(self.page);
        
        
        [session GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            
            NSArray *dictM = responseObject[@"list"];
            
            NSMutableArray *model = [NSMutableArray array];
            
            for (NSDictionary *dict in dictM) {
                
                WordTopics *topic = [[WordTopics alloc]initWithDict:dict];
                
                [model addObject:topic];
                
                //数据接收成功之后接收刷新
                [self.tableView.mj_header endRefreshing];
                
            }
            self.Topics = model;
            
            //        NSLog(@"%@",self.Topics);
            
            
            self.maxtime = responseObject[@"info"][@"maxtime"];
//            NSLog(@"1maxtime = %@",self.maxtime);
            
            //数据接收成功后刷新数据.
            [self.tableView reloadData];
            
//            [responseObject writeToFile:@"/Users/admin/Desktop/Easypay/topicsNew.plist" atomically:YES];
          
//            NSLog(@"%@",responseObject);
//            if ([responseObject[@"list"][@"videouri"] isKindOfClass:[NSString class]]) {
//                NSLog(@"videouri -- %@",responseObject[@"list"][@"videouri"]);
//            }
            
            
            
            //            self.page ++;
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            //数据接收失败之后接收刷新
            [self.tableView.mj_header endRefreshing];
            
            
            
        }];
        
        
    });
   
}

//加载下一页的数据
- (void)secondLoadNewWord{
    
   
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.paramA;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type); // 包装成对象
    params[@"maxtime"] = self.maxtime;
//    params[@"page"] = @(self.page);
    
    [session GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSArray *dictM = responseObject[@"list"];
        
        NSMutableArray *model = [NSMutableArray array];
        
        for (NSDictionary *dict in dictM) {
            
            WordTopics *topic = [[WordTopics alloc]initWithDict:dict];
            
            [model addObject:topic];
           
//            [responseObject[@"list"] writeToFile:@"/Users/admin/Desktop/Easypay/duanzi.plist" atomically:YES];
        }
        
        NSArray *newTopics = model;
        
        [self.Topics addObjectsFromArray:newTopics];
        
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
//        NSLog(@"2maxtime = %@",self.maxtime);
      
        
        //数据接收成功后刷新数据.
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
        
//        self.page++;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
         [self.tableView.mj_footer endRefreshing];
        
        
    }];
    
    
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    return self.Topics.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WordTopics *topics = self.Topics[indexPath.row];
    
    
    //注册一个cell
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WordTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"topics"];
    
    
    WordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topics" forIndexPath:indexPath];

    
    cell.topic = topics;
   
    
    return cell;
}

//设置高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     WordTopics *topic = self.Topics[indexPath.row];
    
//    NSLog(@"0---%@",topic.image0);
//    NSLog(@"1---%@",topic.image1);
//    NSLog(@"2---%@",topic.image2);
    return topic.cellHeigth;
}


//点击tableViewCell的单元格
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ZLCommentViewController *CommentVc = [[ZLCommentViewController alloc]init];
    
    [self.navigationController pushViewController:CommentVc animated:YES];
    
    CommentVc.topics = self.Topics[indexPath.row];
    
    
}





/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
