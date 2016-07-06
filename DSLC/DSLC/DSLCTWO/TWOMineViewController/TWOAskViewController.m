//
//  TWOAskViewController.m
//  DSLC
//
//  Created by ios on 16/5/11.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOAskViewController.h"

@interface TWOAskViewController () <UIWebViewDelegate>

{
    UIWebView *webView;
}

@end

@implementation TWOAskViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = [UIColor profitColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"特权本金说明"];
    
    [self webViewShow];
}

- (void)webViewShow
{
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -44, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 40)];
    [self.view addSubview:webView];
    webView.delegate = self;
    [self loadingWithView:self.view loadingFlag:NO height:HEIGHT_CONTROLLER_DEFAULT/2 - 50];
    
    webView.scrollView.bounces = NO;
    webView.scrollView.showsVerticalScrollIndicator = NO;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/tqbjtext.html", htmlFive]];
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
