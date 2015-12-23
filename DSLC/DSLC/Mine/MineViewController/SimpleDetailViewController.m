//
//  SimpleDetailViewController.m
//  DSLC
//
//  Created by 马成铭 on 15/11/2.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "SimpleDetailViewController.h"

@interface SimpleDetailViewController () <UIWebViewDelegate>

@end

@implementation SimpleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"项目详情";
    
    [self webViewShow];
}

- (void)webViewShow
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20)];
    [self.view addSubview:webView];
    webView.delegate = self;
    
    self.projectDeatil = [self.projectDeatil stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    self.projectDeatil = [self.projectDeatil stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    self.projectDeatil = [self.projectDeatil stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    self.projectDeatil = [self.projectDeatil stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    self.projectDeatil = [self.projectDeatil stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    
    [webView loadHTMLString:self.projectDeatil baseURL:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '80%'"];//修改百分比即可
    
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName(‘body‘)[0].style.webkitTextFillColor= ‘green‘"];//修改字体颜色
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
