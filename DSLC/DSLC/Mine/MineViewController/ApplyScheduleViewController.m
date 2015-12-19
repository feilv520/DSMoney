//
//  ApplyScheduleViewController.m
//  DSLC
//
//  Created by ios on 15/11/9.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "ApplyScheduleViewController.h"
#import "EditBigMoney.h"
#import "ApplySchedule.h"
#import "BigMoneyViewController.h"

@interface ApplyScheduleViewController () <UITextFieldDelegate>

{
    NSArray *contentArr;
    UIButton *buttonHei;
    UIView *viewChoose;
    UILabel *labelLine;
    
    UIView *viewWhite;
    UIImageView *imageSchedule;
    UITextField *fieldShuRu;
    UIButton *butEdit;
    UIButton *butSubmit;
    UIButton *buttCancle;
    UIButton *butFinish;
    
    UILabel *labelTwo;
    UILabel *labelThree;
    UILabel *labelFour;
    UILabel *labelTime;
    NSMutableArray *dataArray;
    UILabel *labeltime;
    ApplySchedule *applySch;
    
//    财务审核时间
    UILabel *labelCheckTime;
//    充值成功与否时间
    UILabel *labelDoTime;
    UIButton *buttWell;
    UIButton *buttonAplly;
    UIButton *butSubmitAlert;
}

@end

@implementation ApplyScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor huibai];
    [self.navigationItem setTitle:@"申请进度"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishApplyButton:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:14]} forState:UIControlStateNormal];
    
    UIImageView *imageReturn = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, 20, 20) backGroundColor:nil setImage:[UIImage imageNamed:@"750产品111"]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:imageReturn];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonReturn:)];
    [imageReturn addGestureRecognizer:tap];
    
    dataArray = [NSMutableArray array];
    [self getData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData:) name:@"reload" object:nil];
}

- (void)buttonReturn:(UIBarButtonItem *)bar
{
    NSArray *viewController = [self.navigationController viewControllers];
    [self.navigationController popToViewController:[viewController objectAtIndex:1] animated:YES];
}

- (void)reloadData:(NSNotification *)notice
{
    [self getData];
}

- (void)contentShow
{
    contentArr = @[@"大额充值申请已提交", @"财务待审", @"充值成功"];
    
    viewWhite = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT / 2 - 10) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewWhite];
    
    labelLine = [CreatView creatWithLabelFrame:CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT/2 - 10 - 0.5, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor] textColor:nil textAlignment:NSTextAlignmentCenter textFont:nil text:nil];
    [viewWhite addSubview:labelLine];
    labelLine.alpha = 0.2;
    
    CGFloat viewHeight = viewWhite.frame.size.height;
    
    imageSchedule = [CreatView creatImageViewWithFrame:CGRectMake(18, 22, 14, viewHeight - 40 - 25) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"1"]];
    [viewWhite addSubview:imageSchedule];
    
//    if (HEIGHT_CONTROLLER_DEFAULT == 480 + 20) {
    
        for (int i = 0; i < 3; i++) {
            
            UILabel *label = [CreatView creatWithLabelFrame:CGRectMake(40, 20 + 20 * i + 70 * i, WIDTH_CONTROLLER_DEFAULT/2, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:[contentArr objectAtIndex:i]];
            [viewWhite addSubview:label];
            label.tag = 2000 + i;
            
            if (i == 0) {
                
                label.textColor = [UIColor chongzhiColor];
            }
            
            if (i == 1) {
                
                label.frame = CGRectMake(40, 103, WIDTH_CONTROLLER_DEFAULT - 50, 20);
            }

            if (i == 2) {
                label.frame = CGRectMake(40, 183, WIDTH_CONTROLLER_DEFAULT/2, 20);
            }

        }
    
//    }
//    else if (HEIGHT_CONTROLLER_DEFAULT == 568 + 20) {
//        
//        for (int i = 0; i < 4; i++) {
//            
//            UILabel *label = [CreatView creatWithLabelFrame:CGRectMake(40, 20 + 20 * i + 60 * i, WIDTH_CONTROLLER_DEFAULT/2, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:[contentArr objectAtIndex:i]];
//            [viewWhite addSubview:label];
//            label.tag = 2000 + i;
//            
//            if (i == 0) {
//                
//                label.textColor = [UIColor chongzhiColor];
//            }
//            
//            if (i == 1) {
//                
//                label.frame = CGRectMake(40, 98, WIDTH_CONTROLLER_DEFAULT - 50, 20);
//            }
//            
//        }
//
//    } else {
//        
//        for (int i = 0; i < 4; i++) {
//            
//            UILabel *label = [CreatView creatWithLabelFrame:CGRectMake(40, 20 + 20 * i + 75 * i, WIDTH_CONTROLLER_DEFAULT/2 - 5, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:[contentArr objectAtIndex:i]];
//            [viewWhite addSubview:label];
//            label.tag = 2000 + i;
//            
//            if (i == 0) {
//                
//                label.textColor = [UIColor chongzhiColor];
//            }
//            
//            if (i == 1) {
//                
//                label.frame = CGRectMake(40, 115, WIDTH_CONTROLLER_DEFAULT - 50, 20);
//            }
//        }
//    }
    
//    大额申请已提交显示的提示
    butSubmitAlert = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT/2 - 10 + 25, WIDTH_CONTROLLER_DEFAULT, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] titleText:@"大额充值申请单已经提交成功,\n我们将在2个工作日内进行核实!"];
    [self.view addSubview:butSubmitAlert];
    butSubmitAlert.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    butSubmitAlert.titleLabel.numberOfLines = 2;
    [butSubmitAlert setImage:[UIImage imageNamed:@"duigou"] forState:UIControlStateNormal];
    
//    申请的时间
    labeltime = [CreatView creatWithLabelFrame:CGRectMake(40, 45, WIDTH_CONTROLLER_DEFAULT/2, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:applySch.createTime];
    [viewWhite addSubview:labeltime];
    
    butEdit = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - WIDTH_CONTROLLER_DEFAULT/4 - 15, 22, WIDTH_CONTROLLER_DEFAULT/4, 35) backgroundColor:[UIColor whiteColor] textColor:[UIColor daohanglan] titleText:@"编辑"];
    [viewWhite addSubview:butEdit];
    butEdit.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    [butEdit setBackgroundImage:[UIImage imageNamed:@"红框"] forState:UIControlStateNormal];
    [butEdit setBackgroundImage:[UIImage imageNamed:@"红框"] forState:UIControlStateHighlighted];
    [butEdit addTarget:self action:@selector(buttonEdit:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    if (HEIGHT_CONTROLLER_DEFAULT == 480 + 20) {
        
//        财务审核时间
        labelCheckTime = [CreatView creatWithLabelFrame:CGRectMake(40, 125, WIDTH_CONTROLLER_DEFAULT/2, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:@"啦啦啦啦"];
        
//        充值成功与否时间
        labelDoTime = [CreatView creatWithLabelFrame:CGRectMake(40, 205, WIDTH_CONTROLLER_DEFAULT/2, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:@"kkkk"];
        
    } else if (HEIGHT_CONTROLLER_DEFAULT == 568 + 20) {
        
//        财务审核时间
        labelCheckTime = [CreatView creatWithLabelFrame:CGRectMake(40, 205, WIDTH_CONTROLLER_DEFAULT/2, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:@"啦啦啦啦"];
        
//        充值成功与否时间
        labelDoTime = [CreatView creatWithLabelFrame:CGRectMake(40, 285, WIDTH_CONTROLLER_DEFAULT/2, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:@"kkkk"];
        
    } else {
        
//        财务审核时间
        labelCheckTime = [CreatView creatWithLabelFrame:CGRectMake(40, 235, WIDTH_CONTROLLER_DEFAULT/2, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:@"啦啦啦啦"];
        
//        充值成功与否时间
        labelDoTime = [CreatView creatWithLabelFrame:CGRectMake(40, 330, WIDTH_CONTROLLER_DEFAULT/2, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:@"kkkk"];
    }
    
    [viewWhite addSubview:labelCheckTime];
    [viewWhite addSubview:labelDoTime];
    
    labelCheckTime.hidden = YES;
    labelDoTime.hidden = YES;
    
    buttCancle = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(17, HEIGHT_CONTROLLER_DEFAULT/2 + 75, (WIDTH_CONTROLLER_DEFAULT - 34 - 16)/2, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor chongzhiColor] titleText:@"取消申请"];
    [self.view addSubview:buttCancle];
    buttCancle.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttCancle setBackgroundImage:[UIImage imageNamed:@"蓝框"] forState:UIControlStateNormal];
    [buttCancle setBackgroundImage:[UIImage imageNamed:@"蓝框"] forState:UIControlStateHighlighted];
    [buttCancle addTarget:self action:@selector(cancleApplyButton:) forControlEvents:UIControlEventTouchUpInside];
    
    butFinish = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(33 + (WIDTH_CONTROLLER_DEFAULT - 34 - 16)/2, HEIGHT_CONTROLLER_DEFAULT/2 + 75, (WIDTH_CONTROLLER_DEFAULT - 34 - 16)/2, 40) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"完成"];
    [self.view addSubview:butFinish];
    butFinish.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butFinish setBackgroundImage:[UIImage imageNamed:@"蓝色完成"] forState:UIControlStateNormal];
    [butFinish setBackgroundImage:[UIImage imageNamed:@"蓝色完成"] forState:UIControlStateHighlighted];
    [butFinish addTarget:self action:@selector(finishApplyButton:) forControlEvents:UIControlEventTouchUpInside];
    
//    此处是状态判断
    
//    "1"是指已提交流水单号
    if ([[applySch.status description] isEqualToString:@"100"]) {
        [self oneContent];
        
//    "2"或"4"
    } else if ([[applySch.status description] isEqualToString:@"2"] || [[applySch.status description] isEqualToString:@"4"]) {
        [self oneContent];
        [self twoOrFourContent];
        
//    "3"审核成功 即初审成功
    } else if ([[applySch.status description] isEqualToString:@"3"]) {
        [self oneContent];
        [self threeContent];
        
//    "5"充值成功
    } else if ([[applySch.status description] isEqualToString:@"5"]) {
        [self oneContent];
        [self fiveContent];
    }
}

//状态是1时的内容
- (void)oneContent
{
    if (HEIGHT_CONTROLLER_DEFAULT == 480 + 20) {
        
        labelTime = [CreatView creatWithLabelFrame:CGRectMake(40, 110, WIDTH_CONTROLLER_DEFAULT/3 * 2 - 30, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:applySch.updateTime];
        
    } else if (HEIGHT_CONTROLLER_DEFAULT == 568 + 20) {
        
        labelTime = [CreatView creatWithLabelFrame:CGRectMake(40, 125, WIDTH_CONTROLLER_DEFAULT/3 * 2 - 30, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:applySch.updateTime];
        
    } else {
        
        labelTime = [CreatView creatWithLabelFrame:CGRectMake(40, 145, WIDTH_CONTROLLER_DEFAULT/3 * 2 - 30, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:applySch.updateTime];
    }
    
//    [viewWhite addSubview:labelTime];
    
    labelTwo = (UILabel *)[self.view viewWithTag:2001];
    labelTwo.text = @"已打款";
    labelTwo.textColor = [UIColor chongzhiColor];
    
    butEdit.hidden = YES;
    imageSchedule.image = [UIImage imageNamed:@"组-15"];
    
    butFinish.hidden = YES;
    buttCancle.hidden = YES;
    
//    buttWell = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT / 2 + 60, WIDTH_CONTROLLER_DEFAULT, 50) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] titleText:@" 转账/POS单号已经提交成功,\n 我们将在24小时内进行核实!"];
//    [viewWhite addSubview:buttWell];
//    buttWell.titleLabel.numberOfLines = 2;
//    buttWell.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
//    [buttWell setImage:[UIImage imageNamed:@"iconfont"] forState:UIControlStateNormal];
}

//状态是2或4时的内容
- (void)twoOrFourContent
{
    buttWell.frame = CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT/2 + 40, WIDTH_CONTROLLER_DEFAULT, 55);
    [buttWell setTitle:@" 审核未通过,您提交的信息有误,\n请在核对后重新申请如有问题\n请拨打客服热线:400-816-2283" forState:UIControlStateNormal];
    [buttWell setImage:[UIImage imageNamed:@"iconfont-register-gantanhao001"] forState:UIControlStateNormal];
    buttWell.titleLabel.numberOfLines = 3;
    
    //        重新申请按钮
    buttonAplly = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, HEIGHT_CONTROLLER_DEFAULT/2 + 40 + 55 + 10, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"重新申请"];
    [self.view addSubview:buttonAplly];
    buttonAplly.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    [buttonAplly setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
    [buttonAplly setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
    [buttonAplly addTarget:self action:@selector(buttonAnotherApply:) forControlEvents:UIControlEventTouchUpInside];
    
    labelThree = (UILabel *)[self.view viewWithTag:2002];
    
    if (HEIGHT_CONTROLLER_DEFAULT == 480 + 20) {
        
        labelTwo = (UILabel *)[self.view viewWithTag:2001];
        labelTwo.frame = CGRectMake(40, 117, WIDTH_CONTROLLER_DEFAULT/3 * 2 - 30, 20);
        labelTime.frame = CGRectMake(40, 135 + 5, WIDTH_CONTROLLER_DEFAULT/3 * 2 - 30, 20);
        
        labelThree.frame = CGRectMake(40, 212, WIDTH_CONTROLLER_DEFAULT/2, 20);
        labelCheckTime.frame = CGRectMake(40, 234, WIDTH_CONTROLLER_DEFAULT/3 * 2 - 30, 20);
        
    } else if (HEIGHT_CONTROLLER_DEFAULT == 568 + 20) {
        
        labelTwo = (UILabel *)[self.view viewWithTag:2001];
        labelTwo.frame = CGRectMake(40, 137, WIDTH_CONTROLLER_DEFAULT/3 * 2 - 30, 20);
        labelTime.frame = CGRectMake(40, 155 + 5, WIDTH_CONTROLLER_DEFAULT/3 * 2 - 30, 20);
        
        labelThree.frame = CGRectMake(40, 252, WIDTH_CONTROLLER_DEFAULT/2, 20);
        labelCheckTime.frame = CGRectMake(40, 274, WIDTH_CONTROLLER_DEFAULT/3 * 2 - 30, 20);
        
    } else {
        
        labelTwo = (UILabel *)[self.view viewWithTag:2001];
        labelTwo.frame = CGRectMake(40, 162, WIDTH_CONTROLLER_DEFAULT/3 * 2 - 30, 20);
        labelTime.frame = CGRectMake(40, 180 + 5, WIDTH_CONTROLLER_DEFAULT/3 * 2 - 30, 20);
        
        labelThree.frame = CGRectMake(40, 298, WIDTH_CONTROLLER_DEFAULT/2, 20);
        labelCheckTime.frame = CGRectMake(40, 320, WIDTH_CONTROLLER_DEFAULT/3 * 2 - 30, 20);
        
        buttWell.frame = CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT/2 + 60, WIDTH_CONTROLLER_DEFAULT, 55);
        buttonAplly.frame = CGRectMake(40, HEIGHT_CONTROLLER_DEFAULT/2 + 60 + 55 + 10, WIDTH_CONTROLLER_DEFAULT - 80, 40);
    }
    
    labelThree.text = @"审核失败";
    labelThree.textColor = [UIColor daohanglan];
    
    labelCheckTime.hidden = NO;
    labelCheckTime.text = applySch.checkTime;
    labelCheckTime.text = @"labelCheckTime";
    imageSchedule.image = [UIImage imageNamed:@"组-19"];
    
    labelFour = (UILabel *)[self.view viewWithTag:2003];
    labelFour.hidden = YES;
    
}

//状态是3时的内容
- (void)threeContent
{
    labelTwo = (UILabel *)[self.view viewWithTag:2001];
    labelTwo.textColor = [UIColor chongzhiColor];
    labelTwo.text = @"审核通过";
    
    labelCheckTime.hidden = NO;
    labelCheckTime.text = applySch.checkTime;
    labelCheckTime.text = @"labelCheckTime";
    
    imageSchedule.image = [UIImage imageNamed:@"2"];
    [butSubmitAlert setTitle:@"审核通过,金额将在30分钟内到您的账户余额。" forState:UIControlStateNormal];
}

//状态是5时的内容
- (void)fiveContent
{
    labelTwo = (UILabel *)[self.view viewWithTag:2001];
    labelThree.text = @"审核通过";
    labelThree.textColor = [UIColor chongzhiColor];
    
    labelCheckTime.hidden = NO;
    labelCheckTime.text = applySch.recheckTime;
    labelCheckTime.text = @"labelCheckTime";
    
    labelThree = (UILabel *)[self.view viewWithTag:2002];
    labelThree.text = @"充值成功";
    labelThree.textColor = [UIColor chongzhiColor];
    
    labelDoTime.hidden = NO;
    labelDoTime.text = applySch.recheckTime;
    labelDoTime.text = @"labelDoTime";
    imageSchedule.image = [UIImage imageNamed:@"4"];
    [butSubmitAlert setTitle:@"恭喜您充值成功" forState:UIControlStateNormal];
    
    buttonAplly = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, HEIGHT_CONTROLLER_DEFAULT / 2 + 60, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"去赚钱"];
    [self.view addSubview:buttonAplly];
    buttonAplly.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    [buttonAplly setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
    [buttonAplly setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
    [buttonAplly addTarget:self action:@selector(buttonGoGetMoney:) forControlEvents:UIControlEventTouchUpInside];
}

//审核失败 重新申请按钮
- (void)buttonAnotherApply:(UIButton *)button
{
    BigMoneyViewController *bigMoney = [[BigMoneyViewController alloc] init];
    [self.navigationController pushViewController:bigMoney animated:YES];
}

//充值成功 去赚钱按钮
- (void)buttonGoGetMoney:(UIButton *)button
{
    NSLog(@"去赚钱");
    NSArray *viewController = [self.navigationController viewControllers];
    [self.navigationController popToViewController:[viewController objectAtIndex:1] animated:YES];
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.tabBarVC.tabScrollView setContentOffset:CGPointMake(WIDTH_CONTROLLER_DEFAULT, 0) animated:NO];
    
    UIButton *indexButton = [app.tabBarVC.tabButtonArray objectAtIndex:1];
    
    for (UIButton *tempButton in app.tabBarVC.tabButtonArray) {
        
        if (indexButton.tag != tempButton.tag) {
            
            [tempButton setSelected:NO];
        }
    }
    
    [indexButton setSelected:YES];
}

//编辑
- (void)buttonEdit:(UIButton *)button
{
    EditBigMoney *money = [[EditBigMoney alloc] init];
    money.schedule = applySch;
    NSLog(@"^^^^^^^^^%@", money.schedule.Id);
    NSLog(@"kkkkkkkkk%@", applySch.busName);
    [self.navigationController pushViewController:money animated:YES];
}

//提交按钮
- (void)submitButton:(UIButton *)button
{
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    NSDictionary *paremeter = @{@"id":applySch.Id, @"realName":@"", @"bankName":@"", @"account":@"", @"phone":@"", @"money":@"", @"tranSerialNum":fieldShuRu.text, @"token":[dic objectForKey:@"token"]};
    NSLog(@"%@", paremeter);
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/updateBigPutOnSerialNum" parameters:paremeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"bbbbbbbbbbb%@", responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:@"提交成功"];
            [self submitButtonContent];
            
        } else {
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

//提交按钮展示
- (void)submitButtonContent
{
    if (fieldShuRu.text.length == 6) {
        
        [self.view endEditing:YES];
        
        butEdit.hidden = YES;
        butSubmit.hidden = YES;
        fieldShuRu.hidden = YES;
        buttCancle.hidden = YES;
        butFinish.hidden = YES;
        
        if (HEIGHT_CONTROLLER_DEFAULT == 480 + 20) {
            
            labelTime = [CreatView creatWithLabelFrame:CGRectMake(40, 110, WIDTH_CONTROLLER_DEFAULT/3 * 2 - 30, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:applySch.updateTime];
            
        } else if (HEIGHT_CONTROLLER_DEFAULT == 568 + 20) {
            
            labelTime = [CreatView creatWithLabelFrame:CGRectMake(40, 125, WIDTH_CONTROLLER_DEFAULT/3 * 2 - 30, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:applySch.updateTime];
            
        } else {
            
            labelTime = [CreatView creatWithLabelFrame:CGRectMake(40, 145, WIDTH_CONTROLLER_DEFAULT/3 * 2 - 30, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:applySch.updateTime];
        }
        
        [viewWhite addSubview:labelTime];
        
        buttWell = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT / 2 + 60, WIDTH_CONTROLLER_DEFAULT, 50) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] titleText:@" 转账/POS单号已经提交成功,\n 我们将在24小时内进行核实!"];
        [viewWhite addSubview:buttWell];
        buttWell.titleLabel.numberOfLines = 2;
        buttWell.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
        [buttWell setImage:[UIImage imageNamed:@"iconfont"] forState:UIControlStateNormal];
        
        imageSchedule.image = [UIImage imageNamed:@"组-15"];
        
        labelTwo = (UILabel *)[self.view viewWithTag:2001];
        labelTwo.textColor = [UIColor chongzhiColor];
        labelTwo.text = @"已打款";
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishBarButton:)];
        [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:14]} forState:UIControlStateNormal];
        
    } else {
        
        
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location == 6) {
        
        return NO;
        
    } else {
        
        return YES;
    }
}

- (void)textFieldEditApply:(UITextField *)textField
{
    
}

//导航完成按钮
- (void)finishBarButton:(UIButton *)button
{
    NSArray *viewController = [self.navigationController viewControllers];
    [self.navigationController popToViewController:[viewController objectAtIndex:1] animated:YES];
}

//取消申请
- (void)cancleApplyButton:(UIButton *)button
{
    [self cancleBigMoneyApply];
}

//取消大额申请展示
- (void)cancleBigMoneyApply
{
    buttonHei = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor blackColor] textColor:nil titleText:nil];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.tabBarVC.view addSubview:buttonHei];
    buttonHei.alpha = 0.3;
    [buttonHei addTarget:self action:@selector(buttonChooseDisappear:) forControlEvents:UIControlEventTouchUpInside];
    
    viewChoose = [CreatView creatViewWithFrame:CGRectMake(30, HEIGHT_CONTROLLER_DEFAULT/2 - 110, WIDTH_CONTROLLER_DEFAULT - 60, HEIGHT_CONTROLLER_DEFAULT/4 - 20) backgroundColor:[UIColor whiteColor]];
    [app.tabBarVC.view addSubview:viewChoose];
    viewChoose.layer.cornerRadius = 5;
    viewChoose.layer.masksToBounds = YES;
    
    CGFloat viewWidth = viewChoose.frame.size.width;
    CGFloat viewHeight = viewChoose.frame.size.height;
    
    UILabel *labelCancle = [CreatView creatWithLabelFrame:CGRectMake(0, viewHeight/4 - 10, viewWidth, 25) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont systemFontOfSize:15] text:@"取消大额充值申请?"];
    [viewChoose addSubview:labelCancle];
    
    UIButton *bCancle = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(10, viewHeight/2 + 10, (viewWidth - 30)/2, HEIGHT_CONTROLLER_DEFAULT * (40.0 / 667.0)) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"取消"];
    [viewChoose addSubview:bCancle];
    bCancle.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [bCancle setBackgroundImage:[UIImage imageNamed:@"蓝色完成"] forState:UIControlStateNormal];
    [bCancle setBackgroundImage:[UIImage imageNamed:@"蓝色完成"] forState:UIControlStateHighlighted];
    [bCancle addTarget:self action:@selector(buttonChooseDisappear:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonOK = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(20 + (viewWidth - 30)/2, viewHeight/2 + 10, (viewWidth - 30)/2, HEIGHT_CONTROLLER_DEFAULT * (40.0 / 667.0)) backgroundColor:[UIColor whiteColor] textColor:[UIColor chongzhiColor] titleText:@"确认"];
    [viewChoose addSubview:buttonOK];
    buttonOK.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonOK setBackgroundImage:[UIImage imageNamed:@"蓝框"] forState:UIControlStateNormal];
    [buttonOK setBackgroundImage:[UIImage imageNamed:@"蓝框"] forState:UIControlStateHighlighted];
    [buttonOK addTarget:self action:@selector(buttonMakeSureCancle:) forControlEvents:UIControlEventTouchUpInside];

}

//完成按钮
- (void)finishApplyButton:(UIButton *)button
{
    NSArray *viewControllers = [self.navigationController viewControllers];
    [self.navigationController popToViewController:[viewControllers objectAtIndex:1] animated:YES];
}

//黑色遮罩取消
- (void)buttonChooseDisappear:(UIButton *)button
{
    [buttonHei removeFromSuperview];
    [viewChoose removeFromSuperview];
    
    buttonHei = nil;
    viewChoose = nil;
}

//确认取消按钮
- (void)buttonMakeSureCancle:(UIButton *)button
{
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    NSDictionary *paramter = @{@"id":self.ID, @"token":[dic objectForKey:@"token"]};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/cancelBigPutOn" parameters:paramter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"ffffffffff%@", responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            NSArray *viewControllers = [self.navigationController viewControllers];
            [self.navigationController popToViewController:[viewControllers objectAtIndex:1] animated:YES];
            
            // 刷新我的账户数据
            [[NSNotificationCenter defaultCenter] postNotificationName:@"exchangeWithImageView" object:nil];
            
        } else {
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark 网络请求方法
#pragma mark --------------------------------
- (void)getData
{
    NSLog(@"2:%@", self.ID);
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    NSDictionary *parameter = @{@"id":self.ID, @"token":[dic objectForKey:@"token"]};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/getBigPutOnInfo" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"大额申请详情:hhhhhh%@", responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            NSDictionary *dataDic = [responseObject objectForKey:@"BigPutOn"];
            applySch = [[ApplySchedule alloc] init];
            [applySch setValuesForKeysWithDictionary:dataDic];
            NSLog(@"id:%@", applySch.Id);
            [dataArray addObject:applySch];
            
            [self contentShow];
        }
        
        NSLog(@"asdasd==%@", dataArray);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [buttonHei removeFromSuperview];
    [viewChoose removeFromSuperview];
    
    buttonHei = nil;
    viewChoose = nil;
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
