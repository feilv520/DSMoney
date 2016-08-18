//
//  CashOtherFinViewController.m
//  DSLC
//
//  Created by ios on 15/11/5.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "CashOtherFinViewController.h"
#import "ShareEveryCell.h"
#import "ShareFailureViewController.h"
#import "define.h"
#import "MonkeyRulesViewController.h"

@interface CashOtherFinViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UMSocialUIDelegate>

{
    NSArray *contentArr;
    
    UIButton *butBlack;
    UIView *viewTanKuang;
    UICollectionView *collection;
    
    NSArray *imageArray;
    NSArray *nameArray;
    
    UIButton *butCancle;
    
    UIButton *buttonShare;
    UIButton *butHeiSe;
    UIView *viewBaiSe;
    UIImageView *imageViewDuiH;
    UIButton *butCuo;
    UITextField *_textField;
    UIButton *butOK;
    UILabel *labelMonkeynum;
    NSInteger monkeyNum;
    NSString *monkey;
    NSInteger countIns;
    
    NSString *fString;
}

@end

@implementation CashOtherFinViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"支付完成"];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(buttonNull:)];
    
    countIns = 0;
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishBarPress:)];
//    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:13], NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    if ([self.guShou isEqualToString:@"1"]) {
        
        [self getmonkeyNumber];
        
    } else {
        
        [self contentShow];
    }
}

//兑换受益弹窗
- (void)showImputMonkey
{
    butHeiSe = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor blackColor] textColor:nil titleText:nil];
    [self.view addSubview:butHeiSe];
    butHeiSe.alpha = 0.3;
    [butHeiSe addTarget:self action:@selector(buttonMoneyDisappear:) forControlEvents:UIControlEventTouchUpInside];
    
    imageViewDuiH = [CreatView creatImageViewWithFrame:CGRectMake(30, (HEIGHT_CONTROLLER_DEFAULT - 64 - 20)/2 - 260, WIDTH_CONTROLLER_DEFAULT - 60, 310) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"兑换受益弹窗22"]];
    imageViewDuiH.userInteractionEnabled = YES;
    [self.view addSubview:imageViewDuiH];
    
    butCuo = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(imageViewDuiH.frame.size.width - 25, imageViewDuiH.frame.size.height/4 + 10, 20, 20) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [imageViewDuiH addSubview:butCuo];
    [butCuo setBackgroundImage:[UIImage imageNamed:@"cuo"] forState:UIControlStateNormal];
    [butCuo setBackgroundImage:[UIImage imageNamed:@"cuo"] forState:UIControlStateHighlighted];
    [butCuo addTarget:self action:@selector(buttonMoneyDisappear:) forControlEvents:UIControlEventTouchUpInside];
    
    labelMonkeynum = [CreatView creatWithLabelFrame:CGRectMake(0, imageViewDuiH.frame.size.height - imageViewDuiH.frame.size.height/3, imageViewDuiH.frame.size.width, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentCenter textFont:nil text:nil];
    [imageViewDuiH addSubview:labelMonkeynum];
    
    butOK = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(80, imageViewDuiH.frame.size.height - imageViewDuiH.frame.size.height/3 + labelMonkeynum.frame.size.height + 10, imageViewDuiH.frame.size.width - 160, 30) backgroundColor:[UIColor jinse] textColor:[UIColor whiteColor] titleText:@"确定"];
    [imageViewDuiH addSubview:butOK];
    butOK.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    butOK.layer.cornerRadius = 3;
    butOK.layer.masksToBounds = YES;
    [butOK addTarget:self action:@selector(buttonMakeSureOk:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonRules = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, imageViewDuiH.frame.size.height - 25, imageViewDuiH.frame.size.width, 15) backgroundColor:[UIColor clearColor] textColor:[UIColor monkeyRules] titleText:@" 猴币玩法"];
    [imageViewDuiH addSubview:buttonRules];
    buttonRules.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:8];
    [buttonRules setImage:[UIImage imageNamed:@"houbixize"] forState:UIControlStateNormal];
    [buttonRules setImage:[UIImage imageNamed:@"houbixize"] forState:UIControlStateHighlighted];
    [buttonRules addTarget:self action:@selector(buttonMonkeyRules:) forControlEvents:UIControlEventTouchUpInside];
}

//猴币玩法
- (void)buttonMonkeyRules:(UIButton *)button
{
    MonkeyRulesViewController *monkeyRules = [[MonkeyRulesViewController alloc] init];
    [self.navigationController pushViewController:monkeyRules animated:YES];
}

- (void)buttonMakeSureOk:(UIButton *)button
{
    countIns ++;
    if (countIns == 1) {
        [self submitLoadingWithView:self.view loadingFlag:NO height:0];
        
    } else {
        
        [self submitLoadingWithHidden:NO];
    }
    
    [self getMakeSure];
}

//遮罩层消失
- (void)buttonMoneyDisappear:(UIButton *)button
{
    [self.view endEditing:YES];
    [butHeiSe removeFromSuperview];
    [imageViewDuiH removeFromSuperview];
    
    butHeiSe = nil;
    imageViewDuiH = nil;
}

- (void)getMakeSure
{
    NSLog(@"siao");
    
    if (monkeyNum > self.moneyString.integerValue) {
        
        NSDictionary *parameter = @{@"token":[self.flagDic objectForKey:@"token"], @"orderId":self.orderId, @"cashMonkeyNumber":self.moneyString};
        
        [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/saveUserCashMonkey" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
            
            NSLog(@"%@~~~~~~~~~~~", responseObject);
            
            if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
                
                [self submitLoadingWithHidden:YES view:self.view];
                [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
                
                [self.view endEditing:YES];
                [butHeiSe removeFromSuperview];
                [imageViewDuiH removeFromSuperview];
                
                butHeiSe = nil;
                imageViewDuiH = nil;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"exchangeWithImageView" object:nil];
                
            } else {
                
                [self submitLoadingWithHidden:YES view:self.view];
                [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
        }];
        
    } else {
        
        NSDictionary *parameter = @{@"token":[self.flagDic objectForKey:@"token"], @"orderId":self.orderId, @"cashMonkeyNumber":monkey};
        
        [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/saveUserCashMonkey" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
            
            NSLog(@"%@~~~~~~~~~~~", responseObject);
            
            if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
                
                [self submitLoadingWithHidden:YES view:self.view];
                [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
                
                [self.view endEditing:YES];
                [butHeiSe removeFromSuperview];
                [imageViewDuiH removeFromSuperview];
                
                butHeiSe = nil;
                imageViewDuiH = nil;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"exchangeWithImageView" object:nil];
                
            } else {
                
                [self submitLoadingWithHidden:YES view:self.view];
                [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
        }];

    }
    

}

//获取猴币可用数量
- (void)getmonkeyNumber
{
    NSDictionary *parameter = @{@"token":[self.flagDic objectForKey:@"token"]};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/getUserMonkeyNumber" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"//////////%@", responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            [self contentShow];
            [self showImputMonkey];
            
            monkeyNum = [[responseObject objectForKey:@"uMonkeyNum"] integerValue];
            monkey = [responseObject objectForKey:@"uMonkeyNum"];
            
            if (monkeyNum > self.moneyString.integerValue) {
                
                NSMutableAttributedString *amountStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"兑换数量:%@个", self.moneyString]];
                NSRange geShuRange = NSMakeRange(0, [[amountStr string] rangeOfString:@":"].location);
                [amountStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:12] range:geShuRange];
                NSRange geStr = NSMakeRange([[amountStr string] length] - 1, 1);
                [amountStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:12] range:geStr];
                NSRange shuliang = NSMakeRange(4, [[amountStr string] rangeOfString:@"个"].location - 4);
                [amountStr addAttribute:NSForegroundColorAttributeName value:[UIColor jinse] range:shuliang];
                [amountStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:20] range:shuliang];
                [labelMonkeynum setAttributedText:amountStr];
                
            } else {
                
                NSMutableAttributedString *amountStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"兑换数量:%@个", monkey]];
                NSRange geShuRange = NSMakeRange(0, [[amountStr string] rangeOfString:@":"].location);
                [amountStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:12] range:geShuRange];
                NSRange geStr = NSMakeRange([[amountStr string] length] - 1, 1);
                [amountStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:12] range:geStr];
                NSRange shuliang = NSMakeRange(4, [[amountStr string] rangeOfString:@"个"].location - 4);
                [amountStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:20] range:shuliang];
                [amountStr addAttribute:NSForegroundColorAttributeName value:[UIColor jinse] range:shuliang];
                [labelMonkeynum setAttributedText:amountStr];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)contentShow
{
    contentArr = @[[NSString stringWithFormat:@"投资金额:%@元",self.moneyString], [NSString stringWithFormat:@"预期到期收益:%@",self.syString], [NSString stringWithFormat:@"兑付日期:%@",self.endTimeString]];
    
    UIButton *butonDo = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 60, WIDTH_CONTROLLER_DEFAULT, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] titleText:@"恭喜你投资成功"];
    [butonDo setImage:[UIImage imageNamed:@"iconfont_complete"] forState:UIControlStateNormal];
    [self.view addSubview:butonDo];
    butonDo.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    UIView *viewBottom = [CreatView creatViewWithFrame:CGRectMake(40, 120, WIDTH_CONTROLLER_DEFAULT - 80, 140) backgroundColor:[UIColor shurukuangColor]];
    [self.view addSubview:viewBottom];
    viewBottom.layer.cornerRadius = 5;
    viewBottom.layer.masksToBounds = YES;
    viewBottom.layer.borderColor = [[UIColor shurukuangBian] CGColor];
    viewBottom.layer.borderWidth = 0.5;
    
    UILabel *labelName = [CreatView creatWithLabelFrame:CGRectMake(0, 15, WIDTH_CONTROLLER_DEFAULT - 80, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:self.productName];
    [viewBottom addSubview:labelName];
    
    for (int i = 0; i < 3; i++) {
        
        UILabel *label = [CreatView creatWithLabelFrame:CGRectMake(0, 45 + 20 * i + 10 * i, WIDTH_CONTROLLER_DEFAULT - 80, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:[contentArr objectAtIndex:i]];
        [viewBottom addSubview:label];
    }
    
    UIButton *buttonGoOn = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 300, (WIDTH_CONTROLLER_DEFAULT - 80 - 10)/2, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor daohanglan] titleText:@"继续投资"];
    [self.view addSubview:buttonGoOn];
    buttonGoOn.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    buttonGoOn.layer.cornerRadius = 3;
    buttonGoOn.layer.masksToBounds = YES;
    buttonGoOn.layer.borderColor = [[UIColor daohanglan] CGColor];
    buttonGoOn.layer.borderWidth = 0.5;
    [buttonGoOn addTarget:self action:@selector(finishBarPress:) forControlEvents:UIControlEventTouchUpInside];
    
    buttonShare = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake((WIDTH_CONTROLLER_DEFAULT - 80 - 10)/2 + 50, 300, (WIDTH_CONTROLLER_DEFAULT - 80 - 10)/2, 40) backgroundColor:[UIColor daohanglan] textColor:[UIColor whiteColor] titleText:@"分享拿红包"];
    [self.view addSubview:buttonShare];
    buttonShare.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    buttonShare.layer.cornerRadius = 3;
    buttonShare.titleLabel.textAlignment = NSTextAlignmentCenter;
    buttonShare.layer.masksToBounds = YES;
    [buttonShare addTarget:self action:@selector(shareGetRedBag:) forControlEvents:UIControlEventTouchUpInside];
}

//分享拿红包
- (void)shareGetRedBag:(UIButton *)button
{

    [self getShareRedPacket];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    fString = [NSString stringWithFormat:@"http://wap.dslc.cn/app/appInvite.html?name=%@&inviteCode=%@", [dic objectForKey:@"realName"], [dic objectForKey:@"invitationMyCode"]];
    
    fString = [fString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5642ad7e67e58e8463006218"
                                      shareText:[NSString stringWithFormat:@"大圣理财风暴来袭:喝咖啡,领红包,赚猴币多重惊喜等着你!  %@", fString]
                                     shareImage:[UIImage imageNamed:@"fenxiangtouxiang"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToQzone,UMShareToRenren,UMShareToWechatSession,UMShareToWechatTimeline,nil]
                                       delegate:self];
    
    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"邀请好友一起，免费共享星巴克";
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"邀请好友一起，免费共享星巴克";
    
    [UMSocialData defaultData].extConfig.wechatSessionData.url = fString;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = fString;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShareEveryCell *cell = [collection dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
    
    cell.labelName.text = [nameArray objectAtIndex:indexPath.item];
    cell.labelName.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    cell.imagePIc.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [imageArray objectAtIndex:indexPath.item]]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShareFailureViewController *shareFailure = [[ShareFailureViewController alloc] init];
    [self.navigationController pushViewController:shareFailure animated:YES];
}

- (void)finishBarPress:(UIBarButtonItem *)bar
{
    if ([self.nHand isEqualToString:@"my"]) {
        NSArray *arrVC = self.navigationController.viewControllers;
        [self.navigationController popToViewController:[arrVC objectAtIndex:1] animated:YES];
    } else
        [self.navigationController popToRootViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"exchangeWithImageView" object:nil];
}

- (void)buttonNull:(UIBarButtonItem *)button
{
    
}

//黑色遮罩层
- (void)makeButtonDisappear:(UIButton *)button
{
    [button removeFromSuperview];
    [viewTanKuang removeFromSuperview];
    
    button = nil;
    viewTanKuang = nil;
}

//取消按钮
- (void)buttonCanclePress:(UIButton *)button
{
    [butBlack removeFromSuperview];
    [viewTanKuang removeFromSuperview];
    
    butBlack = nil;
    viewTanKuang = nil;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [butBlack removeFromSuperview];
    [viewTanKuang removeFromSuperview];
    
    butBlack = nil;
    viewTanKuang = nil;
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:NO];
    [app.tabBarVC setLabelLineHidden:NO];
}

#pragma mark 分享回调方法
#pragma mark --------------------------------

- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
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
        
        NSLog(@"%@",responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:@"分享成功,一天只能获得一个红包."];
            [buttonShare setTitle:@"分享" forState:UIControlStateNormal];
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
