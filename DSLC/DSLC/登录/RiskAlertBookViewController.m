//
//  RiskAlertBookViewController.m
//  DSLC
//
//  Created by ios on 15/11/13.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "RiskAlertBookViewController.h"
#import "RiskAlertBookCell.h"

@interface RiskAlertBookViewController () <UIWebViewDelegate>

{
    UITableView *_tableView;
    NSArray *titleArr;
    NSArray *contentArr;
    CGRect rect;
}

@end

@implementation RiskAlertBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self.disign isEqualToString:@"registerOfP"]) {
        [self.navigationItem setTitle:@"大圣理财平台用户服务协议"];
    } else {
        [self.navigationItem setTitle:@"大圣理财平台理财师服务协议"];
    }
    if ([self.disign isEqualToString:@"registerOfP"] || [self.disign isEqualToString:@"registerOfL"]) {
        [self webViewShow];
    } else {
        [self show];
    }
    
}

- (void)show
{
    [self.navigationItem setTitle:@"风险揭示"];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64)];
    [self.view addSubview:webView];
    webView.delegate = self;
    
    self.risk = [self.risk stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    self.risk = [self.risk stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    self.risk = [self.risk stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    self.risk = [self.risk stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    self.risk = [self.risk stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    
    [webView loadHTMLString:self.risk baseURL:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '80%'"];//修改百分比即可
}

- (void)webViewShow
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -44, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 40)];
    [self.view addSubview:webView];
    
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.scrollView.bounces = NO;
    
    NSURL *url = [NSURL URLWithString:@"http://wap.dslc.cn/protoco_userServes.html"];
    if ([self.disign isEqualToString:@"registerOfL"]) {
        url = [NSURL URLWithString:@"http://wap.dslc.cn/protoco_financialServes.html"];
    }
    
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
