//
//  RedBagExplainViewController.m
//  DSLC
//
//  Created by ios on 15/11/27.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "RedBagExplainViewController.h"

@interface RedBagExplainViewController ()

@end

@implementation RedBagExplainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"红包说明";
    [self VIEWsHOW];
}

- (void)VIEWsHOW
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20)];
    [self.view addSubview:webView];
    
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.41:8080/tongjiang/mi_redbag2.do"];
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
