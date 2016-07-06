//
//  TWONewHandViewController.m
//  DSLC
//
//  Created by ios on 16/7/4.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWONewHandViewController.h"

@interface TWONewHandViewController () <UIWebViewDelegate>

{
    UIWebView *webView;
}

@end

@implementation TWONewHandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationItem setTitle:@"新手指南"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self webViewShow];
    [self loadingWithView:self.view loadingFlag:NO height:HEIGHT_CONTROLLER_DEFAULT/2 - 60];
}

- (void)webViewShow
{
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -44, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 40)];
    [self.view addSubview:webView];
    webView.delegate = self;
    
    webView.scrollView.bounces = NO;
    webView.scrollView.showsVerticalScrollIndicator = NO;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/guide.html", htmlFive]];
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
