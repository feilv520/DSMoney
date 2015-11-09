//
//  ApplyScheduleViewController.m
//  DSLC
//
//  Created by ios on 15/11/9.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "ApplyScheduleViewController.h"

@interface ApplyScheduleViewController ()

{
    NSArray *contentArr;
}

@end

@implementation ApplyScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor huibai];
    [self.navigationItem setTitle:@"申请进度"];
    
    [self contentShow];
}

- (void)contentShow
{
    contentArr = @[@"大额转账申请已提交", @"请去银行转账后,提供银行转账流水单号", @"财务待审", @"充值成功"];
    
    UIView *viewWhite = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT / 2) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewWhite];
    
    UILabel *labelLine = [CreatView creatWithLabelFrame:CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT/2 - 0.5, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor] textColor:nil textAlignment:NSTextAlignmentCenter textFont:nil text:nil];
    [viewWhite addSubview:labelLine];
    labelLine.alpha = 0.2;
    
    CGFloat viewHeight = viewWhite.frame.size.height;
    
    UIImageView *imageSchedule = [CreatView creatImageViewWithFrame:CGRectMake(18, 20, 16, viewHeight - 40) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"流程"]];
    [viewWhite addSubview:imageSchedule];
    
    for (int i = 0; i < 4; i++) {
        
        UILabel *label = [CreatView creatWithLabelFrame:CGRectMake(40, 20 + 20 * i + 75 * i, WIDTH_CONTROLLER_DEFAULT/2, 20) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:[contentArr objectAtIndex:i]];
        [viewWhite addSubview:label];
        
        if (i == 0) {
            
            label.textColor = [UIColor chongzhiColor];
        }
        
        if (i == 1) {
            
            label.frame = CGRectMake(40, 115, WIDTH_CONTROLLER_DEFAULT - 50, 20);
        }
    }
    
    UILabel *labelTime = [CreatView creatWithLabelFrame:CGRectMake(40, 45, WIDTH_CONTROLLER_DEFAULT/2, 20) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:@"2015-10-09 12:00"];
    [viewWhite addSubview:labelTime];
    
    UIButton *butEdit = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - WIDTH_CONTROLLER_DEFAULT/4 - 15, 22, WIDTH_CONTROLLER_DEFAULT/4, 35) backgroundColor:[UIColor whiteColor] textColor:[UIColor daohanglan] titleText:@"编辑"];
    [viewWhite addSubview:butEdit];
    butEdit.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    [butEdit setBackgroundImage:[UIImage imageNamed:@"红框"] forState:UIControlStateNormal];
    [butEdit addTarget:self action:@selector(buttonEdit:) forControlEvents:UIControlEventTouchUpInside];
    
    UITextField *fieldShuRu = [CreatView creatWithfFrame:CGRectMake(40, 140, WIDTH_CONTROLLER_DEFAULT/3 * 2 - 30, 35) setPlaceholder:@"银行转账流水号" setTintColor:[UIColor grayColor]];
    [viewWhite addSubview:fieldShuRu];
    fieldShuRu.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 35)];
    fieldShuRu.leftViewMode = UITextFieldViewModeAlways;
    fieldShuRu.textColor = [UIColor zitihui];
    fieldShuRu.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    fieldShuRu.backgroundColor = [UIColor shurukuangColor];
    fieldShuRu.layer.cornerRadius = 5;
    fieldShuRu.layer.masksToBounds = YES;
    fieldShuRu.layer.borderColor = [[UIColor shurukuangBian] CGColor];
    fieldShuRu.layer.borderWidth = 0.5;
    [fieldShuRu addTarget:self action:@selector(textFieldEditApply:) forControlEvents:UIControlEventEditingChanged];
    
    UIButton *butSubmit = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40 +  WIDTH_CONTROLLER_DEFAULT/3 * 2 - 30 + 10, 140, WIDTH_CONTROLLER_DEFAULT - 40 - (WIDTH_CONTROLLER_DEFAULT/3 * 2 - 30) - 15 - 10, 35) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"提交"];
    [viewWhite addSubview:butSubmit];
    butSubmit.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    [butSubmit setBackgroundImage:[UIImage imageNamed:@"蓝色完成"] forState:UIControlStateNormal];
    butSubmit.layer.cornerRadius = 4;
    butSubmit.layer.masksToBounds = YES;
}

//编辑
- (void)buttonEdit:(UIButton *)button
{
    NSLog(@"编辑");
}

- (void)textFieldEditApply:(UITextField *)textField
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
