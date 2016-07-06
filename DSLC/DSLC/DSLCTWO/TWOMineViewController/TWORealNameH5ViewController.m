//
//  TWORealNameH5ViewController.m
//  DSLC
//
//  Created by ios on 16/7/5.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWORealNameH5ViewController.h"

@interface TWORealNameH5ViewController () <UIWebViewDelegate>

{
    UIWebView *webView;
}

@end

@implementation TWORealNameH5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"实名认证"];
    
    [self webViewShow];
}

- (void)webViewShow
{
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -44, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 40)];
    [self.view addSubview:webView];
    webView.delegate = self;
    
    NSLog(@"--------------%@", [self.flagDic objectForKey:@"token"]);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://61.172.235.172:8000/realname.html?token=%@", [self.flagDic objectForKey:@"token"]]];
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
