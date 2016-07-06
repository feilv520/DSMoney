//
//  TWORedBagExplainViewController.m
//  DSLC
//
//  Created by ios on 16/7/5.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWORedBagExplainViewController.h"

@interface TWORedBagExplainViewController () <UIWebViewDelegate>

{
    UIWebView *webView;
}

@end

@implementation TWORedBagExplainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"红包使用说明"];
    
    [self webViewShow];
    [self loadingWithView:self.view loadingFlag:NO height:HEIGHT_CONTROLLER_DEFAULT/2 - 60];
}

- (void)webViewShow
{
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -44, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 40)];
    [self.view addSubview:webView];
    webView.delegate = self;
    webView.scrollView.showsVerticalScrollIndicator = NO;
    webView.scrollView.bounces = NO;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/packetext.html", htmlFive]];
    NSURLRequest *requet = [NSURLRequest requestWithURL:url];
    [webView loadRequest:requet];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self loadingWithHidden:NO];
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
