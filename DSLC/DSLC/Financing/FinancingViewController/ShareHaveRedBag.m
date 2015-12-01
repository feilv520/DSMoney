//
//  ShareHaveRedBag.m
//  DSLC
//
//  Created by ios on 15/11/5.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "ShareHaveRedBag.h"
#import "CashOtherFinViewController.h"
#import "define.h"


@interface ShareHaveRedBag () <UMSocialUIDelegate>

{
    UIButton *butSurprise;
    
    UILabel *labelGet;
}

@property (nonatomic, strong) NSDictionary *openRedBagDic;

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ShareHaveRedBag

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"支付完成"];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(buttonNothing:)];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishLastBarPress:)];
//    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:13], NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
//
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT)];
    
    self.scrollView.contentSize = CGSizeMake(1, 750);
    
    [self.view addSubview:self.scrollView];
    
    [self contentShow];
}

- (void)contentShow
{
    UIButton *butonDo = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 60, WIDTH_CONTROLLER_DEFAULT, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] titleText:@"恭喜你投资成功 !"];
    [butonDo setImage:[UIImage imageNamed:@"iconfont_complete"] forState:UIControlStateNormal];
    [self.scrollView addSubview:butonDo];
    butonDo.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    UILabel *labelSurprise = [CreatView creatWithLabelFrame:CGRectMake(0, 90, WIDTH_CONTROLLER_DEFAULT, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"大圣豪礼很劲爆,打开有惊喜哦 !"];
    [self.scrollView addSubview:labelSurprise];
    
    UIButton *buttonOpen = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 150, WIDTH_CONTROLLER_DEFAULT - 80, 180) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [self.view addSubview:buttonOpen];
    [buttonOpen setBackgroundImage:[UIImage imageNamed:@"没打开的红包"] forState:UIControlStateNormal];
    [buttonOpen setBackgroundImage:[UIImage imageNamed:@"没打开的红包"] forState:UIControlStateHighlighted];
    [buttonOpen addTarget:self action:@selector(openRedBagButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *labelExplain = [CreatView creatWithLabelFrame:CGRectMake(0, 340, WIDTH_CONTROLLER_DEFAULT, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentCenter textFont:[UIFont systemFontOfSize:12] text:@"没打开?到“我的账户”-“红包活动”里打开"];
    [self.scrollView addSubview:labelExplain];
    
    UIButton *buttonGOON = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 400, (WIDTH_CONTROLLER_DEFAULT - 80 - 10)/2, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor daohanglan] titleText:@"继续投资"];
    [self.scrollView addSubview:buttonGOON];
    buttonGOON.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    buttonGOON.layer.cornerRadius = 3;
    buttonGOON.layer.masksToBounds = YES;
    buttonGOON.layer.borderColor = [[UIColor daohanglan] CGColor];
    buttonGOON.layer.borderWidth = 0.5;
    [buttonGOON addTarget:self action:@selector(finishLastBarPress:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonShare = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake((WIDTH_CONTROLLER_DEFAULT - 80 - 10)/2 + 50, 400, (WIDTH_CONTROLLER_DEFAULT - 80 - 10)/2, 40) backgroundColor:[UIColor daohanglan] textColor:[UIColor whiteColor] titleText:@"分享拿红包"];
    [self.scrollView addSubview:buttonShare];
    buttonShare.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    buttonShare.layer.cornerRadius = 3;
    buttonShare.layer.masksToBounds = YES;
    
    [buttonShare addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

//拆红包按钮
- (void)openRedBagButton:(UIButton *)button
{
//    AppDelegate *app = [[UIApplication sharedApplication] delegate];
//    
//    butSurprise = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
//    [app.tabBarVC.view addSubview:butSurprise];
//    [butSurprise setBackgroundImage:[UIImage imageNamed:@"钻石红包"] forState:UIControlStateNormal];
//    [butSurprise setBackgroundImage:[UIImage imageNamed:@"钻石红包"] forState:UIControlStateHighlighted];
//    [butSurprise addTarget:self action:@selector(didOpenRedBag:) forControlEvents:UIControlEventTouchUpInside];
//    
//    labelGet = [[UILabel alloc] initWithFrame:CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT/3 + 40, butSurprise.frame.size.width, 70)];
//    labelGet.textAlignment = NSTextAlignmentCenter;
//    labelGet.backgroundColor = [UIColor clearColor];
//    NSMutableAttributedString *frontStr = [[NSMutableAttributedString alloc] initWithString:@"恭喜您获得100元现金红包\n\n已转入账户余额"];
//    [frontStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:16] range:[@"恭喜您获得100元现金红包\n\n已转入账户余额" rangeOfString:@"恭喜您获得"]];
//    [frontStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:16] range:[@"恭喜您获得100元现金红包\n\n已转入账户余额" rangeOfString:@"元现金红包"]];
//    [frontStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:14] range:[@"恭喜您获得100元现金红包\n\n已转入账户余额" rangeOfString:@"已转入账户余额"]];
////    取到恭~0的长度 减掉5 就剩100
//    NSRange shuZi = NSMakeRange(5, [[frontStr string] rangeOfString:@"元"].location - 5);
//    [frontStr addAttribute:NSForegroundColorAttributeName value:[UIColor daohanglan] range:shuZi];
//    [frontStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:25] range:shuZi];
//    
//    [labelGet setAttributedText:frontStr];
//    
//    [butSurprise addSubview:labelGet];
//    labelGet.numberOfLines = 3;
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSDictionary *parameter = @{@"token":[dic objectForKey:@"token"],@"redPacketId":[self.redbagModel rpID]};
    
    NSLog(@"%@",parameter);
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/redpacket/openRedPacket" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"openRedPacket = %@",responseObject);
        
        self.openRedBagDic = [responseObject objectForKey:@"RedPacket"];
        
        butSurprise = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor blackColor] textColor:nil titleText:nil];
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        [app.tabBarVC.view addSubview:butSurprise];
        [butSurprise setBackgroundImage:[UIImage imageNamed:@"钻石红包"] forState:UIControlStateNormal];
        [butSurprise addTarget:self action:@selector(didOpenRedBag:) forControlEvents:UIControlEventTouchUpInside];
        
        labelGet = [[UILabel alloc] initWithFrame:CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT/3 + 40, butSurprise.frame.size.width, 70)];
        [butSurprise addSubview:labelGet];
        labelGet.textAlignment = NSTextAlignmentCenter;
        labelGet.backgroundColor = [UIColor clearColor];
        
        NSString *moneyString = [NSString stringWithFormat:@"恭喜您获得%@元现金红包\n\n已转入账户余额",[self.openRedBagDic objectForKey:@"rpAmount"]];
        
        NSMutableAttributedString *frontStr = [[NSMutableAttributedString alloc] initWithString:moneyString];
        [frontStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:16] range:[moneyString rangeOfString:@"恭喜您获得"]];
        [frontStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:16] range:[moneyString rangeOfString:@"元现金红包"]];
        [frontStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:14] range:[moneyString rangeOfString:@"已转入账户余额"]];
        //    取到恭~0的长度 减掉5 就剩100
        NSRange shuZi = NSMakeRange(5, [[frontStr string] rangeOfString:@"元"].location - 5);
        [frontStr addAttribute:NSForegroundColorAttributeName value:[UIColor daohanglan] range:shuZi];
        [frontStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:25] range:shuZi];
        [labelGet setAttributedText:frontStr];
        labelGet.numberOfLines = 3;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];

}

- (void)shareButtonAction:(id)sender{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"56447cbc67e58efd78001914"
                                      shareText:@"大圣理财,金融街的新宠."
                                     shareImage:[UIImage imageNamed:@"b17a045a80e620259fbb8f4f444393812bfc129c1ec3d-23eoii_fw658@3x"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToQzone,UMShareToRenren,UMShareToWechatSession,UMShareToWechatTimeline,nil]
                                       delegate:self];
}

//打开钻石红包按钮
- (void)didOpenRedBag:(UIButton *)button
{
    [button removeFromSuperview];
    button = nil;
    
    CashOtherFinViewController *cashOFVC = [[CashOtherFinViewController alloc] init];
    cashOFVC.moneyString = self.moneyString;
    cashOFVC.endTimeString = self.endTimeString;
    cashOFVC.productName = self.productName;
    [self.navigationController pushViewController:cashOFVC animated:NO];
}

- (void)finishLastBarPress:(UIBarButtonItem *)bar
{
    if ([self.nHand isEqualToString:@"my"]) {
        NSArray *arrVC = self.navigationController.viewControllers;
        [self.navigationController popToViewController:[arrVC objectAtIndex:1] animated:YES];
    } else
        [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)buttonNothing:(UIBarButtonItem *)button
{
    
}

#pragma mark 分享成功回调方法
#pragma mark --------------------------------

- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        [self getShareRedPacket];
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

#pragma mark 分享成功拿红包
#pragma mark --------------------------------

- (void)getShareRedPacket{
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSDictionary *parameter = @{@"token":[dic objectForKey:@"token"]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/redpacket/getShareRedPacket" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:@"分享成功,红包已入帐."];
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
