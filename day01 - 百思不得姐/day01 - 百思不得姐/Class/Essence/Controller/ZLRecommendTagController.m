//
//  ZLRecommendTagController.m
//  day01 - 百思不得姐
//
//  Created by admin on 16/9/23.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import "ZLRecommendTagController.h"
#import "RecommendTagList.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "RecommendTagViewCell.h"

@interface ZLRecommendTagController ()

@property (nonatomic,strong) NSArray *tags;



@end

@implementation ZLRecommendTagController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化TableView
    [self setUpTableView];
    
    //获取服务器数据
    [self getData];
}

// 初始化TableView
- (void)setUpTableView
{
    
    self.navigationItem.title = @"推荐标签";
    
    self.view.backgroundColor = ZLBackgroundCololr;
    
    //注册RecommendTagViewCell单元格
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RecommendTagViewCell class]) bundle:nil] forCellReuseIdentifier:@"tag"];
    
    self.tableView.rowHeight = 90;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}


//获取服务器数据
- (void)getData{
    
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    [SVProgressHUD showWithStatus:@"正在加载..."];
    // 发送请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SVProgressHUD dismiss];
        
        NSLog(@"%@",responseObject);
        NSArray *responseTag = responseObject;
        NSMutableArray *modelArray = [NSMutableArray array];
        for (NSDictionary *dict in responseTag) {
            
            RecommendTagList *tag = [[RecommendTagList alloc]initWithDict:dict];
            [modelArray addObject:tag];
      
        }
        self.tags = modelArray;
        
        //获取完数据，刷新表格
        [self.tableView reloadData];
        NSLog(@"%@",self.tags);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"加载标签失败!"];
        
        
    }];
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    return self.tags.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //获取模型数据
    RecommendTagList *tag = self.tags[indexPath.row];
    
    RecommendTagViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tag" forIndexPath:indexPath];
   
    
    // Configure the cell...
    
    
    
    cell.tags = tag;
    
    return cell;
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
