//
//  CommentTableViewCell.h
//  day01 - 百思不得姐
//
//  Created by admin on 16/10/10.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Comment,User;

@interface CommentTableViewCell : UITableViewCell



@property (nonatomic,strong) Comment *comment;
@property (nonatomic,strong) User *user;






@end
