//
//  MillionsAndMillionsRiskMoney.m
//  DSLC
//
//  Created by ios on 15/12/11.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "MillionsAndMillionsRiskMoney.h"

@interface MillionsAndMillionsRiskMoney () <UIWebViewDelegate>

{
    UIWebView *webView;
}

@end

@implementation MillionsAndMillionsRiskMoney

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"千万风险金"];
    
    [self contentShow];
}

- (void)contentShow
{
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20)];
    [self.view addSubview:webView];
    webView.scalesPageToFit = YES;
    webView.delegate = self;
    
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.41:8080/tongjiang/more_h5.do"];
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
