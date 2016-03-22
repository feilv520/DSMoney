//
//  TMakeSureViewController.m
//  DSLC
//
//  Created by ios on 16/3/15.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TMakeSureViewController.h"
#import "UIColor+AddColor.h"
#import "TChooseRedBagCell.h"
#import "TRedBagModel.h"
#import "CashFinishViewController.h"
#import "ShareHaveRedBag.h"
#import "FBalancePaymentViewController.h"
#import "ZFPassword.h"
#import "CashOtherFinViewController.h"
#import "SetDealSecret.h"
#import "FindDealViewController.h"
#import "RealNameViewController.h"
#import "RechargeAlreadyBinding.h"

@interface TMakeSureViewController () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

{
    UITextField *textFieldShu;
    UIButton *buttonMake;
    NSMutableArray *redBagArray;
    UILabel *labelCoin;
    UILabel *labelYJmoney;
    NSDictionary *accountDic;
    UIButton *butBlackAlert;
    UIView *viewBottomD;
    UITableView *_tableView;
    NSMutableArray *chooseBagArr;
    NSString *syString;
    TRedBagModel *redbagModel;
    FBalancePaymentViewController *_balanceVC;
    
    ZFPassword *ZFPView;
    NSInteger click;
    
    NSDictionary *dataDic;
    
    UIView *viewGray;
    
    NSIndexPath *currentIndexPath;
}

@property (nonatomic) UIView *viewBottom;

@end

@implementation TMakeSureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    click = 0;
    
    currentIndexPath = nil;
    
    self.view.backgroundColor = [UIColor qianhuise];
    [self.navigationItem setTitle:@"确认投资"];
    
    viewGray = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor blackColor]];
    viewGray.alpha = 0.3;
    
//    redBagArray是红包的数组 里面是以字典形式存放一个个的红包 chooseBagArr里面存放对象
    redBagArray = [NSMutableArray array];
    chooseBagArr = [NSMutableArray array];
    accountDic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getData) name:@"getData" object:nil];
    
    [self contentShow];
    [self getData];
}

- (void)contentShow
{
    UIView *viewBottom = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 144) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewBottom];
    
    UILabel *labelMoney = [CreatView creatWithLabelFrame:CGRectMake(10, 7, WIDTH_CONTROLLER_DEFAULT - 20, 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"投资金额"];
    [viewBottom addSubview:labelMoney];
    
    textFieldShu = [CreatView creatWithfFrame:CGRectMake(10, 43, WIDTH_CONTROLLER_DEFAULT - 20, 40) setPlaceholder:[NSString stringWithFormat:@"%@元起投,每递增%@元", [self.detailM amountMin],[self.detailM amountIncrease]] setTintColor:[UIColor grayColor]];
    [viewBottom addSubview:textFieldShu];
    textFieldShu.backgroundColor = [UIColor shurukuangColor];
    textFieldShu.keyboardType = UIKeyboardTypeNumberPad;
    textFieldShu.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    textFieldShu.delegate = self;
    textFieldShu.layer.cornerRadius = 5;
    textFieldShu.layer.masksToBounds = YES;
    textFieldShu.layer.borderColor = [[UIColor shurukuangBian] CGColor];
    textFieldShu.layer.borderWidth = 1;
    textFieldShu.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    textFieldShu.leftView.backgroundColor = [UIColor shurukuangColor];
    textFieldShu.leftViewMode = UITextFieldViewModeAlways;
    [textFieldShu addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    
    UILabel *labelYuan = [CreatView creatWithLabelFrame:CGRectMake(textFieldShu.frame.size.width - 25, 5, 20, 30) backgroundColor:[UIColor shurukuangColor] textColor:[UIColor yuanColor] textAlignment:NSTextAlignmentRight textFont:[UIFont fontWithName:@"CenturyGothic" size:12] text:@"元"];
    [textFieldShu addSubview:labelYuan];
    
    UILabel *labelLine = [CreatView creatWithLabelFrame:CGRectMake(10, 95, WIDTH_CONTROLLER_DEFAULT - 20, 0.5) backgroundColor:[UIColor grayColor] textColor:nil textAlignment:NSTextAlignmentLeft textFont:nil text:nil];
    [viewBottom addSubview:labelLine];
    labelLine.alpha = 0.2;
    
    UILabel *labelYuJi = [CreatView creatWithLabelFrame:CGRectMake(10, 96, (WIDTH_CONTROLLER_DEFAULT - 20)/2, 50) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"预计到期收益"];
    [viewBottom addSubview:labelYuJi];
    
    labelYJmoney = [CreatView creatWithLabelFrame:CGRectMake(10 + (WIDTH_CONTROLLER_DEFAULT - 20)/2, 96, (WIDTH_CONTROLLER_DEFAULT - 20)/2, 50) backgroundColor:[UIColor whiteColor] textColor:[UIColor daohanglan] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"0.00元"];
    [viewBottom addSubview:labelYJmoney];
    
    UILabel *labelLineD = [CreatView creatWithLabelFrame:CGRectMake(0, 145, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor] textColor:nil textAlignment:NSTextAlignmentCenter textFont:nil text:nil];
    [viewBottom addSubview:labelLineD];
    labelLineD.alpha = 0.2;
    
    UIView *viewCash = [CreatView creatViewWithFrame:CGRectMake(0, 154, WIDTH_CONTROLLER_DEFAULT, 50) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewCash];
    
    UILabel *labelLineUp = [CreatView creatWithLabelFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor] textColor:nil textAlignment:NSTextAlignmentCenter textFont:nil text:nil];
    [viewCash addSubview:labelLineUp];
    labelLineUp.alpha = 0.2;
    
    UILabel *labelLineDown = [CreatView creatWithLabelFrame:CGRectMake(0, 49.5, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor] textColor:nil textAlignment:NSTextAlignmentCenter textFont:nil text:nil];
    [viewCash addSubview:labelLineDown];
    labelLineDown.alpha = 0.2;
    
    UILabel *labelCash = [CreatView creatWithLabelFrame:CGRectMake(10, 10, (WIDTH_CONTROLLER_DEFAULT - 20)/2, 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"支付金额"];
    [viewCash addSubview:labelCash];
    
    labelCoin = [CreatView creatWithLabelFrame:CGRectMake((WIDTH_CONTROLLER_DEFAULT - 20)/2, 10, (WIDTH_CONTROLLER_DEFAULT - 20)/2, 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor daohanglan] textAlignment:NSTextAlignmentRight textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:[NSString stringWithFormat:@"%@元", @"0.00"]];
    [viewCash addSubview:labelCoin];
    
    UILabel *labelAlert = [CreatView creatWithLabelFrame:CGRectMake(10, 210, WIDTH_CONTROLLER_DEFAULT - 20, 20) backgroundColor:[UIColor qianhuise] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:12] text:@"提示:购买产品成功后,可拆开选择的红包"];
    [self.view addSubview:labelAlert];
    
    buttonMake = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, HEIGHT_CONTROLLER_DEFAULT - 20 - 120 - 40 - 64, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"确认投资"];
    [self.view addSubview:buttonMake];
    buttonMake.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonMake setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
    [buttonMake setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
    [buttonMake addTarget:self action:@selector(buttonMakeSureCash:) forControlEvents:UIControlEventTouchUpInside];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location >9) {
        
        return NO;
        
    } else {
        
        return YES;
    }
}

//确认投资按钮
- (void)buttonMakeSureCash:(UIButton *)button
{
    [self.view endEditing:NO];
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        buttonMake.frame = CGRectMake(40, HEIGHT_CONTROLLER_DEFAULT - 20 - 120 - 40 - 64, WIDTH_CONTROLLER_DEFAULT - 80, 40);
        
    } completion:^(BOOL finished) {
        
    }];
    
    [self getMyRedPacketList];
}

//红包展示
- (void)redBagListShow
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    butBlackAlert = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor blackColor] textColor:nil titleText:nil];
    [app.tabBarVC.view addSubview:butBlackAlert];
    butBlackAlert.alpha = 0.3;
    [butBlackAlert addTarget:self action:@selector(buttonDisappear:) forControlEvents:UIControlEventTouchUpInside];
    
    viewBottomD = [CreatView creatViewWithFrame:CGRectMake(30, (HEIGHT_CONTROLLER_DEFAULT - 20 - 64)/2 - 110, WIDTH_CONTROLLER_DEFAULT - 60, 220) backgroundColor:[UIColor whiteColor]];
    [app.tabBarVC.view addSubview:viewBottomD];
    viewBottomD.layer.cornerRadius = 5;
    viewBottomD.layer.masksToBounds = YES;
    
    CGFloat viewWidth = viewBottomD.frame.size.width;
    CGFloat viewHeight = viewBottomD.frame.size.height;
    
    UILabel *labelChoose = [CreatView creatWithLabelFrame:CGRectMake(0, 0, viewWidth, 35) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"选择红包"];
    [viewBottomD addSubview:labelChoose];
    
    UILabel *labelLine = [CreatView creatWithLabelFrame:CGRectMake(0, 34.5, viewWidth, 0.5) backgroundColor:[UIColor daohanglan] textColor:nil textAlignment:NSTextAlignmentCenter textFont:nil text:nil];
    [labelChoose addSubview:labelLine];
    
//    放立即使用按钮的view
    UIView *viewMake = [CreatView creatViewWithFrame:CGRectMake(0, viewHeight - 70, viewWidth, 70) backgroundColor:[UIColor whiteColor]];
    [viewBottomD addSubview:viewMake];
    
    UIButton *butRiNowUse = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(20, 15, viewMake.frame.size.width - 40, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"立即使用"];
    [viewMake addSubview:butRiNowUse];
    butRiNowUse.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    [butRiNowUse setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
    [butRiNowUse setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
    [butRiNowUse addTarget:self action:@selector(buttonRightNowUse:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, 0, viewMake.frame.size.width, 0.5) backgroundColor:[UIColor grayColor]];
    [viewMake addSubview:viewLine];
    viewLine.alpha = 0.2;
    
    [self tableViewRedBagShow];
}

//选择红包展示
- (void)tableViewRedBagShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 35, viewBottomD.frame.size.width, viewBottomD.frame.size.height - 35 - 70) style:UITableViewStylePlain];
    [viewBottomD addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorColor = [UIColor clearColor];
    [_tableView registerNib:[UINib nibWithNibName:@"TChooseRedBagCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return redBagArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TChooseRedBagCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    if (currentIndexPath != nil && indexPath.row == currentIndexPath.row) {

//        cell.butChoose.tag = 8000;
        [cell.butChoose setBackgroundImage:[UIImage imageNamed:@"iconfont-dui-2"] forState:UIControlStateNormal];

    } else {

//        cell.butChoose.tag = 9000;
        [cell.butChoose setBackgroundImage:[UIImage imageNamed:@"iconfont-dui-2111"] forState:UIControlStateNormal];
    }

    [cell.butChoose addTarget:self action:@selector(buttonChooseOrNo:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.butSend setTitle:@"送" forState:UIControlStateNormal];
    cell.butSend.backgroundColor = [UIColor daohanglan];
    cell.butSend.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    cell.butSend.layer.cornerRadius = 3;
    cell.butSend.layer.masksToBounds = YES;
    
    TRedBagModel *redModel = [chooseBagArr objectAtIndex:indexPath.row];
    cell.labelRedBag.backgroundColor = [UIColor clearColor];
    
//    红包金额
    if ([redModel.rpTop isEqualToString:redModel.rpFloor]) {
        NSMutableAttributedString *redBagStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元", redModel.rpTop]];
        NSRange range = NSMakeRange(0, [[redBagStr string] rangeOfString:@"元"].location);
        [redBagStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"ArialMT" size:20] range:range];
        NSRange rangeY = NSMakeRange([[redBagStr string] length] - 1, 1);
        [redBagStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:10] range:rangeY];
        [cell.labelRedBag setAttributedText:redBagStr];
        
    } else {
        
        NSMutableAttributedString *redBagStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@~%@元", redModel.rpFloor, redModel.rpTop]];
        NSRange range = NSMakeRange(0, [[redBagStr string] rangeOfString:@"元"].location);
        [redBagStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"ArialMT" size:20] range:range];
        NSRange rangeY = NSMakeRange([[redBagStr string] length] - 1, 1);
        [redBagStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:10] range:rangeY];
        [cell.labelRedBag setAttributedText:redBagStr];
    }
    
    cell.labelRedBag.textColor = [UIColor daohanglan];
    
//    红包时间
    cell.labelTime.backgroundColor = [UIColor clearColor];
    cell.labelTime.text = [NSString stringWithFormat:@"有效期:截止%@", redModel.rpTime];
    cell.labelTime.font = [UIFont fontWithName:@"CenturyGothic" size:9];
    cell.labelTime.textColor = [UIColor zitihui];
    
//    红包类型
    cell.labelStyle.text = redModel.rpTypeName;
    cell.labelStyle.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    
    cell.labelContent.text = [NSString stringWithFormat:@"单笔投资金额满%@元", redModel.rpLimit];
    cell.labelContent.textColor = [UIColor zitihui];
    cell.labelContent.font = [UIFont fontWithName:@"CenturyGothic" size:10];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    redbagModel = [chooseBagArr objectAtIndex:indexPath.row];
    NSLog(@"%@",[chooseBagArr objectAtIndex:indexPath.row] );
    
    currentIndexPath = indexPath;
    [tableView reloadData];
}

//勾选红包按钮
- (void)buttonChooseOrNo:(UIButton *)button
{
    if (button.tag == 8000) {
        
        [button setBackgroundImage:[UIImage imageNamed:@"iconfont-dui-2111"] forState:UIControlStateNormal];
        button.tag = 9000;
        
    } else {
        
        button.tag = 8000;
        [button setBackgroundImage:[UIImage imageNamed:@"iconfont-dui-2"] forState:UIControlStateNormal];
    }
}

//立即使用按钮
- (void)buttonRightNowUse:(UIButton *)button
{
    NSLog(@"用了");
//    if (self.decide == NO) {
//        
//        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
//        NSDictionary *parameter;
//        if ([redbagModel rpID] == nil) {
//            parameter = @{@"productId":[self.detailM productId],@"packetId":@"",@"orderMoney":[NSNumber numberWithFloat:[textFieldShu.text floatValue]],@"payMoney":@0,@"payType":@1,@"payPwd":@"",@"token":[dic objectForKey:@"token"],@"clientType":@"iOS"};
//        } else {
//            parameter = @{@"productId":[self.detailM productId],@"packetId":[redbagModel rpID],@"orderMoney":[NSNumber numberWithFloat:[textFieldShu.text floatValue]],@"payMoney":@0,@"payType":@1,@"payPwd":@"",@"token":[dic objectForKey:@"token"],@"clientType":@"iOS"};
//        }
//        
//        [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/buyProduct" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
//            
//            NSLog(@"buyProduct = %@",responseObject);
//            if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
//                if ([redbagModel rpID] == nil) {
//                    //              支付没有红包
//                    CashFinishViewController *cashFinish = [[CashFinishViewController alloc] init];
//                    cashFinish.nHand = self.nHand;
//                    cashFinish.moneyString = textFieldShu.text;
//                    cashFinish.endTimeString = [self.detailM endTime];
//                    cashFinish.productName = [self.detailM productName];
//                    cashFinish.syString = syString;
//                    [self.navigationController pushViewController:cashFinish animated:YES];
//                } else {
//                    //              支付有红包
//                    ShareHaveRedBag *shareHave = [[ShareHaveRedBag alloc] init];
//                    shareHave.redbagModel = redbagModel;
//                    shareHave.nHand = self.nHand;
//                    shareHave.moneyString = textFieldShu.text;
//                    shareHave.endTimeString = [self.detailM endTime];
//                    shareHave.productName = [self.detailM productName];
//                    shareHave.syString = syString;
//                    [self.navigationController pushViewController:shareHave animated:YES];
//                    [self showTanKuangWithMode:MBProgressHUDModeText Text:@"支付成功"];
//                }
//                
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"refrushToPickProduct" object:nil];
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"refrushToProductList" object:nil];
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"exchangeWithImageView" object:nil];
//                
//            } else {
//                [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
//            }
//            
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            
//            NSLog(@"%@", error);
//            
//        }];
//        
//    } else {
    
        [self buttonDisappear:nil];

        [self ziFuPasswordView];
        
//        _balanceVC = [[FBalancePaymentViewController alloc] init];
//        _balanceVC.productName = [self.detailM productName];
//        _balanceVC.idString = [self.detailM productId];
//        _balanceVC.moneyString = [NSString stringWithFormat:@"%.2f",[textFieldShu.text floatValue]];
//        _balanceVC.typeString = [self.detailM productType];
//        _balanceVC.redbagModel = redbagModel;
//        _balanceVC.nHand = self.nHand;
//        _balanceVC.syString = syString;
//        _balanceVC.endTimeString = [self.detailM endTime];
//        [self.navigationController pushViewController:_balanceVC animated:YES];
        
//    }

}

- (void)ziFuPasswordView{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    [app.tabBarVC.view addSubview:viewGray];
    
    if (viewGray != nil) {
        viewGray.hidden = NO;
    }
    
    NSBundle *rootBundle = [NSBundle mainBundle];
    
    ZFPView = [[rootBundle loadNibNamed:@"ZFPassword" owner:nil options:nil] lastObject];
    
    [ZFPView setFrame:CGRectMake((self.view.frame.size.width - 300) / 2.0, 200, 300, 200)];
    
    [app.tabBarVC.view addSubview:ZFPView];
    
    [ZFPView.closeButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    [ZFPView.sureButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [ZFPView.setDealButton addTarget:self action:@selector(setDealSecret:) forControlEvents:UIControlEventTouchUpInside];
    [ZFPView.forgetButton addTarget:self action:@selector(ForgetSecretButton:) forControlEvents:UIControlEventTouchUpInside];
    [ZFPView.worrySureButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    ZFPView.moneyLabel.text = [NSString stringWithFormat:@"¥%@",textFieldShu.text];
    
    if ([[dataDic objectForKey:@"setPayPwd"] isEqualToNumber:[NSNumber numberWithInt:1]]) {
        ZFPView.setDealButton.hidden = YES;
        ZFPView.forgetButton.hidden = NO;
        ZFPView.moneyTF.hidden = NO;
        ZFPView.moneyTF.delegate = self;
    }

}

- (void)closeAction:(id)sender{
    
    viewGray.hidden = YES;
    ZFPView.hidden = YES;
    [ZFPView.moneyTF resignFirstResponder];
    
}

- (void)sureAction:(id)sender{
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    if (ZFPView.moneyTF.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"支付密码不能为空"];
    } else {
        click ++;
        if (click == 1) {
            [self submitLoadingWithView:app.tabBarVC.view loadingFlag:NO height:0];
            
        } else {
            
            [self submitLoadingWithHidden:NO view:app.tabBarVC.view];
        }
        
        [self buyProduct];
    }
    [ZFPView.moneyTF resignFirstResponder];
}

//设置交易密码
- (void)setDealSecret:(UIButton *)button
{
    [self closeAction:nil];
    SetDealSecret *deal = [[SetDealSecret alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenWithCell:) name:@"hiddenWithCell" object:nil];
    [self.navigationController pushViewController:deal animated:YES];
}

- (void)hiddenWithCell:(NSNotification *)not{
    UIButton *forgetB = (UIButton *)[self.view viewWithTag:9873];
    UIButton *setPWord = (UIButton *)[self.view viewWithTag:9871];
    
    forgetB.hidden = NO;
    setPWord.hidden = YES;
    ZFPView.moneyTF.hidden = NO;
}

//忘记密码?按钮
- (void)ForgetSecretButton:(UIButton *)button
{
    [self closeAction:nil];
    FindDealViewController *findSecretVC = [[FindDealViewController alloc] init];
    findSecretVC.whichOne = NO;
    [self.navigationController pushViewController:findSecretVC animated:YES];
}


//黑色遮罩层消失方法
- (void)buttonDisappear:(UIButton *)button
{
    [butBlackAlert removeFromSuperview];
    [viewBottomD removeFromSuperview];
    [self.viewBottom removeFromSuperview];
    
    butBlackAlert = nil;
    viewBottomD = nil;
    self.viewBottom = nil;
}

//textField代理方法
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (WIDTH_CONTROLLER_DEFAULT == 375) {
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            
            buttonMake.frame = CGRectMake(40, 290, WIDTH_CONTROLLER_DEFAULT - 80, 40);
            
        } completion:^(BOOL finished) {
            
        }];
        
    } else if (WIDTH_CONTROLLER_DEFAULT == 414) {
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            
            buttonMake.frame = CGRectMake(40, 320, WIDTH_CONTROLLER_DEFAULT - 80, 40);
            
        } completion:^(BOOL finished) {
            
        }];
    }
}

//textField绑定方法
- (void)textFieldEditChanged:(UITextField *)textField
{
    labelCoin.text = [NSString stringWithFormat:@"%.2f元", textFieldShu.text.floatValue];
    syString = labelCoin.text;
    labelYJmoney.text = [NSString stringWithFormat:@"%.2f元",[textField.text floatValue] * [[self.detailM productAnnualYield] floatValue] * [[self.detailM productPeriod]floatValue] / 36500.0];
}

//回收键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:NO];
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        buttonMake.frame = CGRectMake(40, HEIGHT_CONTROLLER_DEFAULT - 20 - 120 - 40 - 64, WIDTH_CONTROLLER_DEFAULT - 80, 40);
        
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark 获取红包
#pragma mark --------------------------------

- (void)getMyRedPacketList{
    
    if (redBagArray.count > 0) {
        [redBagArray removeAllObjects];
        redBagArray = nil;
        redBagArray = [NSMutableArray array];
    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSDictionary *parameter = nil;
    
    if (self.decide == NO) {
        parameter = @{@"token":[dic objectForKey:@"token"],@"buyMoney":@"5000",@"days":[self.detailM productPeriod]};
    } else {
        parameter = @{@"token":[dic objectForKey:@"token"],@"buyMoney":textFieldShu.text,@"days":[self.detailM productPeriod]};
    }
    
    NSLog(@"getMyRedPacketList parameter = %@",parameter);
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/redpacket/getUserRedPacketRandList" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"获取红包列表 = %@",responseObject);
        
        redBagArray = [NSMutableArray arrayWithArray:[responseObject objectForKey:@"RedPacket"]];
        NSLog(@"我是个红包===========%@", redBagArray);
        for (NSDictionary *dataDic1 in redBagArray) {
            TRedBagModel *redbagModel1 = [[TRedBagModel alloc] init];
            [redbagModel1 setValuesForKeysWithDictionary:dataDic1];
            [chooseBagArr addObject:redbagModel1];
        }
        
        NSLog(@"本数组中有对象:::%@", chooseBagArr);
        
        //   numberInt是可用余额
        CGFloat numberInt = [[[DES3Util decrypt:[accountDic objectForKey:@"accBalance"]] stringByReplacingOccurrencesOfString:@"," withString:@""] floatValue];
        NSInteger shuRuInt = textFieldShu.text.integerValue;
        NSInteger qiTouMoney = self.detailM.amountMin.integerValue;
        NSInteger diZengMoney = self.detailM.amountIncrease.integerValue;
        NSInteger money = shuRuInt % diZengMoney;
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        
//        外层判断 输入的金额与账户余额的判断
        if (shuRuInt > numberInt && shuRuInt != 0) {
            
//            [self showTanKuangWithMode:MBProgressHUDModeText Text:@"余额不足,请充值"];
            
            butBlackAlert = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor blackColor] textColor:nil titleText:nil];
            [app.tabBarVC.view addSubview:butBlackAlert];
            butBlackAlert.alpha = 0.3;
            [butBlackAlert addTarget:self action:@selector(buttonDisappear:) forControlEvents:UIControlEventTouchUpInside];
            
            self.viewBottom = [CreatView creatViewWithFrame:CGRectMake(50, (HEIGHT_CONTROLLER_DEFAULT - 20)/2 - 80, WIDTH_CONTROLLER_DEFAULT - 100, 160) backgroundColor:[UIColor whiteColor]];
            [app.tabBarVC.view addSubview:self.viewBottom];
            self.viewBottom.layer.cornerRadius = 3;
            self.viewBottom.layer.masksToBounds = YES;
            
            CGFloat viewWidth = self.viewBottom.frame.size.width;
            
            UILabel *label = [CreatView creatWithLabelFrame:CGRectMake(0, 30, viewWidth, 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"您的余额不足,去充值？"];
            [self.viewBottom addSubview:label];
            
            UIButton *butCancle = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(20, 90, (viewWidth - 50)/2, 40) backgroundColor:[UIColor colorWithRed:114.0 / 225.0 green:113.0 / 225.0 blue:111.0 / 225.0 alpha:1.0] textColor:[UIColor whiteColor] titleText:@"取消"];
            [self.viewBottom addSubview:butCancle];
            butCancle.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
            butCancle.layer.cornerRadius = 3;
            butCancle.layer.masksToBounds = YES;
            [butCancle addTarget:self action:@selector(buttonDisappear:) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton *butDecide = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(butCancle.frame.size.width + 30, 90, (viewWidth - 50)/2, 40) backgroundColor:[UIColor daohanglan] textColor:[UIColor whiteColor] titleText:@"确定"];
            [self.viewBottom addSubview:butDecide];
            butDecide.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
            butDecide.layer.cornerRadius = 3;
            butDecide.layer.masksToBounds = YES;
            [butDecide addTarget:self action:@selector(buttonMakeSureGoToCashMoney:) forControlEvents:UIControlEventTouchUpInside];
            
//            NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
//            if ([[dic objectForKey:@"realName"] isEqualToString:@""]) {
//                [self showTanKuangWithMode:MBProgressHUDModeText Text:@"充值必须先通过实名认证"];
//                RealNameViewController *realNameVC = [[RealNameViewController alloc] init];
//                realNameVC.realNamePan = YES;
//                [self.navigationController pushViewController:realNameVC animated:YES];
//            } else {
//                RechargeAlreadyBinding *recharge = [[RechargeAlreadyBinding alloc] init];
//                [self.navigationController pushViewController:recharge animated:YES];
//            }
            
        } else {
            
//            内层判断 输入的金额与起投金额的判断
            if (shuRuInt == qiTouMoney) {
                
                if (redBagArray.count == 0) {
                    NSLog(@"下一页");
                    
                    [self buttonDisappear:nil];
                    
                    [self ziFuPasswordView];
//                    _balanceVC = [[FBalancePaymentViewController alloc] init];
//                    _balanceVC.productName = [self.detailM productName];
//                    _balanceVC.idString = [self.detailM productId];
//                    _balanceVC.moneyString = [NSString stringWithFormat:@"%.2f",[textFieldShu.text floatValue]];
//                    _balanceVC.typeString = [self.detailM productType];
//                    _balanceVC.redbagModel = redbagModel;
//                    _balanceVC.nHand = self.nHand;
//                    _balanceVC.syString = syString;
//                    _balanceVC.endTimeString = [self.detailM endTime];
//                    [self.navigationController pushViewController:_balanceVC animated:YES];
                    
                } else {
                    [self redBagListShow];
                }
                
            } else if (shuRuInt > qiTouMoney) {
                
                if (money == 0) {
                    
                    if (redBagArray.count == 0) {
                        NSLog(@"下一页");
                        
                        [self buttonDisappear:nil];
                        
                        [self ziFuPasswordView];
//                        _balanceVC = [[FBalancePaymentViewController alloc] init];
//                        _balanceVC.productName = [self.detailM productName];
//                        _balanceVC.idString = [self.detailM productId];
//                        _balanceVC.moneyString = [NSString stringWithFormat:@"%.2f",[textFieldShu.text floatValue]];
//                        _balanceVC.typeString = [self.detailM productType];
//                        _balanceVC.redbagModel = redbagModel;
//                        _balanceVC.nHand = self.nHand;
//                        _balanceVC.syString = syString;
//                        _balanceVC.endTimeString = [self.detailM endTime];
//                        [self.navigationController pushViewController:_balanceVC animated:YES];
                        
                    } else {
                        [self redBagListShow];
                    }
                    
                } else {
                    
                    [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请按照起投金额和递增金额条件输入"];
                    return ;
                }
                
            } else if (textFieldShu.text.length == 0) {
                
                [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入投资金额"];
                
            } else {
                
                [self showTanKuangWithMode:MBProgressHUDModeText Text:@"投资金额大于起投金额"];
                return ;
            }
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

//确认充值按钮
- (void)buttonMakeSureGoToCashMoney:(UIButton *)button
{
    RechargeAlreadyBinding *recharge = [[RechargeAlreadyBinding alloc] init];
    [self.navigationController pushViewController:recharge animated:YES];
}

#pragma mark 网络请求方法(立即购买)
#pragma mark --------------------------------

- (void)buyProduct{
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSDictionary *parameter;
    
    if ([redbagModel rpID] == nil){
        parameter = @{@"productId":[self.detailM productId],@"packetId":@"",@"orderMoney":[NSNumber numberWithFloat:[textFieldShu.text floatValue]],@"payMoney":@0,@"payType":@1,@"payPwd":ZFPView.moneyTF.text,@"token":[dic objectForKey:@"token"],@"clientType":@"iOS"};
    } else {
        parameter = @{@"productId":[self.detailM productId],@"packetId":[redbagModel rpID],@"orderMoney":[NSNumber numberWithFloat:[textFieldShu.text floatValue]],@"payMoney":@0,@"payType":@1,@"payPwd":ZFPView.moneyTF.text,@"token":[dic objectForKey:@"token"],@"clientType":@"iOS"};
    }
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/buyProduct" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"buyProduct = %@",responseObject);
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        [self submitLoadingWithHidden:YES view:app.tabBarVC.view];
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            [self closeAction:nil];
            [self buttonDisappear:nil];
            [self submitLoadingWithHidden:YES view:app.tabBarVC.view];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refrushToPickProduct" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refrushToProductList" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"exchangeWithImageView" object:nil];
            
            if ([redbagModel rpID] == nil) {
                //支付没有红包
                CashOtherFinViewController *cashOther = [[CashOtherFinViewController alloc] init];
                cashOther.nHand = self.nHand;
                cashOther.moneyString = textFieldShu.text;
                cashOther.syString = syString;
                cashOther.endTimeString = [self.detailM endTime];
                cashOther.productName = [self.detailM productName];
                [self.navigationController pushViewController:cashOther animated:YES];
            } else {
                //支付有红包
                ShareHaveRedBag *shareHave = [[ShareHaveRedBag alloc] init];
                shareHave.nHand = self.nHand;
                shareHave.redbagModel = redbagModel;
                shareHave.moneyString = textFieldShu.text;
                shareHave.syString = syString;
                shareHave.endTimeString = [self.detailM endTime];
                shareHave.productName = [self.detailM productName];
                [self.navigationController pushViewController:shareHave animated:YES];
                //                [self showTanKuangWithMode:MBProgressHUDModeText Text:@"支付成功"];
            }
        } else {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            [self submitLoadingWithHidden:YES view:app.tabBarVC.view];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

#pragma mark 网络请求获得我的绑定的银行卡号
#pragma mark --------------------------------

- (void)getData
{
    NSDictionary *parameter = @{@"token":[self.flagDic objectForKey:@"token"]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/getUserInfo" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
            
        dataDic = [NSDictionary dictionary];
        dataDic = [responseObject objectForKey:@"User"];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [butBlackAlert removeFromSuperview];
    [viewBottomD removeFromSuperview];
    [self.viewBottom removeFromSuperview];
    
    butBlackAlert = nil;
    viewBottomD = nil;
    self.viewBottom = nil;
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
