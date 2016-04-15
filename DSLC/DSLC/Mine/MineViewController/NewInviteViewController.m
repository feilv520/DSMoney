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

@interface NewInviteViewController ()

{
    UIButton *butReceive;
    UIScrollView *scrollview;
    
    InviteNewView *inviteNV;
    
    UIView *viewGray;
    
    NSMutableArray *adModelArray;
}

@end

@implementation NewInviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor qianhuise];
    [self.navigationItem setTitle:@"我的邀请"];
    
    adModelArray = [NSMutableArray array];
    
    butReceive = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, 60, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"邀请记录"];
    butReceive.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    UIBarButtonItem *rightButItem = [[UIBarButtonItem alloc] initWithCustomView:butReceive];
    [butReceive addTarget:self action:@selector(inviteRecordButton:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightButItem;
    
    [self contentShow];
    
    viewGray = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor blackColor]];
    viewGray.alpha = 0.3;
    
    [self shareWithView];
    
    viewGray.hidden = YES;
    
}

- (void)contentShow
{
    scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT)];
    [self.view addSubview:scrollview];
    scrollview.backgroundColor = [UIColor qianhuise];
    scrollview.contentSize = CGSizeMake(0, 1000.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT);
    
    UIImageView *imageViewBanner = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 150.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT) backGroundColor:[UIColor orangeColor] setImage:nil];
    [scrollview addSubview:imageViewBanner];
    
    UILabel *labelSao = [CreatView creatWithLabelFrame:CGRectMake(0, imageViewBanner.frame.size.height + 20.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT, WIDTH_CONTROLLER_DEFAULT, (20.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT)) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"扫二维码下载大圣理财"];
    [scrollview addSubview:labelSao];
    
    UIView *viewTwo = [CreatView creatViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 90, imageViewBanner.frame.size.height + labelSao.frame.size.height + 20.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT + (10.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT), 180, 180) backgroundColor:[UIColor whiteColor]];
    [scrollview addSubview:viewTwo];
    
    UILabel *labelCode = [CreatView creatWithLabelFrame:CGRectMake(0, imageViewBanner.frame.size.height + labelSao.frame.size.height + 20.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT + (10.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT) + 180, WIDTH_CONTROLLER_DEFAULT, 50.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor clearColor] textColor:nil textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:nil];
    [scrollview addSubview:labelCode];
    NSMutableAttributedString *codeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"我的邀请码: %@", self.inviteCode]];
    NSRange leftRange = NSMakeRange(0, [[codeString string] rangeOfString:@" "].location);
    [codeString addAttribute:NSForegroundColorAttributeName value:[UIColor zitihui] range:leftRange];
    NSRange rightRange = NSMakeRange([[codeString string] length] - 7, 7);
    [codeString addAttribute:NSForegroundColorAttributeName value:[UIColor daohanglan] range:rightRange];
    [labelCode setAttributedText:codeString];
    
    UIView *viewRule = [CreatView creatViewWithFrame:CGRectMake(10, imageViewBanner.frame.size.height + labelSao.frame.size.height + 20.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT + (10.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT) + 180 + 50.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT, WIDTH_CONTROLLER_DEFAULT - 20, 220.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor whiteColor]];
    [scrollview addSubview:viewRule];
    viewRule.layer.cornerRadius = 5;
    viewRule.layer.masksToBounds = YES;
    
    UIButton *butSend = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, imageViewBanner.frame.size.height + labelSao.frame.size.height + 20.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT + (10.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT) + 180 + 50.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT + 220.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT + 20.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT, WIDTH_CONTROLLER_DEFAULT - 80, 40.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"发送邀请"];
    [scrollview addSubview:butSend];
    butSend.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butSend setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
    [butSend setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
    [butSend addTarget:self action:@selector(buttonSendInvite:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat viewRuleW = viewRule.frame.size.width;
    CGFloat viewRuleH = viewRule.frame.size.height;
    
    UILabel *labelRule = [CreatView creatWithLabelFrame:CGRectMake(5, 5, viewRuleW - 10, viewRuleH - 10) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:12] text:@"邀请规则:\n1. 注册即赠送5000元体验金和现金红包 ;\n2. 完成任意投资激活现金红包;\n3. 当您邀请的好友成功注册并完成投资后，您将获得的邀请红包:\n① 好友投资金额累计达到1000元（含），您即获得10元现金红包 ;\n② 好友投资金额累计达到10000元（含），您即获得20元现金红包 ;\n③ 邀请每位好友获得的现金红包金额封顶30元，邀请好友人数不限 。"];
    [viewRule addSubview:labelRule];
    labelRule.numberOfLines = 0;
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {

        viewRule.frame = CGRectMake(10, imageViewBanner.frame.size.height + labelSao.frame.size.height + 20.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT + (10.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT) + 180 + 50.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT, WIDTH_CONTROLLER_DEFAULT - 20, 220.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT + 20);
        
        CGFloat viewRuleW = viewRule.frame.size.width;
        CGFloat viewRuleH = viewRule.frame.size.height;
        labelRule.frame = CGRectMake(5, 5, viewRuleW - 10, viewRuleH - 10);
        
        butSend.frame = CGRectMake(40, 40 + imageViewBanner.frame.size.height + labelSao.frame.size.height + 20.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT + (10.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT) + 180 + 50.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT + 220.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT + 20.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT, WIDTH_CONTROLLER_DEFAULT - 80, 40.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT);
        
    } else if (HEIGHT_CONTROLLER_DEFAULT - 20 == 568) {
        
        butSend.frame = CGRectMake(40, 25 + imageViewBanner.frame.size.height + labelSao.frame.size.height + 20.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT + (10.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT) + 180 + 50.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT + 220.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT + 20.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT, WIDTH_CONTROLLER_DEFAULT - 80, 40.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT);
        scrollview.contentSize = CGSizeMake(0, 920.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT);
        
    } else if (HEIGHT_CONTROLLER_DEFAULT - 20 == 667) {
        
        viewRule.frame = CGRectMake(10, imageViewBanner.frame.size.height + labelSao.frame.size.height + 20.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT + (10.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT) + 180 + 50.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT, WIDTH_CONTROLLER_DEFAULT - 20, 220.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT - 60);
        
        CGFloat viewRuleW = viewRule.frame.size.width;
        CGFloat viewRuleH = viewRule.frame.size.height;
        labelRule.frame = CGRectMake(5, 5, viewRuleW - 10, viewRuleH - 10);
        
        butSend.frame = CGRectMake(40, imageViewBanner.frame.size.height + labelSao.frame.size.height + 20.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT + (10.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT) + 180 + 50.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT + 220.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT + 20.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT - 20, WIDTH_CONTROLLER_DEFAULT - 80, 40.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT);

        scrollview.contentSize = CGSizeMake(0, 850.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT);
        
    } else {
        
        viewRule.frame = CGRectMake(10, imageViewBanner.frame.size.height + labelSao.frame.size.height + 20.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT + (10.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT) + 180 + 50.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT, WIDTH_CONTROLLER_DEFAULT - 20, 110.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT);
        
        CGFloat viewRuleW = viewRule.frame.size.width;
        CGFloat viewRuleH = viewRule.frame.size.height;
        labelRule.frame = CGRectMake(5, 5, viewRuleW - 10, viewRuleH - 10);
        
        butSend.frame = CGRectMake(40, imageViewBanner.frame.size.height + labelSao.frame.size.height + 20.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT + (10.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT) + 180 + 50.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT + 150.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT + 20.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT - 20, WIDTH_CONTROLLER_DEFAULT - 80, 40.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT);
        
        scrollview.contentSize = CGSizeMake(0, 750.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT);
    }
    
}

//发送邀请按钮
- (void)buttonSendInvite:(UIButton *)button
{
    [UIView animateWithDuration:0.5f animations:^{
        viewGray.hidden = NO;
        inviteNV.frame = CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT - 200 - 20, self.view.frame.size.width, 200);
    }];
}

- (void)inviteRecordButton:(UIBarButtonItem *)button
{
    InviteRecordViewController *InviteRecord = [[InviteRecordViewController alloc] init];
    [self.navigationController pushViewController:InviteRecord animated:YES];
}

/**
 *  分享界面搭建
 */

- (void)shareWithView{
    NSBundle *rootBundle = [NSBundle mainBundle];
    
    viewGray.hidden = NO;
    
    inviteNV = (InviteNewView *)[[rootBundle loadNibNamed:@"InviteNewView" owner:nil options:nil]lastObject];
    
    inviteNV.frame = CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT, self.view.frame.size.width, 200);
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [app.window addSubview:viewGray];
    
    [app.window addSubview:inviteNV];
    
    [inviteNV.wButton addTarget:self action:@selector(wAction) forControlEvents:UIControlEventTouchUpInside];
    [inviteNV.WButton addTarget:self action:@selector(wAction) forControlEvents:UIControlEventTouchUpInside];
    [inviteNV.xButton addTarget:self action:@selector(xAction) forControlEvents:UIControlEventTouchUpInside];
    [inviteNV.XButton addTarget:self action:@selector(xAction) forControlEvents:UIControlEventTouchUpInside];
    [inviteNV.pButton addTarget:self action:@selector(pAction) forControlEvents:UIControlEventTouchUpInside];
    [inviteNV.PButton addTarget:self action:@selector(pAction) forControlEvents:UIControlEventTouchUpInside];
    [inviteNV.rButton addTarget:self action:@selector(rAction) forControlEvents:UIControlEventTouchUpInside];
    [inviteNV.RButton addTarget:self action:@selector(rAction) forControlEvents:UIControlEventTouchUpInside];
    [inviteNV.qButton addTarget:self action:@selector(qAction) forControlEvents:UIControlEventTouchUpInside];
    [inviteNV.QButton addTarget:self action:@selector(qAction) forControlEvents:UIControlEventTouchUpInside];
    
    [inviteNV.cancelButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
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
/**
 *  分享实现的方法
 */


- (void)wAction{
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:@"大圣理财,金融街的新宠." image:[UIImage imageNamed:@"fenxiangtouxiang"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
        NSLog(@"%u",response.responseCode);
        if (response.responseCode == UMSResponseCodeSuccess) {
            //                [self getShareRedPacket];
            NSLog(@"邀请成功！");
        }
    }];
    
    // 需要修改
    [UMSocialData defaultData].extConfig.wechatSessionData.url = @"http://wap.dslc.cn";
}

- (void)xAction{
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:@"大圣理财,金融街的新宠.大圣理财链接:https://itunes.apple.com/cn/app/da-sheng-li-cai/id1063185702?mt=8" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
        NSLog(@"shareResponse = %u",shareResponse.responseCode);
        if (shareResponse.responseCode == UMSResponseCodeSuccess) {
            //                [self getShareRedPacket];
            NSLog(@"邀请成功！");
        }
    }];
}

- (void)pAction{
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:@"大圣理财,金融街的新宠." image:[UIImage imageNamed:@"fenxiangtouxiang"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
        NSLog(@"%u",response.responseCode);
        if (response.responseCode == UMSResponseCodeSuccess) {
            //                [self getShareRedPacket];
            NSLog(@"邀请成功！");
        }
    }];
    
    // 需要修改
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"http://wap.dslc.cn";
}

- (void)rAction{
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToRenren] content:@"大圣理财,金融街的新宠.大圣理财链接:https://itunes.apple.com/cn/app/da-sheng-li-cai/id1063185702?mt=8" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
        NSLog(@"%u",response.responseCode);
        if (response.responseCode == UMSResponseCodeSuccess) {
            //                [self getShareRedPacket];
            NSLog(@"邀请成功！");
        }
    }];
}

- (void)qAction{
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQzone] content:@"大圣理财,金融街的新宠.大圣理财链接:https://itunes.apple.com/cn/app/da-sheng-li-cai/id1063185702?mt=8" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
        NSLog(@"%u",response.responseCode);
        if (response.responseCode == UMSResponseCodeSuccess) {
            //                [self getShareRedPacket];
            NSLog(@"邀请成功！");
        }
    }];
}

- (void)closeAction:(id)sender{
    [UIView animateWithDuration:0.5f animations:^{
        inviteNV.frame = CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT, self.view.frame.size.width, 200);
        
        viewGray.hidden = YES;
    }];
}

#pragma mark 网络请求方法
#pragma mark --------------------------------

- (void)getAdvList{
    
    NSDictionary *parmeter = @{@"adType":@"2",@"adPosition":@"6"};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/adv/getAdvList" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
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
