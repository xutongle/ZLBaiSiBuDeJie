//
//  RecommendTableViewCell.m
//  day01 - 百思不得姐
//
//  Created by admin on 16/9/20.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import "RecommendTableViewCell.h"
@interface RecommendTableViewCell()

//红色指示器
@property (weak, nonatomic) IBOutlet UIView *redIndicator;

@end

@implementation RecommendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
  
    
    
    self.textLabel.textAlignment = NSTextAlignmentRight;

  
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

    //当cell的selection为None时，cell被选中时，内部子控件就不会进入高亮状态
    //点击cell,调用当前方法
    self.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    
    self.textLabel.textColor = selected? [UIColor colorWithRed:219/255.0 green:21/255.0 blue:26/255.0 alpha:1]:[UIColor colorWithRed:78/255.0 green:78/255.0 blue:78/255.0 alpha:1];
    
    self.redIndicator.hidden = !selected;


    
}

@end
