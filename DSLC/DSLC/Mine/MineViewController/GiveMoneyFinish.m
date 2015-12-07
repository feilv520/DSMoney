//
//  GiveMoneyFinish.m
//  DSLC
//
//  Created by ios on 15/11/11.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "GiveMoneyFinish.h"

@interface GiveMoneyFinish ()

{
    NSArray *labelName;
}

@end

@implementation GiveMoneyFinish

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor huibai];
    [self.navigationItem setTitle:@"支付完成"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishReturn:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:14], NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    [self contentShow];
}

- (void)contentShow
{
    UIButton *buttonOk = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 35, WIDTH_CONTROLLER_DEFAULT, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] titleText:@" 充值成功"];
    [self.view addSubview:buttonOk];
    buttonOk.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonOk setImage:[UIImage imageNamed:@"iconfont_complete"] forState:UIControlStateNormal];
    
    UIView *viewWhite = [CreatView creatViewWithFrame:CGRectMake(30, 95, WIDTH_CONTROLLER_DEFAULT - 60, 100) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewWhite];
    viewWhite.layer.cornerRadius = 4;
    viewWhite.layer.masksToBounds = YES;
    viewWhite.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    viewWhite.layer.borderWidth = 0.3;
    
    CGFloat viewWidth = viewWhite.frame.size.width;
    
    UILabel *labelLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 49.8, viewWidth, 0.3)];
    [viewWhite addSubview:labelLine];
    labelLine.backgroundColor = [UIColor lightGrayColor];
    labelLine.alpha = 0.7;
    
    labelName = @[@"充值金额", @"银行卡"];
    
    for (int i = 0; i < 2; i++) {
        
        UILabel *labelTitle = [CreatView creatWithLabelFrame:CGRectMake(10, 10 + 30 * i + 20 * i, (viewWidth - 20)/2, 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:[labelName objectAtIndex:i]];
        [viewWhite addSubview:labelTitle];
    }
    
    UILabel *labelMoney = [CreatView creatWithLabelFrame:CGRectMake((viewWidth - 20)/2 + 10, 10, (viewWidth - 20)/2, 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentRight textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"$1"];
    [viewWhite addSubview:labelMoney];
    
    UILabel *labelTailNum = [CreatView creatWithLabelFrame:CGRectMake((viewWidth - 20)/2 + 10, 60, (viewWidth - 20)/2, 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentRight textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"尾号9988"];
    [viewWhite addSubview:labelTailNum];
    
    UIButton *buttonGo = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 255, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"去赚钱"];
    [self.view addSubview:buttonGo];
    buttonGo.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonGo setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
    [buttonGo setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
    [buttonGo addTarget:self action:@selector(buttonGoToGetMoney:) forControlEvents:UIControlEventTouchUpInside];
}

//去赚钱按钮
- (void)buttonGoToGetMoney:(UIButton *)button
{
    NSLog(@"充值");
    
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

- (void)finishReturn:(UIBarButtonItem *)bar
{
    NSArray *viewController = [self.navigationController viewControllers];
    [self.navigationController popToViewController:[viewController objectAtIndex:1] animated:YES];
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
