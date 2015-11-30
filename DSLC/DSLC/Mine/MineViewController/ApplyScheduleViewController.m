//
//  ApplyScheduleViewController.m
//  DSLC
//
//  Created by ios on 15/11/9.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "ApplyScheduleViewController.h"
#import "EditBigMoney.h"

@interface ApplyScheduleViewController () <UITextFieldDelegate>

{
    NSArray *contentArr;
    UIButton *buttonHei;
    UIView *viewChoose;
    
    UIView *viewWhite;
    UIImageView *imageSchedule;
    UITextField *fieldShuRu;
    UIButton *butEdit;
    UIButton *butSubmit;
    UIButton *buttCancle;
    UIButton *butFinish;
    
    UILabel *labelTwo;
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
    
    [self contentShow];
}

- (void)contentShow
{
    contentArr = @[@"已提交申请", @"请在打款后,提供转账/POS单号", @"财务待审", @"充值成功"];
    
    viewWhite = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT / 2) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewWhite];
    
    UILabel *labelLine = [CreatView creatWithLabelFrame:CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT/2 - 0.5, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor] textColor:nil textAlignment:NSTextAlignmentCenter textFont:nil text:nil];
    [viewWhite addSubview:labelLine];
    labelLine.alpha = 0.2;
    
    CGFloat viewHeight = viewWhite.frame.size.height;
    
    imageSchedule = [CreatView creatImageViewWithFrame:CGRectMake(18, 20, 14, viewHeight - 40) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"流程"]];
    [viewWhite addSubview:imageSchedule];
    
    if (HEIGHT_CONTROLLER_DEFAULT == 480 + 20) {
        
        for (int i = 0; i < 4; i++) {
            
            UILabel *label = [CreatView creatWithLabelFrame:CGRectMake(40, 20 + 20 * i + 50 * i, WIDTH_CONTROLLER_DEFAULT/2, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:[contentArr objectAtIndex:i]];
            [viewWhite addSubview:label];
            label.tag = 2000 + i;
            
            if (i == 0) {
                
                label.textColor = [UIColor chongzhiColor];
            }
            
            if (i == 1) {
                
                label.frame = CGRectMake(40, 83, WIDTH_CONTROLLER_DEFAULT - 50, 20);
            }
            
            if (i == 2) {
                label.frame = CGRectMake(40, 150, WIDTH_CONTROLLER_DEFAULT/2, 20);
            }
            
            if (i == 3) {
                label.frame = CGRectMake(40, 215, WIDTH_CONTROLLER_DEFAULT/2, 20);
            }
        }
        
    } else if (HEIGHT_CONTROLLER_DEFAULT == 568 + 20) {
        
        for (int i = 0; i < 4; i++) {
            
            UILabel *label = [CreatView creatWithLabelFrame:CGRectMake(40, 20 + 20 * i + 60 * i, WIDTH_CONTROLLER_DEFAULT/2, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:[contentArr objectAtIndex:i]];
            [viewWhite addSubview:label];
            label.tag = 2000 + i;
            
            if (i == 0) {
                
                label.textColor = [UIColor chongzhiColor];
            }
            
            if (i == 1) {
                
                label.frame = CGRectMake(40, 98, WIDTH_CONTROLLER_DEFAULT - 50, 20);
            }
            
        }

    } else {
        
        for (int i = 0; i < 4; i++) {
            
            UILabel *label = [CreatView creatWithLabelFrame:CGRectMake(40, 20 + 20 * i + 75 * i, WIDTH_CONTROLLER_DEFAULT/2, 20) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:[contentArr objectAtIndex:i]];
            [viewWhite addSubview:label];
            label.tag = 2000 + i;
            
            if (i == 0) {
                
                label.textColor = [UIColor chongzhiColor];
            }
            
            if (i == 1) {
                
                label.frame = CGRectMake(40, 115, WIDTH_CONTROLLER_DEFAULT - 50, 20);
            }
            
        }

    }
    
    
    UILabel *labelTime = [CreatView creatWithLabelFrame:CGRectMake(40, 45, WIDTH_CONTROLLER_DEFAULT/2, 20) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:@"2015-10-09 12:00"];
    [viewWhite addSubview:labelTime];
    
    butEdit = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - WIDTH_CONTROLLER_DEFAULT/4 - 15, 22, WIDTH_CONTROLLER_DEFAULT/4, 35) backgroundColor:[UIColor whiteColor] textColor:[UIColor daohanglan] titleText:@"编辑"];
    [viewWhite addSubview:butEdit];
    butEdit.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    [butEdit setBackgroundImage:[UIImage imageNamed:@"红框"] forState:UIControlStateNormal];
    [butEdit setBackgroundImage:[UIImage imageNamed:@"红框"] forState:UIControlStateHighlighted];
    [butEdit addTarget:self action:@selector(buttonEdit:) forControlEvents:UIControlEventTouchUpInside];
    
    if (HEIGHT_CONTROLLER_DEFAULT == 480 + 20) {
        
        fieldShuRu = [CreatView creatWithfFrame:CGRectMake(40, 120, WIDTH_CONTROLLER_DEFAULT/3 * 2 - 30, 35) setPlaceholder:nil setTintColor:[UIColor grayColor]];
        
        butSubmit = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40 +  WIDTH_CONTROLLER_DEFAULT/3 * 2 - 30 + 10, 110, WIDTH_CONTROLLER_DEFAULT - 40 - (WIDTH_CONTROLLER_DEFAULT/3 * 2 - 30) - 15 - 10, 35) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"提交"];
        
    } else if (HEIGHT_CONTROLLER_DEFAULT == 568 + 20) {
        
        fieldShuRu = [CreatView creatWithfFrame:CGRectMake(40, 125, WIDTH_CONTROLLER_DEFAULT/3 * 2 - 30, 35) setPlaceholder:nil setTintColor:[UIColor grayColor]];
        
        butSubmit = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40 +  WIDTH_CONTROLLER_DEFAULT/3 * 2 - 30 + 10, 125, WIDTH_CONTROLLER_DEFAULT - 40 - (WIDTH_CONTROLLER_DEFAULT/3 * 2 - 30) - 15 - 10, 35) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"提交"];
    } else {
        
        fieldShuRu = [CreatView creatWithfFrame:CGRectMake(40, 150, WIDTH_CONTROLLER_DEFAULT/3 * 2 - 30, 35) setPlaceholder:nil setTintColor:[UIColor grayColor]];
        
        butSubmit = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40 +  WIDTH_CONTROLLER_DEFAULT/3 * 2 - 30 + 10, 150, WIDTH_CONTROLLER_DEFAULT - 40 - (WIDTH_CONTROLLER_DEFAULT/3 * 2 - 30) - 15 - 10, 35) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"提交"];
    }
    [viewWhite addSubview:fieldShuRu];
    fieldShuRu.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 35)];
    fieldShuRu.delegate = self;
    fieldShuRu.leftViewMode = UITextFieldViewModeAlways;
    fieldShuRu.textColor = [UIColor zitihui];
    fieldShuRu.keyboardType = UIKeyboardTypeNumberPad;
    fieldShuRu.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    fieldShuRu.backgroundColor = [UIColor shurukuangColor];
    fieldShuRu.layer.cornerRadius = 5;
    fieldShuRu.layer.masksToBounds = YES;
    fieldShuRu.layer.borderColor = [[UIColor shurukuangBian] CGColor];
    fieldShuRu.layer.borderWidth = 0.5;
    [fieldShuRu addTarget:self action:@selector(textFieldEditApply:) forControlEvents:UIControlEventEditingChanged];
    
    [viewWhite addSubview:butSubmit];
    butSubmit.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    [butSubmit setBackgroundImage:[UIImage imageNamed:@"蓝色完成"] forState:UIControlStateNormal];
    [butSubmit setBackgroundImage:[UIImage imageNamed:@"蓝色完成"] forState:UIControlStateHighlighted];
    butSubmit.layer.cornerRadius = 4;
    butSubmit.layer.masksToBounds = YES;
    [butSubmit addTarget:self action:@selector(submitButton:) forControlEvents:UIControlEventTouchUpInside];
    
    buttCancle = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(17, HEIGHT_CONTROLLER_DEFAULT/2 + 50, (WIDTH_CONTROLLER_DEFAULT - 34 - 16)/2, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor chongzhiColor] titleText:@"取消申请"];
    [self.view addSubview:buttCancle];
    buttCancle.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttCancle setBackgroundImage:[UIImage imageNamed:@"蓝框"] forState:UIControlStateNormal];
    [buttCancle setBackgroundImage:[UIImage imageNamed:@"蓝框"] forState:UIControlStateHighlighted];
    [buttCancle addTarget:self action:@selector(cancleApplyButton:) forControlEvents:UIControlEventTouchUpInside];
    
    butFinish = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(33 + (WIDTH_CONTROLLER_DEFAULT - 34 - 16)/2, HEIGHT_CONTROLLER_DEFAULT/2 + 50, (WIDTH_CONTROLLER_DEFAULT - 34 - 16)/2, 40) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"完成"];
    [self.view addSubview:butFinish];
    butFinish.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butFinish setBackgroundImage:[UIImage imageNamed:@"蓝色完成"] forState:UIControlStateNormal];
    [butFinish setBackgroundImage:[UIImage imageNamed:@"蓝色完成"] forState:UIControlStateHighlighted];
    [butFinish addTarget:self action:@selector(finishApplyButton:) forControlEvents:UIControlEventTouchUpInside];
}

//编辑
- (void)buttonEdit:(UIButton *)button
{
    EditBigMoney *money = [[EditBigMoney alloc] init];
    [self.navigationController pushViewController:money animated:YES];
}

//提交按钮
- (void)submitButton:(UIButton *)button
{
    if (fieldShuRu.text.length == 6) {
        
        [self.view endEditing:YES];
        
        butEdit.hidden = YES;
        butSubmit.hidden = YES;
        fieldShuRu.hidden = YES;
        buttCancle.hidden = YES;
        butFinish.hidden = YES;
        
        UILabel *labelTime = [CreatView creatWithLabelFrame:CGRectMake(40, 140, WIDTH_CONTROLLER_DEFAULT/3 * 2 - 30, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:@"2015-09-10 12:00"];
        [viewWhite addSubview:labelTime];
        
        UIButton *buttWell = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT / 2 + 60, WIDTH_CONTROLLER_DEFAULT, 50) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] titleText:@" 转账/POS单号已经提交成功,\n 我们将在24小时内进行核实!"];
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
    NSArray *viewControllers = [self.navigationController viewControllers];
    [self.navigationController popToViewController:[viewControllers objectAtIndex:1] animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
