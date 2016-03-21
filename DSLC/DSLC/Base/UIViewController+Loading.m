//
//  UIViewController+Loading.m
//  DSLC
//
//  Created by 马成铭 on 15/11/20.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "UIViewController+Loading.h"
#import "AppDelegate.h"
#import "newLoginView.h"

@implementation UIViewController (Loading) 

#pragma mark tableview添加上拉加载下拉刷新
#pragma mark --------------------------------

// 下拉刷新
- (void)addTableViewWithHeader:(UITableView *)tableview{
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData:)];
    
    NSMutableArray *images = [NSMutableArray array];
    for (NSUInteger i = 1; i<=4; i++) {
        UIImage *image = [[UIImage alloc] init];
        image = [UIImage imageNamed:[NSString stringWithFormat:@"loading_up_0%zd", i]];
        [images addObject:image];
    }
    
    [header setImages:images forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=8; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading_up_0%zd", i]];
        [refreshingImages addObject:image];
    }
    
    [header setImages:refreshingImages forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
    // 设置header
    tableview.mj_header = header;
}

// 下拉刷新方法
- (void)loadNewData:(MJRefreshGifHeader *)header{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{        // 刷新表格
        [header endRefreshing];        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    });
}

// 上拉加载
- (void)addTableViewWithFooter:(UITableView *)tableview{
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData:)];
    
    NSMutableArray *images = [NSMutableArray array];
    for (NSUInteger i = 1; i<=4; i++) {
        UIImage *image = [[UIImage alloc] init];
        image = [UIImage imageNamed:[NSString stringWithFormat:@"loading_up_0%zd", i]];
        [images addObject:image];
    }
    // 设置普通状态的动画图片
    [footer setImages:images forState:MJRefreshStateIdle];
    
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=8; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading_up_0%zd", i]];
        [refreshingImages addObject:image];
    }
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [footer setImages:refreshingImages forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [footer setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    // 设置尾部
    tableview.mj_footer.automaticallyHidden = NO;
    tableview.mj_footer = footer;
    
}

// 上拉加载方法
- (void)loadMoreData:(MJRefreshBackGifFooter *)footer{
    //    / 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 拿到当前的上拉刷新控件，结束刷新状态
        [footer endRefreshing];
    });
}

- (void)loadingWithView:(UIView *)view loadingFlag:(BOOL)loadingFlag height:(CGFloat)height
{
    NSMutableArray *imgArray = [NSMutableArray array];
    
    UIImageView *loadingImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    
    loadingImgView.tag = 9098;
    
    if (WIDTH_CONTROLLER_DEFAULT == 320) {
        loadingImgView.center = CGPointMake(160, height);
    } else {
        loadingImgView.center = CGPointMake(self.view.center.x, height);
    }
    
    for (NSInteger i = 1; i <= 8; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading_middle_0%ld",(long)i]];
        [imgArray addObject:image];
    }
    
    loadingImgView.hidden = loadingFlag;
    
    loadingImgView.animationImages = imgArray;
    
    loadingImgView.animationDuration = 1.0;
    
    loadingImgView.animationRepeatCount = 0;
    
    [loadingImgView startAnimating];
    
    [view addSubview:loadingImgView];
}

- (void)submitLoadingWithView:(UIView *)view loadingFlag:(BOOL)loadingFlag height:(CGFloat)height
{
    NSMutableArray *imgArray = [NSMutableArray array];
    
    UIImageView *loadingImgView ;
    
    if (loadingImgView == nil) {
        loadingImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    } else {
        [self submitLoadingWithHidden:NO view:view];
    }
    
    loadingImgView.tag = 1989;
    if ([view isKindOfClass:[newLoginView class]]) {
        loadingImgView.center = CGPointMake(160, view.frame.size.height / 2.0);
    } else {
        loadingImgView.center = CGPointMake(view.center.x, view.frame.size.height / 2.0);
    }
    for (NSInteger i = 1; i <= 8; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading_middle_0%ld",(long)i]];
        [imgArray addObject:image];
    }
    loadingImgView.hidden = loadingFlag;
    
    loadingImgView.animationImages = imgArray;
    
    loadingImgView.animationDuration = 1.0;
    
    loadingImgView.animationRepeatCount = 0;
    
    [loadingImgView startAnimating];
    
    UIView *viewGray = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor blackColor]];
    viewGray.alpha = 0.3;
    
    UILabel *labelRoad = [CreatView creatWithLabelFrame:CGRectMake(0, CGRectGetMaxY(loadingImgView.frame) + 20, view.frame.size.width, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"取经路漫漫,请耐心..."];
    [viewGray addSubview:labelRoad];
    
    [view addSubview:viewGray];
    [view addSubview:loadingImgView];
    viewGray.tag = 690;
    loadingImgView.alpha = 1;
}

- (void)submitLoadingWithHidden:(BOOL)hidden{
    UIView *viewDisappear = (UIView *)[self.view viewWithTag:690];
    viewDisappear.hidden = hidden;
    
    UIImageView *loadingImg = (UIImageView *)[self.view viewWithTag:1989];
    loadingImg.hidden = hidden;
}

- (void)submitLoadingWithHidden:(BOOL)hidden view:(UIView *)view
{
    UIView *viewDisappear = (UIView *)[view viewWithTag:690];
    viewDisappear.hidden = hidden;
    
    UIImageView *loadingImg = (UIImageView *)[view viewWithTag:1989];
    loadingImg.hidden = hidden;
}

- (void)loadingWithHidden:(BOOL)hidden{
    UIImageView *loadingImgView = (UIImageView *)[self.view viewWithTag:9098];
    
    loadingImgView.hidden = hidden;
}

- (NSString*)decryptUseDES:(NSString*)cipherText{
    
    NSString* key = @"o0al4OaEWBzA1";
    // 利用 GTMBase64 解碼 Base64 字串
    NSData* cipherData = [GTMBase64 decodeString:cipherText];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    
    // IV 偏移量不需使用
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding| kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          nil,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          1024,
                                          &numBytesDecrypted);
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] ;
    }
    return plainText;
}

- (NSString *)encryptUseDES:(NSString *)clearText
{
    NSString* key = @"o0al4OaEWBzA1";
    NSData *data = [clearText dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding| kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          nil,
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          1024,
                                          &numBytesEncrypted);
    
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData *dataTemp = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        plainText = [GTMBase64 stringByEncodingData:dataTemp];
    }else{
        NSLog(@"DES加密失败");
    }
    return plainText;
}

- (void)noDateWithView:(NSString *)nameString height:(CGFloat)height view:(UIView *)view{
    UIView *noDateView = [[UIView alloc] initWithFrame:CGRectMake(0, height, WIDTH_CONTROLLER_DEFAULT, 200)];
    
    noDateView.tag = 9909;
    
    noDateView.backgroundColor = Color_Clear;
    
    [view addSubview:noDateView];
    
    UIImageView *noDateImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"filefile"]];
    noDateImgV.frame = CGRectMake(0, 0, 58, 58);

    noDateImgV.center = CGPointMake(view.center.x, 0);

    
    [noDateView addSubview:noDateImgV];
    
    UILabel *noDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(noDateImgV.frame), WIDTH_CONTROLLER_DEFAULT, 25)];
    [noDateLabel setText:nameString];
    noDateLabel.textAlignment = NSTextAlignmentCenter;
    noDateLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    
    [noDateView addSubview:noDateLabel];
    
}

- (void)noDataViewWithRemoveToView{
    UIView *noDateView = [self.view viewWithTag:9909];
    
    [noDateView removeFromSuperview];
}

- (NSInteger)sizeOfLength:(NSString *)string{
    if (string.length >= 8) {
        if (self.view.frame.size.width == 320) {
            return 12;
        } else {
            return 15;
        }
    } else {
        if (self.view.frame.size.width == 320) {
            return 15;
        } else {
            return 17;
        }
    }
}

- (void)showTanKuangWithMode:(MBProgressHUDMode)mode Text:(NSString *)text
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:app.tabBarVC.view animated:YES];
    hud.mode = mode;
    hud.labelText = text;
    hud.labelFont = [UIFont systemFontOfSize:12];
    hud.minSize = CGSizeMake(0, 55);
    hud.margin = 10;
    hud.yOffset = -50;
    hud.cornerRadius = 5.0f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.6];
}

#pragma mark 登陆界面是否显示出来
#pragma mark --------------------------------

- (void)ifLoginView{
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    UIView *viewGray;
    
    if (viewGray == nil) {
        viewGray = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor blackColor]];
    } else {
        viewGray.hidden = NO;
    }
    
    viewGray.alpha = 0.3;
    
    viewGray.tag = 99999;
    
    UITapGestureRecognizer *pan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeView:)];
    
    [viewGray addGestureRecognizer:pan];
    
    NSBundle *rootBundle = [NSBundle mainBundle];
    
    newLoginView *newLView = (newLoginView *)[[rootBundle loadNibNamed:@"newLoginView" owner:nil options:nil] lastObject];
    
    newLView.inviteNumber.delegate = self;
    newLView.phoneNumber.delegate = self;
    
    newLView.tag = 6654;
    
    newLView.frame = CGRectMake((WIDTH_CONTROLLER_DEFAULT - 300) / 2.0, 115, 300, 300);
    
    newLView.layer.masksToBounds = YES;
    newLView.layer.cornerRadius = 5;
    
    [newLView.oneLogin addTarget:self action:@selector(exchangeAction:) forControlEvents:UIControlEventTouchUpInside];
    [newLView.twoLogin addTarget:self action:@selector(exchangeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    newLView.getEnsureNumber.layer.masksToBounds = YES;
    newLView.getEnsureNumber.layer.borderWidth = 1.f;
    newLView.getEnsureNumber.tag = 9080;
    newLView.getEnsureNumber.layer.borderColor = [UIColor daohanglan].CGColor;
    [newLView.getEnsureNumber setTitleColor:[UIColor daohanglan] forState:UIControlStateNormal];
    newLView.getEnsureNumber.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    
    newLView.getEnsureNumber.layer.cornerRadius = 4.f;
    
    [newLView.getEnsureNumber addTarget:self action:@selector(getCodeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [newLView.loginButton addTarget:self action:@selector(tLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [app.tabBarVC.view addSubview:viewGray];
    [app.tabBarVC.view addSubview:newLView];
    
}

- (void)exchangeAction:(UIButton *)sender{
    
    newLoginView *newLView = (newLoginView *)sender.superview;
    
    newLView.ensureNumber.keyboardType = UIKeyboardTypeNumberPad;
    
    if (sender == newLView.oneLogin) {
        
        newLView.backImageView.image = [UIImage imageNamed:@"loginViewP"];
        
        newLView.oneLogin.tintColor = Color_White;
        newLView.twoLogin.tintColor = Color_Black;
        
        newLView.getEnsureNumber.hidden = NO;
        newLView.ensureNumber.hidden = NO;
        newLView.threeLineView.hidden = NO;
        newLView.ensureNumberLabel.hidden = NO;
        
        newLView.inviteNumberLabel.hidden = NO;
        newLView.phoneNumberLabel.hidden = NO;
        
        newLView.selectLabel.hidden = NO;
        
        newLView.tPhoneNumberLabel.hidden = YES;
        newLView.tPasswordNumberLabel.hidden = YES;
        newLView.mimaLabel.hidden = YES;
        newLView.phoneLabel.hidden = YES;
        
        newLView.inviteNumber.keyboardType = UIKeyboardTypeDefault;
        newLView.phoneNumber.keyboardType = UIKeyboardTypeNumberPad;
        
        newLView.inviteNumber.placeholder = @"请输入邀请码";
        newLView.phoneNumber.placeholder = @"请输入手机号";
        
        newLView.phoneNumber.secureTextEntry = NO;
        
        newLView.inviteNumber.text = @"";
        newLView.phoneNumber.text = @"";
        
        [newLView.loginButton removeTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
        [newLView.loginButton addTarget:self action:@selector(tLoginAction:) forControlEvents:UIControlEventTouchUpInside];
        
    } else {
    
        newLView.backImageView.image = [UIImage imageNamed:@"loginViewUP"];
        
        newLView.twoLogin.tintColor = Color_White;
        newLView.oneLogin.tintColor = Color_Black;
        
        newLView.getEnsureNumber.hidden = YES;
        newLView.ensureNumber.hidden = YES;
        newLView.threeLineView.hidden = YES;
        newLView.ensureNumberLabel.hidden = YES;
        
        newLView.inviteNumberLabel.hidden = YES;
        newLView.phoneNumberLabel.hidden = YES;
        
        newLView.selectLabel.hidden = YES;
        
        newLView.tPhoneNumberLabel.hidden = NO;
        newLView.tPasswordNumberLabel.hidden = NO;
        newLView.mimaLabel.hidden = NO;
        newLView.phoneLabel.hidden = NO;
        
        newLView.inviteNumber.keyboardType = UIKeyboardTypeNumberPad;
        newLView.phoneNumber.keyboardType = UIKeyboardTypeDefault;
        
        newLView.inviteNumber.placeholder = @"请输入手机号";
        newLView.phoneNumber.placeholder = @"请输入密码";
        
        newLView.phoneNumber.secureTextEntry = YES;
        
        newLView.inviteNumber.text = @"";
        newLView.phoneNumber.text = @"";
        
        [newLView.loginButton removeTarget:self action:@selector(tLoginAction:) forControlEvents:UIControlEventTouchUpInside];
        [newLView.loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}

// 获得验证码
- (void)getCodeButtonAction:(UIButton *)btn{
    [self.view endEditing:YES];
    
    newLoginView *newLView = (newLoginView *)btn.superview;
    
    if (newLView.phoneNumber.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入手机号"];
        
    } else if (![NSString validateMobile:newLView.phoneNumber.text]) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"手机号格式错误"];
        
    } else {
        
        NSDictionary *parameters = @{@"phone":newLView.phoneNumber.text,@"msgType":@"1"};
        [[MyAfHTTPClient sharedClient] postWithURLString:@"app/getSmsCode" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:@"系统异常"];
            NSLog(@"%@",error);
        }];
    }
}

- (void)closeView:(UIPanGestureRecognizer *)pan{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    newLoginView *newLView = [app.tabBarVC.view.subviews lastObject];
    NSMutableArray *array = [app.tabBarVC.view.subviews mutableCopy];
    [array removeLastObject];
    UIView *viewGray = [array lastObject];
    [viewGray removeFromSuperview];
    [newLView removeFromSuperview];
}

// 登录按钮执行方法
- (void)loginAction:(UIButton *)sender{
    
    newLoginView *newLView = (newLoginView *)sender.superview;
    
    [self.view endEditing:YES];
    UITextField *textField1 = newLView.inviteNumber;
    UITextField *textField2 = newLView.phoneNumber;
    
    if (textField1.text.length == 11 && (textField2.text.length >= 6 && textField2.text.length <= 20)) {
        if (![NSString validatePassword:textField2.text]) {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:@"首字母开头"];
        } else if ([NSString validateMobile:textField1.text]) {
            [self submitLoadingWithView:newLView loadingFlag:0 height:HEIGHT_CONTROLLER_DEFAULT/2 - 50];
            NSDictionary *parameter = @{@"phone":textField1.text,@"password":textField2.text};
            NSLog(@"%@",parameter);
            [[MyAfHTTPClient sharedClient] postWithURLString:@"app/login" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
                
                [self submitLoadingWithHidden:YES view:newLView];
                if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
                    // 判断是否存在Member.plist文件
                    NSLog(@"%@",responseObject);
                    
                    NSMutableArray *array = [newLView.superview.subviews mutableCopy];
                    [array removeLastObject];
                    UIView *viewGray = [array lastObject];
                    [viewGray removeFromSuperview];
                    [newLView removeFromSuperview];
                    
                    [MobClick profileSignInWithPUID:[[responseObject objectForKey:@"User"] objectForKey:@"id"]];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"refrushToPickProduct" object:nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"refrushToProductList" object:nil];
                    if (![FileOfManage ExistOfFile:@"Member.plist"]) {
                        [FileOfManage createWithFile:@"Member.plist"];
                        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                             [DES3Util encrypt:textField1.text],@"password",
                                             [[responseObject objectForKey:@"User"] objectForKey:@"id"],@"id",
                                             [[responseObject objectForKey:@"User"] objectForKey:@"userNickname"],@"userNickname",
                                             [[responseObject objectForKey:@"User"] objectForKey:@"avatarImg"],@"avatarImg",
                                             [[responseObject objectForKey:@"User"] objectForKey:@"userAccount"],@"userAccount",
                                             [[responseObject objectForKey:@"User"] objectForKey:@"userPhone"],@"userPhone",
                                             [responseObject objectForKey:@"token"],@"token",
                                             [[responseObject objectForKey:@"User"] objectForKey:@"registerTime"],@"registerTime",nil];
                        [dic writeToFile:[FileOfManage PathOfFile:@"Member.plist"] atomically:YES];
                    } else {
                        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                             [DES3Util encrypt:textField1.text],@"password",
                                             [[responseObject objectForKey:@"User"] objectForKey:@"id"],@"id",
                                             [[responseObject objectForKey:@"User"] objectForKey:@"userNickname"],@"userNickname",
                                             [[responseObject objectForKey:@"User"] objectForKey:@"avatarImg"],@"avatarImg",
                                             [[responseObject objectForKey:@"User"] objectForKey:@"userAccount"],@"userAccount",
                                             [[responseObject objectForKey:@"User"] objectForKey:@"userPhone"],@"userPhone",
                                             [responseObject objectForKey:@"token"],@"token",
                                             [[responseObject objectForKey:@"User"] objectForKey:@"registerTime"],@"registerTime",nil];
                        [dic writeToFile:[FileOfManage PathOfFile:@"Member.plist"] atomically:YES];
                    }
                    // 判断是否存在isLogin.plist文件
                    if (![FileOfManage ExistOfFile:@"isLogin.plist"]) {
                        [FileOfManage createWithFile:@"isLogin.plist"];
                        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"YES",@"loginFlag",nil];
                        [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
                    } else {
                        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"YES",@"loginFlag",nil];
                        [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
                    }
                    
                    [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
                    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hideWithTabbarView" object:nil];
                    
                    textField1.text = @"";
                    textField2.text = @"";
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"dian" object:nil];
                    
                } else {
                    NSLog(@"%@",responseObject);
                    [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
                    
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@",error);
            }];
        } else {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:@"手机号格式错误"];
        }
        
    } else if(textField1.text.length == 0) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入手机号"];
        
    } else if(textField1.text.length < 11) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"手机号格式错误"];
        
    } else if (textField2.text.length == 0) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入密码"];
        
    } else if (textField2.text.length < 6) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"6~20位字符，至少包含字母和数字两种"];
        
    }
    
}

- (void)tLoginAction:(UIButton *)sender{
    newLoginView *newLView = (newLoginView *)sender.superview;
    
    [self.view endEditing:YES];
    UITextField *textField1 = newLView.inviteNumber;
    UITextField *textField2 = newLView.phoneNumber;
    UITextField *textField3 = newLView.ensureNumber;
    
    if (textField2.text.length == 11) {
        if ([NSString validateMobile:textField2.text]) {
            [self submitLoadingWithView:newLView loadingFlag:0 height:HEIGHT_CONTROLLER_DEFAULT/2 - 50];
            NSDictionary *parameter;
            if ([textField1.text isEqualToString:@""]) {
                parameter = @{@"phone":textField2.text,@"smsCode":textField3.text,@"invitationCode":@"",@"clientType":@"iOS"};
            } else {
                parameter = @{@"phone":textField2.text,@"smsCode":textField3.text,@"invitationCode":textField1.text,@"clientType":@"iOS"};
            }
            NSLog(@"%@",parameter);
            [[MyAfHTTPClient sharedClient] postWithURLString:@"app/registerTwo" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
                
                if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
                    // 判断是否存在Member.plist文件
                    [self submitLoadingWithHidden:YES view:newLView];
                    NSLog(@"%@",responseObject);
                    
                    NSMutableArray *array = [newLView.superview.subviews mutableCopy];
                    [array removeLastObject];
                    UIView *viewGray = [array lastObject];
                    [viewGray removeFromSuperview];
                    [newLView removeFromSuperview];
                    
                    [MobClick profileSignInWithPUID:[[responseObject objectForKey:@"User"] objectForKey:@"id"]];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"refrushToPickProduct" object:nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"refrushToProductList" object:nil];
                    if (![FileOfManage ExistOfFile:@"Member.plist"]) {
                        [FileOfManage createWithFile:@"Member.plist"];
                        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                             [DES3Util encrypt:textField1.text],@"password",
                                             [[responseObject objectForKey:@"User"] objectForKey:@"id"],@"id",
                                             [[responseObject objectForKey:@"User"] objectForKey:@"userNickname"],@"userNickname",
                                             [[responseObject objectForKey:@"User"] objectForKey:@"avatarImg"],@"avatarImg",
                                             [[responseObject objectForKey:@"User"] objectForKey:@"userAccount"],@"userAccount",
                                             [[responseObject objectForKey:@"User"] objectForKey:@"userPhone"],@"userPhone",
                                             [responseObject objectForKey:@"token"],@"token",
                                             [[responseObject objectForKey:@"User"] objectForKey:@"registerTime"],@"registerTime",nil];
                        [dic writeToFile:[FileOfManage PathOfFile:@"Member.plist"] atomically:YES];
                    } else {
                        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                             [DES3Util encrypt:textField1.text],@"password",
                                             [[responseObject objectForKey:@"User"] objectForKey:@"id"],@"id",
                                             [[responseObject objectForKey:@"User"] objectForKey:@"userNickname"],@"userNickname",
                                             [[responseObject objectForKey:@"User"] objectForKey:@"avatarImg"],@"avatarImg",
                                             [[responseObject objectForKey:@"User"] objectForKey:@"userAccount"],@"userAccount",
                                             [[responseObject objectForKey:@"User"] objectForKey:@"userPhone"],@"userPhone",
                                             [responseObject objectForKey:@"token"],@"token",
                                             [[responseObject objectForKey:@"User"] objectForKey:@"registerTime"],@"registerTime",nil];
                        [dic writeToFile:[FileOfManage PathOfFile:@"Member.plist"] atomically:YES];
                    }
                    // 判断是否存在isLogin.plist文件
                    if (![FileOfManage ExistOfFile:@"isLogin.plist"]) {
                        [FileOfManage createWithFile:@"isLogin.plist"];
                        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"YES",@"loginFlag",nil];
                        [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
                    } else {
                        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"YES",@"loginFlag",nil];
                        [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
                    }
                    
                    [self showTanKuangWithMode:MBProgressHUDModeText Text:@"为了您的账户安全请务必在个人信息里设置登录密码"];
                    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hideWithTabbarView" object:nil];
                    
                    textField1.text = @"";
                    textField2.text = @"";
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"dian" object:nil];
                    
                } else {
                    NSLog(@"%@",responseObject);
                    [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
                    
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@",error);
            }];
        } else {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:@"手机号格式错误"];
        }
        
    } else if(textField2.text.length == 0) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入手机号"];
        
    } else if(textField2.text.length < 11) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"手机号格式错误"];
        
    }

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    newLoginView *newLView = [app.tabBarVC.view.subviews lastObject];

    if (![newLView isKindOfClass:[newLoginView class]]) {
        return YES;
    }
    
    if (textField == newLView.phoneNumber || textField == newLView.inviteNumber || textField == newLView.ensureNumber) {
        if (textField == newLView.inviteNumber) {
            
            if (range.location < 11) {
                
                return YES;
                
            } else {
                
                return NO;
            }
            
        } else if(textField == newLView.phoneNumber){
            
            if (range.location < 20) {
                
                return YES;
                
            } else {
                
                return NO;
            }
        } else {
            return NO;
        }
    } else {
        return NO;
    }
}

@end
