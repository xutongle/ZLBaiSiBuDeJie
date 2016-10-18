//
//  ZLCommentViewController.m
//  day01 - 百思不得姐
//
//  Created by admin on 16/10/9.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import "ZLCommentViewController.h"
#import <AFNetworking.h>
#import "WordTableViewCell.h"
#import "Comment.h"
#import "CommentTableViewCell.h"
#import "User.h"
#import <MJRefresh.h>

@interface ZLCommentViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic,strong) NSMutableArray *comments;
@property (nonatomic,strong) NSArray *hotComents;
@property (nonatomic,strong) NSArray *user;
@property (nonatomic,strong) NSArray *hotUser;

@property (nonatomic,strong) AFHTTPSessionManager *manager;

@end

@implementation ZLCommentViewController

- (AFHTTPSessionManager *)manager{
    
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}


- (NSArray *)hotComents{
    
    if (_hotComents == nil) {
        
        _hotComents = [NSArray array];
        
    }
    return _hotComents;
}

- (NSArray *)comments{
    
    if (_comments == nil) {
        
        _comments = [NSMutableArray array];
        
    }
    return _comments;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    [self setUpTableView];
    
    [self loadNewComment];
    
    [self setUpRefresh];
    
  
}

//设置上拉下拉刷新
- (void)setUpRefresh{
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(UpLoadRefresh)];
    
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(downloadRefresh)];
      self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
}


//上拉动作
- (void)UpLoadRefresh{
    
    [self loadNewComment];
    
}

//下拉动作
- (void)downloadRefresh{
    
    
    if ((int)self.comments.count >= self.topics.comment) {
        
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
//        NSLog(@"数组不能越界");
        
    } else{
        
        [self downLoadMoreComments];
        
    }
    
}

- (void)setUpTableView{
    
     self.tableView.backgroundColor = ZLBackgroundCololr;
    
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.allowsSelection = NO;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
    //注册CommentTableViewCell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CommentTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"comment"];
    
    
}
- (void)keyboardWillChangeFrame:(NSNotification *)note;
{
    //获取键盘Y值
    CGFloat keyboardY = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    
    CGFloat commentY = [UIScreen mainScreen].bounds.size.height - keyboardY;
    
    
    
    
    [self.bottomSpace setConstant:commentY];
    
    
    
}


//加载最新评论
- (void)loadNewComment{
    
    
//    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topics.ID;
    params[@"hot"] = @"1";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 最新评论
        
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            
            [self.tableView.mj_header endRefreshing];
            return ;
            
        } else  {
            
            NSArray *array = responseObject[@"data"];
            NSMutableArray *modelArray = [NSMutableArray array];
            for (NSDictionary *dict in array) {
                
                Comment *model = [[Comment alloc]initWithDict:dict];
                [modelArray addObject:model];
                
                
            }

            self.comments = modelArray;
            
            
            // 最热评论
            NSArray *arrayH = responseObject[@"hot"];
            NSMutableArray *modelArrayH = [NSMutableArray array];
            for (NSDictionary *dict in arrayH) {
                
                Comment *modelH = [[Comment alloc]initWithDict:dict];
                [modelArrayH addObject:modelH];
                
            }
            self.hotComents = modelArrayH;
            
    
            //获取数据后刷新tableView
            [self.tableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //        NSLog(@"%@",error);
    }];
    
    //停止上拉刷新
    [self.tableView.mj_header endRefreshing];
    
}

// 第二次 ---> 下拉加载最新评论
- (void)downLoadMoreComments{
    
  
//    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
   //发送新的网络请求前清除 之前的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topics.ID;
    
    //上一条评论，获取她得ID
    Comment *lastComment = [self.comments lastObject];
    
    params[@"lastcid"] = lastComment.ID;
    
    
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 最新评论
        
        //判断服务器返回数据是否正确！----> 评论为空时，传入responseObject = NSArray
        
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            
            [self.tableView.mj_footer endRefreshing];
            return ;
            
        } else {
            
            
            NSArray *array = responseObject[@"data"];
            NSString *total = responseObject[@"total"]; //实时请求的总评论数
            
            NSMutableArray *modelArray = [NSMutableArray array];
            for (NSDictionary *dict in array) {
                
                Comment *model = [[Comment alloc]initWithDict:dict];
                [modelArray addObject:model];
                
            }
            
            //数组不能越界
            if (self.comments.count >= [total integerValue]) {
                
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                //            NSLog(@"数组不能越界");
                
            } else{
                
                [self.comments addObjectsFromArray:modelArray];
                
            }
//            NSLog(@"接收%ld",self.comments.count);
//            NSLog(@"完整%ld",[total integerValue]);
//            
            
            //获取数据后刷新tableView
            [self.tableView reloadData];
            
            [self.tableView.mj_footer endRefreshing];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //        NSLog(@"%@",error);
        [self.tableView.mj_footer endRefreshing];
    }];
    
    

    
}


#pragma mark - <UITableViewDataSource>


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (!self.comments.count && !self.hotComents.count) {
        return 1;
    }
    
    else if (!self.hotComents.count && self.comments.count) {
        return 2;
    } else{
        
        return 3;
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) return 1;
    
    else if (section == 1) {
        if (self.hotComents.count) {
            return self.hotComents.count;
        } else{
            return self.comments.count;
        }
    }
    
    else  {
        return self.comments.count;
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        WordTopics *topics = self.topics;
        
        //注册一个cell
        [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WordTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"topics"];
        
        WordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topics" forIndexPath:indexPath];
        
        //清除热评区的内容
        topics.top_cmt = nil;
    
      
        //设置数据
        cell.topic = topics;
        
        return cell;
        
    } else if(indexPath.section == 1){ //最新评论 或者 最热评论
      
        
        if (self.hotComents.count) { //最热评论
            
            Comment *hotComment = self.hotComents[indexPath.row];

            CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment"];
  
            cell.comment = hotComment;
            cell.user =  hotComment.user;
            
           
            
            [cell.textLabel setFont:[UIFont systemFontOfSize:13]];
            
            
            return cell;
            
        } else{ //最新评论
            
            Comment *comment = self.comments[indexPath.row];

            CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment"];
            
            
            cell.comment = comment;
            cell.user =  comment.user;
            
            [cell.textLabel setFont:[UIFont systemFontOfSize:13]];
            
            
            return cell;
        }
        
        
    } else{ //最新评论
     
        Comment *comment = self.comments[indexPath.row];
        
        
        CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment"];
        
        
        cell.comment = comment;
        
        cell.user =  comment.user;

        [cell.textLabel setFont:[UIFont systemFontOfSize:13]];
        
         
        return cell;
     
    }
}

#pragma mark - <UITableViewDelegate>

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
     [self.view endEditing:NO];

}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        //减去评论区设置的高度
        return self.topics.cellHeigth - self.topics.topCmtHeigth;
        
    }
    
    else if (indexPath.section == 1) {
        if (self.hotComents.count) {
            
            Comment *hotComment = self.hotComents[indexPath.row];
            return hotComment.commentH;
            
        } else{
            
            Comment *comment = self.comments[indexPath.row];
            return comment.commentH;
        }
    }
    
    else  {
        
        Comment *comment = self.comments[indexPath.row];
        return comment.commentH;
    }
        
   

    
    
}

//设置分组头部标题

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = ZLBackgroundCololr;
//    view.backgroundColor = [UIColor redColor];
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(10, 0, 100 , 20);
    label.textColor = [UIColor colorWithRed:71 /255.0 green:71 /255.0 blue:71 /255.0 alpha:1];
    label.font = [UIFont systemFontOfSize:12];
   
    [view addSubview:label];
    
    if (section == 0) {
        
    }
    
    else if (section == 1) {
        if (self.hotComents.count) {
            label.text = @"热门评论";
        } else{
            label.text = @"最新评论";
        }
    }
    
    else  {
        label.text = @"最新评论";
    }
    
    
//    if (!self.comments.count && !self.hotComents.count) {
//        label.text = @"顶部";
//    }
//    
//    else if (!self.hotComents.count && self.comments.count) {
//        label.text = @"最热评论";
//        if (self.hotComents.count) {
//            label.text = @"最热评论";
//        } else{
//            label.text = @"最新评论";
//        }
//        
//        
//    } else{
//        if (section == 2) {
//            label.text = @"最新评论";
//        }
//        
//        
//    }
    
    

    return view;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    if (section == 0) {
        return 0.001f;
    }
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        return 0.001f;
    }
    return 25;
    
    
}


- (void)dealloc{
    //返回销毁时取消所有网络请求
    [self.manager invalidateSessionCancelingTasks:YES];
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
