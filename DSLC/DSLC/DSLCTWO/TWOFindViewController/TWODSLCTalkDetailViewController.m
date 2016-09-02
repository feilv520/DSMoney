//
//  TWODSLCTalkDetailViewController.m
//  DSLC
//
//  Created by ios on 16/7/20.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWODSLCTalkDetailViewController.h"

@interface TWODSLCTalkDetailViewController () <UIWebViewDelegate>

{
    UIWebView *webView;
}

@end

@implementation TWODSLCTalkDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"大圣侃经"];
    
    [self loadingWithView:self.view loadingFlag:NO height:HEIGHT_CONTROLLER_DEFAULT/2 - 60];
    [self contentShow];
}

- (void)contentShow
{
    NSString *htmlString = [NSString stringWithFormat:@"%@/investscanDetail.html?type=2&id=%@", htmlFive, self.talkID];
    NSLog(@"%@", htmlString);
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -44, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 40)];
    [self.view addSubview:webView];
    webView.delegate = self;
    
    webView.scrollView.showsVerticalScrollIndicator = NO;
    webView.scrollView.bounces = NO;
    
    NSURL *url = [NSURL URLWithString:htmlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self loadingWithHidden:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshWithKJData" object:nil];
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
