//
//  ShareHaveRedBag.m
//  DSLC
//
//  Created by ios on 15/11/5.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "ShareHaveRedBag.h"
#import "CashOtherFinViewController.h"

@interface ShareHaveRedBag ()

{
    UIButton *butSurprise;
    
    UILabel *labelGet;
}

@property (nonatomic, strong) NSDictionary *openRedBagDic;

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
    [self contentShow];
}

- (void)contentShow
{
    UIButton *butonDo = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 60, WIDTH_CONTROLLER_DEFAULT, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] titleText:@"恭喜你投资成功 !"];
    [butonDo setImage:[UIImage imageNamed:@"iconfont_complete"] forState:UIControlStateNormal];
    [self.view addSubview:butonDo];
    butonDo.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    UILabel *labelSurprise = [CreatView creatWithLabelFrame:CGRectMake(0, 90, WIDTH_CONTROLLER_DEFAULT, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"大圣豪礼很劲爆,打开有惊喜哦 !"];
    [self.view addSubview:labelSurprise];
    
    UIButton *buttonOpen = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 150, WIDTH_CONTROLLER_DEFAULT - 80, 180) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [self.view addSubview:buttonOpen];
    [buttonOpen setBackgroundImage:[UIImage imageNamed:@"没打开的红包"] forState:UIControlStateNormal];
    [buttonOpen setBackgroundImage:[UIImage imageNamed:@"没打开的红包"] forState:UIControlStateHighlighted];
    [buttonOpen addTarget:self action:@selector(openRedBagButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *labelExplain = [CreatView creatWithLabelFrame:CGRectMake(0, 340, WIDTH_CONTROLLER_DEFAULT, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentCenter textFont:[UIFont systemFontOfSize:12] text:@"没打开?到“我的账户”-“红包活动”里打开"];
    [self.view addSubview:labelExplain];
    
    UIButton *buttonGOON = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 400, (WIDTH_CONTROLLER_DEFAULT - 80 - 10)/2, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor daohanglan] titleText:@"继续投资"];
    [self.view addSubview:buttonGOON];
    buttonGOON.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    buttonGOON.layer.cornerRadius = 3;
    buttonGOON.layer.masksToBounds = YES;
    buttonGOON.layer.borderColor = [[UIColor daohanglan] CGColor];
    buttonGOON.layer.borderWidth = 0.5;
    [buttonGOON addTarget:self action:@selector(finishLastBarPress:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonShare = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake((WIDTH_CONTROLLER_DEFAULT - 80 - 10)/2 + 50, 400, (WIDTH_CONTROLLER_DEFAULT - 80 - 10)/2, 40) backgroundColor:[UIColor daohanglan] textColor:[UIColor whiteColor] titleText:@"分享拿红包"];
    [self.view addSubview:buttonShare];
    buttonShare.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    buttonShare.layer.cornerRadius = 3;
    buttonShare.layer.masksToBounds = YES;
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
    
    NSDictionary *parameter = @{@"token":[dic objectForKey:@"token"],@"redPacketId":[self.redbagModel redPacketId]};
    
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

//打开钻石红包按钮
- (void)didOpenRedBag:(UIButton *)button
{
    [button removeFromSuperview];
    button = nil;
    
    CashOtherFinViewController *cashOFVC = [[CashOtherFinViewController alloc] init];
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
