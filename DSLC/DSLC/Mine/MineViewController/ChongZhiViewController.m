//
//  ChongZhiViewController.m
//  DSLC
//
//  Created by 马成铭 on 16/1/4.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "ChongZhiViewController.h"
#import "define.h"

@interface ChongZhiViewController () <UIWebViewDelegate>

{
    UIWebView *webView;
}

@end

@implementation ChongZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"银行限额表";
    
    [self webViewShow];
}

- (void)webViewShow
{
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 40)];
    
    [self.view addSubview:webView];
    webView.delegate = self;
    webView.scalesPageToFit = YES;
    
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.scrollView.bounces = NO;
    
    [self loadingWithView:self.view loadingFlag:NO height:HEIGHT_CONTROLLER_DEFAULT/2 - 50];
    
    NSURL *url = [NSURL URLWithString:@"http://wap.dslc.cn/limit_bank.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self loadingWithHidden:YES];
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
