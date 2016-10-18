//
//  CommentTableViewCell.m
//  day01 - 百思不得姐
//
//  Created by admin on 16/10/10.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "Comment.h"
#import <UIImageView+WebCache.h>

@interface CommentTableViewCell ()
//评论用户内容
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
//评论用户昵称
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
//评论用户头像
@property (weak, nonatomic) IBOutlet UIImageView *profile_imageView;
//点赞按钮
@property (weak, nonatomic) IBOutlet UIButton *likeCountBtn;

//用户性别
@property (weak, nonatomic) IBOutlet UIImageView *genderView;
@end


@implementation CommentTableViewCell

- (void)setComment:(Comment *)comment{
    
    _comment = comment;
    
    self.contentLabel.text = comment.content;
    
    if(comment.like_count.floatValue > 1000){
        
        [self.likeCountBtn setTitle:[NSString stringWithFormat:@"%.1fK",comment.like_count.floatValue/1000] forState:UIControlStateNormal];
        
    } else{
        [self.likeCountBtn setTitle:comment.like_count forState:UIControlStateNormal];

    }
    
    //计算高度
    CGFloat nameY = CGRectGetMaxY(self.nickNameLabel.frame);
    
    CGFloat textH = [comment.content boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - (10+40+10+15), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;

    comment.commentH =  nameY + 10 + textH + 15;
    
}

- (void)setUser:(User *)user{
    
    _user = user;
    
    self.nickNameLabel.text = user.username;
    
    
    [self.profile_imageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
     
        // 切圆形
        if (image != nil) {
            self.profile_imageView.image = [image circleImageBezier];
        } else{
            self.profile_imageView.image = [[UIImage imageNamed:@"defaultUserIcon"] circleImageBezier];
        }
        
  
    }];
    
    if ([user.sex isEqualToString:@"m"]) {
        
        self.genderView.image = [UIImage imageNamed:@"Profile_manIcon"];
    } else{
        self.genderView.image = [UIImage imageNamed:@"Profile_womanIcon"];
    }
    
}


//- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
//    
//    if (error) {
//        
//        NSLog(@"%@",error);
//        
//    } else{
//        
//       NSLog(@"头像保存成功");
//    }
//    
//    
//    
//    
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
