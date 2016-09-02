//
//  TWOBigSweepDetailViewController.m
//  DSLC
//
//  Created by ios on 16/7/20.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOBigSweepDetailViewController.h"

@interface TWOBigSweepDetailViewController () <UIWebViewDelegate>

{
    UIWebView *webView;
}

@end

@implementation TWOBigSweepDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"投资大扫描"];
    
    [self loadingWithView:self.view loadingFlag:NO height:HEIGHT_CONTROLLER_DEFAULT/2 - 60];
    [self webViewShow];
}

- (void)webViewShow
{
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -44, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 40)];
    [self.view addSubview:webView];
    webView.delegate = self;
    webView.scrollView.showsVerticalScrollIndicator = NO;
    webView.scrollView.bounces = NO;
    
    NSString *htmlString = [NSString stringWithFormat:@"%@/investscanDetail.html?type=1&id=%@", htmlFive, self.sweepID];
    
    NSURL *url = [NSURL URLWithString:htmlString];
    NSLog(@"投资大扫描string~~~~~~~%@", htmlString);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self loadingWithHidden:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshWithBSData" object:nil];
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
