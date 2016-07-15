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
#import "TWOProfitingViewController.h"

@interface TWOProductHuiFuViewController () <UIWebViewDelegate , UMSocialUIDelegate>

{
    UIWebView *myWebView;
    UIButton *closeItem;
    
    // 返回的url字符串
    NSString *urlStringTwo;
    
    // url字符串
    NSString *urlString;
}

@end

@implementation TWOProductHuiFuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"开户"];
    
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 8, 20, 20)];
    [backItem setImage:[UIImage imageNamed:@"导航返回"] forState:UIControlStateNormal];
    [backItem setImage:[UIImage imageNamed:@"导航返回"] forState:UIControlStateSelected];
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
    myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -46, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 40)];
    [self.view addSubview:myWebView];
    myWebView.scalesPageToFit = YES;
    myWebView.delegate = self;
    myWebView.tag = 9092;
    myWebView.scrollView.showsHorizontalScrollIndicator = NO;
    myWebView.scrollView.bounces = NO;
    
    if ([self.fuctionName isEqualToString:@"netSave"] || [self.fuctionName isEqualToString:@"cash"]) {
        
        urlString = [NSString stringWithFormat:@"%@chinaPnr/%@?token=%@&clientType=iOS&transMoney=%@",MYAFHTTP_BASEURL,self.fuctionName,[self.flagDic objectForKey:@"token"],self.moneyString];
        
    } else if ([self.fuctionName containsString:@"chinaPnrTrade"]){
        
        urlString = [NSString stringWithFormat:@"%@%@?%@",MYAFHTTP_BASEURL,self.fuctionName,self.tradeString];
    } else {
        
        urlString = [NSString stringWithFormat:@"%@chinaPnr/%@?token=%@&clientType=iOS",MYAFHTTP_BASEURL,self.fuctionName,[self.flagDic objectForKey:@"token"]];
    }
    
    if ([self.fuctionName isEqualToString:@"netSave"]) {
        [self.navigationItem setTitle:@"充值"];
    } else if ([self.fuctionName isEqualToString:@"cash"]) {
        [self.navigationItem setTitle:@"提现"];
    } else if ([self.fuctionName containsString:@"chinaPnrTrade"]) {
        [self.navigationItem setTitle:@"购买"];
    } else {
        [self.navigationItem setTitle:@"开户"];
    }
    
    //    urlString = [NSString stringWithFormat:@"%@chinaPnr/%@?token=%@&clientType=iOS",MYAFHTTP_BASEURL,self.fuctionName,[self.flagDic objectForKey:@"token"]];
    
    NSLog(@"urlString = %@",urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [myWebView loadRequest:request];
    
}

//用苹果自带的返回键按钮处理如下(自定义的返回按钮)
- (void)buttonReturn:(UIBarButtonItem *)btn
{
    //    if ([myWebView canGoBack]) {
    //        [myWebView goBack];
    //
    //    }else{
    //        [self.view resignFirstResponder];
    //        [self.navigationController popViewControllerAnimated:YES];
    //    }
    NSArray *ctrlArray = self.navigationController.viewControllers;
    
    if ([self.fuctionName isEqualToString:@"netSave"]) {
        [self.navigationItem setTitle:@"充值"];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else if ([self.fuctionName isEqualToString:@"cash"]) {
        [self.navigationItem setTitle:@"提现"];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else if ([self.fuctionName containsString:@"chinaPnrTrade"]) {
        [self.navigationItem setTitle:@"购买"];
        [self.navigationController popToViewController:[ctrlArray objectAtIndex:1] animated:YES];
    } else {
        [self.navigationItem setTitle:@"开户"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    [self checkUserInfo];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"getMyAccountInfo" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"getMyAccountInfoFuction" object:nil];
}

//如果是H5页面里面自带的返回按钮处理如下:
#pragma mark - webViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString * requestString = [[request URL] absoluteString];
    
    NSString *responseString = [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding];
    
    requestString = [requestString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //获取H5页面里面按钮的操作方法,根据这个进行判断返回是内部的还是push的上一级页面
    
    NSLog(@"requestString = %@",requestString);
    if ([requestString hasPrefix:@"goback:"]) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } else if ([requestString rangeOfString:@"mhold.html"].location !=NSNotFound) {
        
        NSString *orderIdString = [requestString substringWithRange:NSMakeRange([requestString rangeOfString:@"id"].location + 3, requestString.length - ([requestString rangeOfString:@"id"].location + 3))];
        
        NSLog(@"orderIdString = %@",orderIdString);
        
        TWOProfitingViewController *profitingVC = [[TWOProfitingViewController alloc] init];
        profitingVC.orderId = orderIdString;
        profitingVC.ifReturnToVC = YES;
        pushVC(profitingVC);
        
    } else if ([requestString hasSuffix:@"proList.html"]) {
        
        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [app.tabBarVC.tabScrollView setContentOffset:CGPointMake(WIDTH_CONTROLLER_DEFAULT, 0) animated:NO];
        
        UIButton *indexButton = [app.tabBarVC.tabButtonArray objectAtIndex:1];
        
        for (UIButton *tempButton in app.tabBarVC.tabButtonArray) {
            
            if (indexButton.tag != tempButton.tag) {
                NSLog(@"%ld",(long)tempButton.tag);
                [tempButton setSelected:NO];
            }
        }
        
        [indexButton setSelected:YES];
        
        [app.tabBarVC setTabbarViewHidden:YES];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    NSLog(@"requestString = %@",requestString);
    NSLog(@"responseString = %@",responseString);
    return YES;
}

//获取当前页面的title和url
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString * title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];//获取当前页面的title
    //    self.title = title;
    
    NSLog(@"%@",title);
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

- (void)checkUserInfo{
    NSDictionary *parmeter = @{@"token":[self.flagDic objectForKey:@"token"]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"check/checkUserInfo" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"checkUserInfo = %@",responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            [self.flagDic setValue:[responseObject objectForKey:@"chinaPnrAcc"] forKey:@"chinaPnrAcc"];
            
            [self.flagDic writeToFile:[FileOfManage PathOfFile:@"Member.plist"] atomically:YES];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
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
