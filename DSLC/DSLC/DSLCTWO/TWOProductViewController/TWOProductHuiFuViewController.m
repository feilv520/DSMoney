//
//  TWOProductHuiFuViewController.m
//  DSLC
//
//  Created by 马成铭 on 16/4/22.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOProductHuiFuViewController.h"
#import "TWOLoginAPPViewController.h"
#import "JSONKit.h"

@interface TWOProductHuiFuViewController () <UIWebViewDelegate , UMSocialUIDelegate>

{
    UIWebView *myWebView;
    UIButton *closeItem;
    
    // 返回的url字符串
    NSString *urlStringTwo;
}

@end

@implementation TWOProductHuiFuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"汇付开户"];
    
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 8, 20, 20)];
    [backItem setImage:[UIImage imageNamed:@"750产品111"] forState:UIControlStateNormal];
    [backItem setImage:[UIImage imageNamed:@"750产品111"] forState:UIControlStateSelected];
    [backItem addTarget:self action:@selector(buttonReturn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    
    closeItem = [[UIButton alloc]initWithFrame:CGRectMake(30, 0, 40, 36)];
    [closeItem setTitle:@"关闭" forState:UIControlStateNormal];
    [closeItem setTitleColor:Color_White forState:UIControlStateNormal];
    [closeItem addTarget:self action:@selector(clickedCloseItem:) forControlEvents:UIControlEventTouchUpInside];
    closeItem.hidden = YES;
    [backView addSubview:closeItem];
    
    UIBarButtonItem * leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backView];
    self.navigationItem.leftBarButtonItem = leftItemBar;
    
    [self contentShow];
}

- (void)contentShow
{
    myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 40)];
    [self.view addSubview:myWebView];
    myWebView.scalesPageToFit = YES;
    myWebView.delegate = self;
    myWebView.tag = 9092;
    myWebView.scrollView.showsHorizontalScrollIndicator = NO;
    myWebView.scrollView.bounces = NO;
    
//    NSString *urlString = self.chinaURLString;
    
    NSString *urlString = [NSString stringWithFormat:@"http://192.168.0.14:8080/dslc/interface/chinaPnr/userReg?token=%@&clientType=iOS",[self.flagDic objectForKey:@"token"]];
    
    NSLog(@"urlString = %@",urlString);

    NSURL *url = [NSURL URLWithString:urlString];

//    NSString *bodyString = [NSString stringWithFormat:@"BgRetUrl=%@&ChkValue=%@&CmdId=%@&MerCustId=%@&MerPriv=%@&PageType=%@&RetUrl=%@&UsrId=%@&UsrMp=%@&Version=%@",[self.huifuModel BgRetUrl],[self.huifuModel ChkValue],[self.huifuModel CmdId],[self.huifuModel MerCustId],[self.huifuModel MerPriv],[self.huifuModel PageType],[self.huifuModel RetUrl],[self.huifuModel UsrId],[self.huifuModel UsrMp],[self.huifuModel Version]];
    
//    NSString *bodyString = [NSString stringWithFormat:@"Version=%@CmdId=%@MerCustId=%@PageType=%@ChkValue=%@UsrId=%@UsrMp=%@MerPriv=%@RetUrl=%@",[self.huifuModel Version],[self.huifuModel CmdId],[self.huifuModel MerCustId],[self.huifuModel PageType],[self.huifuModel ChkValue],[self.huifuModel UsrId],[self.huifuModel UsrMp],[self.huifuModel MerPriv],[self.huifuModel RetUrl]];
    
//    NSLog(@"bodyString = %@",bodyString);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody: [bodyString dataUsingEncoding: NSUTF8StringEncoding]];
    
//    NSString *httpBodyString = [self dictionaryToJson:paraDic];
//    
//    NSLog(@"%@",httpBodyString);
    
//    [request setHTTPBody:[httpBodyString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
    
    [myWebView loadRequest:request];
    
//    [myWebView loadHTMLString:self.httpString baseURL:nil];
    
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
    
    NSLog(@"requestString = %@",requestString);
    
    return YES;
}

//获取当前页面的title和url
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString * title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];//获取当前页面的title
    self.title = title;
    
    NSLog(@"%@",self.title);
}

#pragma mark - clickedCloseItem
- (void)clickedCloseItem:(UIButton *)btn{
    
    [self.view resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (NSString *)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
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