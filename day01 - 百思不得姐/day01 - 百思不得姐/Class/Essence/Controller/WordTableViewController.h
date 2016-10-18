//
//  WordTableViewController.h
//  day01 - 百思不得姐
//
//  Created by admin on 16/9/28.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    
    ZLWordTableViewTypeAll = 1,
    ZLWordTableViewTypeVideo = 41,
    ZLWordTableViewTypePicture = 10,
    ZLWordTableViewTypeSound = 31,
    ZLWordTableViewTypeWord =29,
    
} ZLWordTableViewType;


@interface WordTableViewController : UITableViewController

//帖子类型
@property (nonatomic,assign) ZLWordTableViewType type;

@property (nonatomic,copy) NSString *paramA;

@end
