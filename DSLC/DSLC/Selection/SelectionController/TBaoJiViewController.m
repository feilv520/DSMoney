//
//  TBaoJiViewController.m
//  DSLC
//
//  Created by 马成铭 on 16/4/22.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TBaoJiViewController.h"
#import "TWOLoginAPPViewController.h"

@interface TBaoJiViewController () <UIWebViewDelegate , UMSocialUIDelegate>

{
    UIWebView *myWebView;
    UIButton *closeItem;
    
    // 返回的url字符串
    NSString *urlStringTwo;
}

@end

@implementation TBaoJiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"爆击抽奖"];
    
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 11, 20, 20)];
    [backItem setImage:[UIImage imageNamed:@"导航返回"] forState:UIControlStateNormal];
    [backItem setImage:[UIImage imageNamed:@"导航返回"] forState:UIControlStateSelected];
    [backItem addTarget:self action:@selector(buttonReturn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    
    closeItem = [[UIButton alloc]initWithFrame:CGRectMake(30, 3, 40, 36)];
    [closeItem setTitle:@"关闭" forState:UIControlStateNormal];
    [closeItem setTitleColor:Color_White forState:UIControlStateNormal];
    [closeItem addTarget:self action:@selector(clickedCloseItem:) forControlEvents:UIControlEventTouchUpInside];
    closeItem.hidden = YES;
    [backView addSubview:closeItem];
    
    UIBarButtonItem * leftItemBar = [[UIBarButtonItem alloc]initWithCustomView:backView];
    self.navigationItem.leftBarButtonItem = leftItemBar;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadWithWebview:) name:@"reloadWithWebview" object:nil];
    
    [self contentShow];
    
    [self loadingWithView:self.view loadingFlag:NO height:HEIGHT_CONTROLLER_DEFAULT/2 - 60];
}

- (void)contentShow
{
    myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -44, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 40)];
    [self.view addSubview:myWebView];
    myWebView.scalesPageToFit = YES;
    myWebView.delegate = self;
    myWebView.tag = 9092;
    myWebView.scrollView.showsHorizontalScrollIndicator = NO;
    myWebView.scrollView.bounces = NO;
    
//    NSString *urlString = [NSString stringWithFormat:@"http://wap.dslc.cn/prize/index.html?token=%@",self.tokenString];
    NSString *urlString = [NSString stringWithFormat:@"%@/prize/index.html?token=%@",htmlFive,self.tokenString];
//    NSString *urlString = [NSString stringWithFormat:@"http://192.168.0.41:8888/tongjiang/prize/index.html"];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [myWebView loadRequest:request];
}

//用苹果自带的返回键按钮处理如下(自定义的返回按钮)
- (void)buttonReturn:(UIBarButtonItem *)btn
{
    
    UIWebView *wView = (UIWebView *)[self.view viewWithTag:9092];
    
    if ([myWebView canGoBack]) {
        [myWebView goBack];
        closeItem.hidden = NO;
    } else {
        
        NSString *tokenString = [wView stringByEvaluatingJavaScriptFromString:@"jsLayout();"];
        
        NSLog(@"tokenString = %@",tokenString);
        
        if ([tokenString isEqualToString:@""]) {
            [self.view resignFirstResponder];
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        
        // 刷新任务中心列表
        [[NSNotificationCenter defaultCenter] postNotificationName:@"taskListFuction" object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"getMyAccountInfo" object:nil];
        
        if (![FileOfManage ExistOfFile:@"Member.plist"]) {
            [FileOfManage createWithFile:@"Member.plist"];
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSString stringWithFormat:@"%@",tokenString],@"token",nil];
            [dic writeToFile:[FileOfManage PathOfFile:@"Member.plist"] atomically:YES];
        } else {
            NSMutableDictionary *usersDic = [[NSMutableDictionary alloc]initWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
            //设置属性值,没有的数据就新建，已有的数据就修改。
            [usersDic setObject:[NSString stringWithFormat:@"%@",tokenString] forKey:@"token"];
            //写入文件
            [usersDic writeToFile:[FileOfManage PathOfFile:@"Member.plist"] atomically:YES];
        }
        
        if (![FileOfManage ExistOfFile:@"isLogin.plist"]) {
            [FileOfManage createWithFile:@"isLogin.plist"];
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"YES",@"loginFlag",nil];
            [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
        } else {
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"YES",@"loginFlag",nil];
            [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
        }
        
        [self getData];
        
        [self.view resignFirstResponder];
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}

//如果是H5页面里面自带的返回按钮处理如下:
#pragma mark - webViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString * requestString = [[request URL] absoluteString];
    requestString = [requestString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"requestString === %@",requestString);
    //获取H5页面里面按钮的操作方法,根据这个进行判断返回是内部的还是push的上一级页面
    
    if ([requestString hasPrefix:@"goback:"]) {
        [self.navigationController popViewControllerAnimated:YES];
        return YES;
    } else if ([requestString hasSuffix:@"toLogin.html"]) {
        NSLog(@"123333");
        
        TWOLoginAPPViewController *loginVC = [[TWOLoginAPPViewController alloc] init];
        
        UINavigationController *nvc=[[UINavigationController alloc] initWithRootViewController:loginVC];
        [nvc setNavigationBarHidden:YES animated:YES];
        
        [self presentViewController:nvc animated:YES completion:^{
            
        }];
        
        urlStringTwo = [webView stringByEvaluatingJavaScriptFromString:@"toAppLogin();"];
        
        NSLog(@"urlStringNew= %@",urlStringTwo);
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStringTwo]];
        
        [webView loadRequest:request];

    }
    
    return YES;
}

//获取当前页面的title和url
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self loadingWithHidden:YES];
    
//    NSString * title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];//获取当前页面的title
//    self.title = title;
//    
//    NSLog(@"%@",self.title);
}

- (void)getData
{
    NSDictionary *parameter = @{@"token":[self.flagDic objectForKey:@"token"]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"user/getUserInfo" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"asasasasasa%@", responseObject);
        
        if (![FileOfManage ExistOfFile:@"Member.plist"]) {
            [FileOfManage createWithFile:@"Member.plist"];
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [self.flagDic objectForKey:@"password"],@"password",
                                 [self.flagDic objectForKey:@"phone"],@"phone",
                                 [responseObject objectForKey:@"key"],@"key",
                                 [[responseObject objectForKey:@"User"] objectForKey:@"id"],@"id",
                                 [[responseObject objectForKey:@"User"] objectForKey:@"userNickname"],@"userNickname",
                                 [[responseObject objectForKey:@"User"] objectForKey:@"avatarImg"],@"avatarImg",
                                 [[responseObject objectForKey:@"User"] objectForKey:@"userAccount"],@"userAccount",
                                 [[responseObject objectForKey:@"User"] objectForKey:@"userPhone"],@"userPhone",
                                 [[responseObject objectForKey:@"User"] objectForKey:@"accBalance"],@"accBalance",
                                 [[responseObject objectForKey:@"User"] objectForKey:@"realnameStatus"],@"realnameStatus",
                                 [[responseObject objectForKey:@"User"] objectForKey:@"realName"],@"realName",
                                 [[responseObject objectForKey:@"User"] objectForKey:@"chinaPnrAcc"],@"chinaPnrAcc",
                                 [responseObject objectForKey:@"token"],@"token",
                                 [[responseObject objectForKey:@"User"] objectForKey:@"registerTime"],@"registerTime",nil];
            [dic writeToFile:[FileOfManage PathOfFile:@"Member.plist"] atomically:YES];
        } else {
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [self.flagDic objectForKey:@"password"],@"password",
                                 [self.flagDic objectForKey:@"phone"],@"phone",
                                 [responseObject objectForKey:@"key"],@"key",
                                 [[responseObject objectForKey:@"User"] objectForKey:@"id"],@"id",
                                 [[responseObject objectForKey:@"User"] objectForKey:@"userNickname"],@"userNickname",
                                 [[responseObject objectForKey:@"User"] objectForKey:@"avatarImg"],@"avatarImg",
                                 [[responseObject objectForKey:@"User"] objectForKey:@"userAccount"],@"userAccount",
                                 [[responseObject objectForKey:@"User"] objectForKey:@"userPhone"],@"userPhone",
                                 [[responseObject objectForKey:@"User"] objectForKey:@"accBalance"],@"accBalance",
                                 [[responseObject objectForKey:@"User"] objectForKey:@"realnameStatus"],@"realnameStatus",
                                 [[responseObject objectForKey:@"User"] objectForKey:@"realName"],@"realName",
                                 [[responseObject objectForKey:@"User"] objectForKey:@"chinaPnrAcc"],@"chinaPnrAcc",
                                 [responseObject objectForKey:@"token"],@"token",
                                 [[responseObject objectForKey:@"User"] objectForKey:@"registerTime"],@"registerTime",nil];
            [dic writeToFile:[FileOfManage PathOfFile:@"Member.plist"] atomically:YES];
            NSLog(@"%@",[responseObject objectForKey:@"token"]);
        }

        [[NSNotificationCenter defaultCenter] postNotificationName:@"refrushToPickProduct" object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refrushToProductList" object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dian" object:nil];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

#pragma mark - clickedCloseItem
- (void)clickedCloseItem:(UIButton *)btn{
    UIWebView *wView = (UIWebView *)[self.view viewWithTag:9092];
    
    NSString *tokenString = [wView stringByEvaluatingJavaScriptFromString:@"jsLayout();"];
    
    NSLog(@"%@",tokenString);
    
    if ([tokenString isEqualToString:@""]) {
        [self.view resignFirstResponder];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    // 刷新任务中心列表
    [[NSNotificationCenter defaultCenter] postNotificationName:@"taskListFuction" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"getMyAccountInfo" object:nil];
    
    if (![FileOfManage ExistOfFile:@"Member.plist"]) {
        [FileOfManage createWithFile:@"Member.plist"];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSString stringWithFormat:@"%@",tokenString],@"token",nil];
        [dic writeToFile:[FileOfManage PathOfFile:@"Member.plist"] atomically:YES];
    } else {
        NSMutableDictionary *usersDic = [[NSMutableDictionary alloc]initWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
        //设置属性值,没有的数据就新建，已有的数据就修改。
        [usersDic setObject:[NSString stringWithFormat:@"%@",tokenString] forKey:@"token"];
        //写入文件
        [usersDic writeToFile:[FileOfManage PathOfFile:@"Member.plist"] atomically:YES];
    }
    
    if (![FileOfManage ExistOfFile:@"isLogin.plist"]) {
        [FileOfManage createWithFile:@"isLogin.plist"];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"YES",@"loginFlag",nil];
        [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
    } else {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"YES",@"loginFlag",nil];
        [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
    }
    
    [self getData];
    
    [self.view resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];

    
}

- (void)reloadWithWebview:(NSNotification *)not{
    
    NSString *notString = [not object];
    
    UIWebView *wView = (UIWebView *)[self.view viewWithTag:9092];
    
    NSString *newURLString = [NSString stringWithFormat:@"%@%@",urlStringTwo,notString];
    
    NSLog(@"newURLString = %@",newURLString);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:newURLString]];
    
    [wView loadRequest:request];
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
