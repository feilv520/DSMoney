//
//  NewInviteViewController.m
//  DSLC
//
//  Created by ios on 16/4/14.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "NewInviteViewController.h"
#import "InviteRecordViewController.h"
#import "InviteNewView.h"
#import "AdModel.h"
#import "YYAnimatedImageView.h"
#import "BannerViewController.h"

@interface NewInviteViewController () <UMSocialUIDelegate>

{
    UIButton *butReceive;
    UIScrollView *scrollview;
    
    InviteNewView *inviteNV;
    
    UIView *viewGray;
    
    NSMutableArray *adModelArray;
    
    NSString *fString;
    
    YYAnimatedImageView *imageViewBanner;
}

@end

@implementation NewInviteViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    butReceive.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor qianhuise];
    [self.navigationItem setTitle:@"我的邀请"];
    
    adModelArray = [NSMutableArray array];
    
    butReceive = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 65, 8, 56, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"邀请记录"];
    butReceive.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    [self.navigationController.navigationBar addSubview:butReceive];
    [butReceive addTarget:self action:@selector(inviteRecordButton:) forControlEvents:UIControlEventTouchUpInside];
    
    viewGray = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor blackColor]];
    viewGray.alpha = 0.3;
    
    [self getAdvList];
    
    [self contentShow];
    
    viewGray.hidden = YES;
}

- (void)contentShow
{
    scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 30 - 40.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) - 10)];
    [self.view addSubview:scrollview];
    scrollview.backgroundColor = [UIColor qianhuise];
    scrollview.contentSize = CGSizeMake(0, 1000.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT);
    
    imageViewBanner = [[YYAnimatedImageView alloc] init];
    imageViewBanner.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 150.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT);
    imageViewBanner.backgroundColor = [UIColor qianhuise];
    imageViewBanner.yy_imageURL = [NSURL URLWithString:[[adModelArray firstObject] adImg]];
    [scrollview addSubview:imageViewBanner];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClickedImageView:)];
    [imageViewBanner addGestureRecognizer:tap];
    imageViewBanner.userInteractionEnabled = YES;
    
    UILabel *labelSao = [CreatView creatWithLabelFrame:CGRectMake(0, imageViewBanner.frame.size.height + 20.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT, WIDTH_CONTROLLER_DEFAULT, (20.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT)) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"扫二维码下载大圣理财"];
    [scrollview addSubview:labelSao];
    
    UIView *viewTwo = [CreatView creatViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 90, imageViewBanner.frame.size.height + labelSao.frame.size.height + 20.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT + (10.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT), 180, 180) backgroundColor:[UIColor whiteColor]];
    [scrollview addSubview:viewTwo];
    
    CGFloat viewTwoW = viewTwo.frame.size.width;
    CGFloat viewTwoH = viewTwo.frame.size.height;
    
//    二维码图片
    UIImageView *imageViewTwo = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, viewTwoW, viewTwoH) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"TWOInviteNumber"]];
    [viewTwo addSubview:imageViewTwo];
    
    UILabel *labelCode = [CreatView creatWithLabelFrame:CGRectMake(0, imageViewBanner.frame.size.height + labelSao.frame.size.height + 20.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT + (10.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT) + 180, WIDTH_CONTROLLER_DEFAULT, 50.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor clearColor] textColor:nil textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:nil];
    [scrollview addSubview:labelCode];
    NSMutableAttributedString *codeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"我的邀请码: %@", self.inviteCode]];
    NSRange leftRange = NSMakeRange(0, [[codeString string] rangeOfString:@" "].location);
    [codeString addAttribute:NSForegroundColorAttributeName value:[UIColor zitihui] range:leftRange];
    NSRange rightRange = NSMakeRange([[codeString string] length] - 7, 7);
    [codeString addAttribute:NSForegroundColorAttributeName value:[UIColor orangecolor] range:rightRange];
    [labelCode setAttributedText:codeString];
    
    UIView *viewRule = [CreatView creatViewWithFrame:CGRectMake(10, imageViewBanner.frame.size.height + labelSao.frame.size.height + 20.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT + (10.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT) + 180 + 50.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT, WIDTH_CONTROLLER_DEFAULT - 20, 220.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor whiteColor]];
    [scrollview addSubview:viewRule];
    viewRule.layer.cornerRadius = 5;
    viewRule.layer.masksToBounds = YES;
    
    UIView *viewBottom = [CreatView creatViewWithFrame:CGRectMake(0, scrollview.frame.size.height, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - scrollview.frame.size.height) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewBottom];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [viewBottom addSubview:viewLine];
    viewLine.alpha = 0.3;
    
    UIButton *butSend = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 10, WIDTH_CONTROLLER_DEFAULT - 80, 40.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"立即邀请"];
    [viewBottom addSubview:butSend];
    butSend.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butSend setBackgroundImage:[UIImage imageNamed:@"蓝色完成"] forState:UIControlStateNormal];
    [butSend setBackgroundImage:[UIImage imageNamed:@"蓝色完成"] forState:UIControlStateHighlighted];
    [butSend addTarget:self action:@selector(buttonSendInvite:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat viewRuleW = viewRule.frame.size.width;
    CGFloat viewRuleH = viewRule.frame.size.height;
    
    UILabel *labelRule = [CreatView creatWithLabelFrame:CGRectMake(5, 5, viewRuleW - 10, viewRuleH - 10) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"邀请规则:\n\n1. 注册即送5000元体验金和红包;\n2. 当您邀请的好友成功注册并完成投资后，您将获得特权本金，享受同等金额的特权本金收益;\n3. 邀请好友您将有机会获得红包;\n4. 快去邀请好友，成为超级理财师吧!"];
    [viewRule addSubview:labelRule];
    labelRule.numberOfLines = 0;
    
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {

        viewRule.frame = CGRectMake(10, imageViewBanner.frame.size.height + labelSao.frame.size.height + 20.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT + (10.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT) + 180 + 50.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT, WIDTH_CONTROLLER_DEFAULT - 20, 140.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT + 60);
        
        CGFloat viewRuleW = viewRule.frame.size.width;
        CGFloat viewRuleH = viewRule.frame.size.height;
        labelRule.frame = CGRectMake(5, 5, viewRuleW - 10, viewRuleH - 10);
        
        scrollview.contentSize = CGSizeMake(0, 770.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT);
        
    } else if (HEIGHT_CONTROLLER_DEFAULT - 20 == 568) {
        
        viewRule.frame = CGRectMake(10, imageViewBanner.frame.size.height + labelSao.frame.size.height + 20.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT + (10.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT) + 180 + 50.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT, WIDTH_CONTROLLER_DEFAULT - 20, 150.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT + 30);
        
        CGFloat viewRuleW = viewRule.frame.size.width;
        CGFloat viewRuleH = viewRule.frame.size.height;
        labelRule.frame = CGRectMake(5, 5, viewRuleW - 10, viewRuleH - 10);
        
        scrollview.contentSize = CGSizeMake(0, 700.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT);
        
    } else if (HEIGHT_CONTROLLER_DEFAULT - 20 == 667) {
        
        viewRule.frame = CGRectMake(10, imageViewBanner.frame.size.height + labelSao.frame.size.height + 20.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT + (10.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT) + 180 + 50.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT, WIDTH_CONTROLLER_DEFAULT - 20, 140.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT);
        
        CGFloat viewRuleW = viewRule.frame.size.width;
        CGFloat viewRuleH = viewRule.frame.size.height;
        labelRule.frame = CGRectMake(5, 5, viewRuleW - 10, viewRuleH - 10);
        
        scrollview.contentSize = CGSizeMake(0, 600.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT);
        
    } else {
        
        viewRule.frame = CGRectMake(10, imageViewBanner.frame.size.height + labelSao.frame.size.height + 20.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT + (10.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT) + 180 + 50.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT, WIDTH_CONTROLLER_DEFAULT - 20, 40.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT + 100);
        
        CGFloat viewRuleW = viewRule.frame.size.width;
        CGFloat viewRuleH = viewRule.frame.size.height;
        labelRule.frame = CGRectMake(5, 5, viewRuleW - 10, viewRuleH - 10);
        
        scrollview.contentSize = CGSizeMake(0, scrollview.frame.size.height + 10);
    }
    
}

- (void)tapClickedImageView:(UITapGestureRecognizer *)tap
{
    NSLog(@"33333333333333");
    BannerViewController *bannerVC = [[BannerViewController alloc] init];
    
    if (adModelArray.count == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"暂未开启,敬请期待"];
    }else {
        bannerVC.photoName = [[adModelArray objectAtIndex:0] adLabel];
        bannerVC.photoUrl = [[adModelArray objectAtIndex:0] adLink];
        pushVC(bannerVC);
    }
}

//发送邀请按钮
- (void)buttonSendInvite:(UIButton *)button
{
    
    NSString *shareString;
    
    if ([[[self.flagDic objectForKey:@"realnameStatus"] description] isEqualToString:@"2"]) {
        shareString = [NSString stringWithFormat:@"http://wap.dslc.cn/app/appInvite.html?name=%@&inviteCode=%@", [DES3Util decrypt:[self.flagDic objectForKey:@"realName"]], self.inviteCode];
    } else {
        shareString = [NSString stringWithFormat:@"%@%@%@%@", @"http://wap.dslc.cn/app/appInvite.html?name=", [self.flagDic objectForKey:@"phone"], @"&inviteCode=", self.inviteCode];
    }
    NSLog(@"sssssssssssssss%@", [DES3Util decrypt:[self.flagDic objectForKey:@"realName"]]);
    shareString = [shareString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"aaaaaaaaaaaaaaaaaaaa%@", shareString);
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5642ad7e67e58e8463006218"
                                      shareText:[NSString stringWithFormat:@"大圣理财风暴来袭:喝咖啡,领红包,赚猴币多重惊喜等着你!  %@", shareString]
                                     shareImage:[UIImage imageNamed:@"fenxiangtouxiang"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToQQ,UMShareToWechatSession,UMShareToWechatTimeline,nil]
                                       delegate:self];
    
    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"邀请好友一起，免费共享星巴克";
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"邀请好友一起，免费共享星巴克";
    [UMSocialData defaultData].extConfig.qqData.title = @"邀请好友一起，免费共享星巴克";
    
    [UMSocialData defaultData].extConfig.wechatSessionData.url = shareString;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = shareString;
    [UMSocialData defaultData].extConfig.qqData.url = shareString;
    
}

- (void)inviteRecordButton:(UIBarButtonItem *)button
{
    InviteRecordViewController *InviteRecord = [[InviteRecordViewController alloc] init];
    InviteRecord.inviteCode = self.inviteCode;
    NSLog(@"%@",self.inviteCode);
    [self.navigationController pushViewController:InviteRecord animated:YES];
}

#pragma mark 分享成功回调方法
#pragma mark --------------------------------

- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

#pragma mark 网络请求方法
#pragma mark --------------------------------

- (void)getAdvList{
    
    NSDictionary *parmeter = @{@"adType":@"2",@"adPosition":@"10"};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"front/getAdvList" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"ADProduct = %@",responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:500]]) {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            return ;
        }
        
        for (NSDictionary *dic in [responseObject objectForKey:@"Advertise"]) {
            AdModel *adModel = [[AdModel alloc] init];
            [adModel setValuesForKeysWithDictionary:dic];
            [adModelArray addObject:adModel];
        }
        
//        [self contentShow];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    butReceive.hidden = YES;
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
