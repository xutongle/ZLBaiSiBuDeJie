//
//  ZLWebViewController.h
//  day01 - 百思不得姐
//
//  Created by admin on 16/10/14.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZLSquare;

@interface ZLWebViewController : UIViewController

@property (nonatomic,strong) ZLSquare *square;



@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
