//
//  SafeProtectViewController.m
//  DSLC
//
//  Created by ios on 15/12/11.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "SafeProtectViewController.h"

@interface SafeProtectViewController () <UIWebViewDelegate>

{
    UIWebView *webView;
}

@end

@implementation SafeProtectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"安全保障"];
    
    [self webViewShow];
}

- (void)webViewShow
{
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -44, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 40)];
    [self.view addSubview:webView];
    webView.delegate = self;
    webView.scalesPageToFit = YES;
    
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.scrollView.bounces = NO;
    
    NSURL *url = [NSURL URLWithString:@"http://wap.dslc.cn/more_security.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
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
