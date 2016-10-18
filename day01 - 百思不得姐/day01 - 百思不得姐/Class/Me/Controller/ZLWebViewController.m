//
//  ZLWebViewController.m
//  day01 - 百思不得姐
//
//  Created by admin on 16/10/14.
//  Copyright © 2016年 easypay. All rights reserved.
//

#import "ZLWebViewController.h"
#import "ZLSquare.h"


@interface ZLWebViewController ()<UIWebViewDelegate>


@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackBtn;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForwardBtn;

@property (nonatomic,weak)UIProgressView *progress;

//进度条
//@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end


@implementation ZLWebViewController

//- (void)setSquare:(ZLSquare *)square{
//
//    
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.qq.com"]];
//    
//    [self.webView loadRequest:request];
//    NSLog(@"Square");
//    
//}

- (void)viewDidLoad{
    
    self.view.backgroundColor = ZLBackgroundCololr;
    
    [super viewDidLoad];
    
    
    self.webView.delegate = self;
    
    //刚加载完毕不能点击 ← →
    self.goBackBtn.enabled = NO;
    self.goForwardBtn.enabled = NO;

    [self sendRequest];
  
    //设置进度条
    [self setProgress];
}

- (void)setProgress{
    
    UIProgressView *progress = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    
    self.progress = progress;
    progress.frame = CGRectMake(0, 64, self.view.frame.size.width, 5);
    
    progress.progress = 0.0;
    
    [self.webView addSubview:progress];
    
    [progress setProgress:0.5 animated:YES];
    
    
}

- (void)sendRequest{
    
    //    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.qq.com"]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.square.url]];
    [self.webView loadRequest:request];
  
    
}
//刷新页面
- (IBAction)Refresh:(id)sender {
    
    [self.webView reload];
}
//后退页面
- (IBAction)goBack:(id)sender {

    [self.webView goBack];
    
}
//前进页面
- (IBAction)goForward:(id)sender {

    [self.webView goForward];
   
    
}

#pragma mark ---- UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    [self.progress setProgress:0.3 animated:YES];
    
    return YES;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    self.goForwardBtn.enabled = self.webView.canGoForward;
    
    self.goBackBtn.enabled = self.webView.canGoBack;
    
  
    
    //
    [self.progress setProgress:1 animated:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        self.progress.hidden = YES;
        
    });
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    
//    NSLog(@"%@",error);
    self.progress.hidden = YES;
    
    
}

@end
