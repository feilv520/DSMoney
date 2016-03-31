//
//  TSignInViewController.m
//  DSLC
//
//  Created by ios on 16/3/15.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TSignInViewController.h"

@interface TSignInViewController () <UIWebViewDelegate>

{
    UIWebView *webView;
}

@end

@implementation TSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"签到"];
    
    [self contentShow];
    
}

- (void)contentShow
{
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -44, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 40)];
    [self.view addSubview:webView];
    webView.scalesPageToFit = YES;
    
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.scrollView.bounces = NO;
    
    NSString *urlString = [NSString stringWithFormat:@"http://192.168.0.161:8088/zhongxin/activity/signIn.html?token=%@",self.tokenString];
    NSURL *url = [NSURL URLWithString:urlString];
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
