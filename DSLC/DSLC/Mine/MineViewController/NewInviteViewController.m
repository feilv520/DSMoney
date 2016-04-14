//
//  NewInviteViewController.m
//  DSLC
//
//  Created by ios on 16/4/14.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "NewInviteViewController.h"
#import "InviteRecordViewController.h"

@interface NewInviteViewController ()

{
    UIButton *butReceive;
    UIScrollView *scrollview;
}

@end

@implementation NewInviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor qianhuise];
    [self.navigationItem setTitle:@"我的邀请"];
    
    butReceive = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, 60, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"邀请记录"];
    butReceive.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    UIBarButtonItem *rightButItem = [[UIBarButtonItem alloc] initWithCustomView:butReceive];
    [butReceive addTarget:self action:@selector(inviteRecordButton:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightButItem;
    
    [self contentShow];
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
    NSMutableAttributedString *codeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"我的邀请码: %@", @"au365s8"]];
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
    NSLog(@"8888888888888888888888");
}

- (void)inviteRecordButton:(UIBarButtonItem *)button
{
    InviteRecordViewController *InviteRecord = [[InviteRecordViewController alloc] init];
    [self.navigationController pushViewController:InviteRecord animated:YES];
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
