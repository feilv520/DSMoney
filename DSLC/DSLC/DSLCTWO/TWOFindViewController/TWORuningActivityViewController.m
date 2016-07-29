//
//  TWORuningActivityViewController.m
//  DSLC
//
//  Created by ios on 16/7/28.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWORuningActivityViewController.h"

@interface TWORuningActivityViewController () <UIWebViewDelegate>

{
    UIWebView *webView;
}

@end

@implementation TWORuningActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self webViewShow];
    [self loadingWithView:self.view loadingFlag:NO height:HEIGHT_CONTROLLER_DEFAULT/2 - 60];
}

- (void)webViewShow
{
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT)];
    [self.view addSubview:webView];
    webView.delegate = self;
    webView.scrollView.showsVerticalScrollIndicator = NO;
    webView.scrollView.bounces = NO;
    
    NSURL *url = [NSURL URLWithString:self.runLink];
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
