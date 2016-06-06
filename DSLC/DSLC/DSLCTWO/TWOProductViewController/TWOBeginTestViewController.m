//
//  TWOTestOneViewController.m
//  DSLC
//
//  Created by ios on 16/5/24.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOBeginTestViewController.h"
#import "TWOTestOneViewController.h"

@interface TWOBeginTestViewController ()

@end

@implementation TWOBeginTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"安全测评"];
    
    [self contentShow];
}

- (void)contentShow
{
    UIImageView *imageBackGround = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"background"]];
    [self.view addSubview:imageBackGround];
    imageBackGround.userInteractionEnabled = YES;
    
    UIImageView *imageHead = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 70.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, 60.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 140.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, 140.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"monkeyHead"]];
    [imageBackGround addSubview:imageHead];
    
    UILabel *labelContent = [CreatView creatWithLabelFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 130, 60.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 140.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT + 60.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 260, 90) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"投资有风险, 理财需谨慎。安全测评, 多\n一分谨慎, 少一分风险; 多一分了解, 少\n一分损失。"];
    [imageBackGround addSubview:labelContent];
    labelContent.numberOfLines = 3;
    
    UIButton *butBegin = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 130, 60.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 140.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT + 60.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 90 + 80.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 260, 40) backgroundColor:[UIColor clearColor] textColor:[UIColor profitColor] titleText:@"开始测评吧"];
    [imageBackGround addSubview:butBegin];
    butBegin.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    butBegin.layer.cornerRadius = 20;
    butBegin.layer.masksToBounds = YES;
    butBegin.layer.borderColor = [[UIColor profitColor] CGColor];
    butBegin.layer.borderWidth = 1.5;
    [butBegin addTarget:self action:@selector(buttonBeginTest:) forControlEvents:UIControlEventTouchUpInside];
    
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
        butBegin.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 130, 60.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 140.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT + 60.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 90 + 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 260, 40);
    }
}

- (void)buttonBeginTest:(UIButton *)button
{
    TWOTestOneViewController *testOneVC = [[TWOTestOneViewController alloc] init];
    pushVC(testOneVC);
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
