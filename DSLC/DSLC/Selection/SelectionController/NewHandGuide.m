//
//  NewHandGuide.m
//  DSLC
//
//  Created by ios on 15/12/11.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "NewHandGuide.h"

@interface NewHandGuide () <UIWebViewDelegate>

{
    UIWebView *webView;
}

@end

@implementation NewHandGuide

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"新手指南"];
    
    [self contentShow];
}

- (void)contentShow
{
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20)];
    [self.view addSubview:webView];
    webView.delegate = self;
    webView.scalesPageToFit = YES;
    
    NSURL *url = [NSURL URLWithString:@"http://wap.dslc.cn/more_guide.do"];
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
