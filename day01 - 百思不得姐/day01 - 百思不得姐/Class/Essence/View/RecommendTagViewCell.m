//
//  RecommendTagViewCell.m
//  day01 - 百思不得姐
//
//  Created by admin on 16/9/23.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import "RecommendTagViewCell.h"
#import "UIImageView+WebCache.h"

@interface RecommendTagViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageListView;

@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;


@end


@implementation RecommendTagViewCell

- (void)setTags:(RecommendTagList *)tags{
    
    _tags = tags;
    
    self.themeNameLabel.text = tags.theme_name;
    
    CGFloat number = 0;
    if (tags.sub_number > 10000) {
        
        number = tags.sub_number / 10000.0;
        
        self.subNumberLabel.text = [NSString stringWithFormat:@"%.2f万人订阅",number];
    } else{
        self.subNumberLabel.text = [NSString stringWithFormat:@"%zd人订阅",tags.sub_number];
    }
    
    
    [self.imageListView sd_setImageWithURL:[NSURL URLWithString:tags.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
}

// 重写frame方法,cell的展示尺寸
- (void)setFrame:(CGRect)frame{
    
    frame.origin.x = 5;
    
    
    
    frame.size.width -= 2*5;
    frame.size.height -= 5;
    
    [super setFrame:frame];
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
