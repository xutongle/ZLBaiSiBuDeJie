//
//  RecommendUserCell.m
//  day01 - 百思不得姐
//
//  Created by admin on 16/9/21.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import "RecommendUserCell.h"
#import <UIImageView+WebCache.h>
@interface RecommendUserCell ()

// 头像
@property (weak, nonatomic) IBOutlet UIImageView *headerView;
// 粉丝数
@property (weak, nonatomic) IBOutlet UILabel *fansCount;

@property (weak, nonatomic) IBOutlet UILabel *screenName;

@end


@implementation RecommendUserCell
//重新set方法为cell属性赋值
-(void)setAttribute:(ZLFriendRecommendUser *)attribute{
    
    _attribute = attribute;
    
    [self.headerView sd_setImageWithURL:[NSURL URLWithString:attribute.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    
    
    
    
    CGFloat number = 0;
    if (attribute.fans_count > 10000) {
        
        number = attribute.fans_count / 10000.0;
       
        self.fansCount.text = [NSString stringWithFormat:@"%.2f万人关注",number];
        
    } else{
       self.fansCount.text = [NSString stringWithFormat:@"%zd人关注",attribute.fans_count];
    }
    
    
    self.screenName.text = attribute.screen_name;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
