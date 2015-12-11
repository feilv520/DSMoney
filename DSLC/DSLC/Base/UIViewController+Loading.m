//
//  UIViewController+Loading.m
//  DSLC
//
//  Created by 马成铭 on 15/11/20.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "UIViewController+Loading.h"
#import "AppDelegate.h"

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

- (void)loadingWithView:(UIView *)view loadingFlag:(BOOL)loadingFlag height:(CGFloat)height{
    
    NSMutableArray *imgArray = [NSMutableArray array];
    
    UIImageView *loadingImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    
    loadingImgView.tag = 9098;
    
    loadingImgView.center = CGPointMake(self.view.center.x, height);
    
    
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
    [noDateLabel setText:@"无数据"];
    noDateLabel.textAlignment = NSTextAlignmentCenter;
    
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
    [hud hide:YES afterDelay:0.8];
}


@end
