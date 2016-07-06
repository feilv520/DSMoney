//
//  TWONoRealNameViewController.m
//  DSLC
//
//  Created by ios on 16/5/16.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWONoRealNameViewController.h"
#import "TWORealNameH5ViewController.h"

@interface TWONoRealNameViewController ()

@end

@implementation TWONoRealNameViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = [UIColor profitColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"实名认证"];
    
    [self contentShow];
}

- (void)contentShow
{
    UIImageView *imagePic = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 261/2.5/2, 15, 261/2.5, 315/2.5) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"noRealName"]];
    [self.view addSubview:imagePic];
    
    UILabel *labelWenZi = [CreatView creatWithLabelFrame:CGRectMake(0, 150, WIDTH_CONTROLLER_DEFAULT, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor ZiTiColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"您还未实名认证,\n实名认证后才可以投资哦"];
    [self.view addSubview:labelWenZi];
    labelWenZi.numberOfLines = 2;
    
//    认证按钮
    UIButton *butAttestation = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(10, imagePic.frame.size.height + 20 + labelWenZi.frame.size.height + 30, WIDTH_CONTROLLER_DEFAULT - 20, 40) backgroundColor:[UIColor profitColor] textColor:[UIColor whiteColor] titleText:@"认证"];
    [self.view addSubview:butAttestation];
    butAttestation.layer.cornerRadius = 5;
    butAttestation.layer.masksToBounds = YES;
    butAttestation.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butAttestation addTarget:self action:@selector(buttonRealNameAttestation:) forControlEvents:UIControlEventTouchUpInside];
}

//认证按钮
- (void)buttonRealNameAttestation:(UIButton *)button
{
    TWORealNameH5ViewController *realNameVC = [[TWORealNameH5ViewController alloc] init];
    pushVC(realNameVC);
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
