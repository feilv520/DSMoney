//
//  TBigTurntableViewController.m
//  DSLC
//
//  Created by ios on 16/3/15.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TBigTurntableViewController.h"

@interface TBigTurntableViewController () <UIWebViewDelegate>

{
    UIWebView *myWebView;
}

@end

@implementation TBigTurntableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"大转盘"];
    
    [self contentShow];
}

- (void)contentShow
{
    myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -44, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 40)];
    [self.view addSubview:myWebView];
    myWebView.scalesPageToFit = YES;
    myWebView.delegate = self;
    
    myWebView.scrollView.showsHorizontalScrollIndicator = NO;
    myWebView.scrollView.bounces = NO;
    
//    NSString *urlString = [NSString stringWithFormat:@"http://192.168.0.161:8088/zhongxin/activity/enterRotate.html?token=%@",self.tokenString];
//    NSString *urlString = [NSString stringWithFormat:@"http://wap.dslc.cn/activity/enterRotate.html?token=%@",self.tokenString];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/activity/enterRotate.html?token=%@",htmlFive,self.tokenString]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [myWebView loadRequest:request];
}

//用苹果自带的返回键按钮处理如下(自定义的返回按钮)
- (void)buttonReturn:(UIBarButtonItem *)btn
{
    if ([myWebView canGoBack]) {
        [myWebView goBack];
        
    }else{
        [self.view resignFirstResponder];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


//如果是H5页面里面自带的返回按钮处理如下:
#pragma mark - webViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString * requestString = [[request URL] absoluteString];
    requestString = [requestString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //获取H5页面里面按钮的操作方法,根据这个进行判断返回是内部的还是push的上一级页面
    if ([requestString hasPrefix:@"goback:"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    return YES;
}

//获取当前页面的title和url
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString * title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];//获取当前页面的title
    self.title = title;
    
    NSLog(@"%@",self.title);
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
