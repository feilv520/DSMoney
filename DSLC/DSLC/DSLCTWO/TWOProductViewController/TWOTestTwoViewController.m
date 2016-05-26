//
//  TWOTestTwoViewController.m
//  DSLC
//
//  Created by ios on 16/5/24.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOTestTwoViewController.h"
#import "TWOTestThreeViewController.h"

@interface TWOTestTwoViewController ()

{
    UIButton *buttonOne;
    UIButton *buttonTwo;
    UIButton *buttonThree;
    UIImageView *imageViewGou;
    TWOTestThreeViewController *testThreeVC;
}

@end

@implementation TWOTestTwoViewController

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
    
    UILabel *labelQuestion = [CreatView creatWithLabelFrame:CGRectMake(0, 80.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT, 50) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:17] text:@"您的投资目的是？"];
    [imageBackGround addSubview:labelQuestion];
    
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
        labelQuestion.frame = CGRectMake(0, 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT, 50);
    }
    
    CGFloat yuanWidth = (WIDTH_CONTROLLER_DEFAULT - 32.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT*2 - 43.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT)/2;
    CGFloat jianJu = 80.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20);
    CGFloat jianju4 = 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20);
    
    buttonOne = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(32.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, jianJu + 50 + 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), yuanWidth, yuanWidth) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"资产保值\n      +\n固定收益"];
    [imageBackGround addSubview:buttonOne];
    [self changeButtonYuanDu:buttonOne];
    buttonOne.titleLabel.numberOfLines = 3;
    [buttonOne addTarget:self action:@selector(buttonOne:) forControlEvents:UIControlEventTouchUpInside];
    
    buttonTwo = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(32.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT + 43.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT + yuanWidth, jianJu + 50 + 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), yuanWidth, yuanWidth) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"资产稳健增长\n          +\n    浮动收益"];
    [imageBackGround addSubview:buttonTwo];
    [self changeButtonYuanDu:buttonTwo];
    buttonTwo.titleLabel.numberOfLines = 3;
    [buttonTwo addTarget:self action:@selector(buttonTwo:) forControlEvents:UIControlEventTouchUpInside];
    
    buttonThree = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - yuanWidth/2, jianJu + 50 + 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + yuanWidth + 40.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), yuanWidth, yuanWidth) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"    资产高回报\n            +\n能接受资产波动"];
    [imageBackGround addSubview:buttonThree];
    [self changeButtonYuanDu:buttonThree];
    buttonThree.titleLabel.numberOfLines = 0;
    [buttonThree addTarget:self action:@selector(buttonThree:) forControlEvents:UIControlEventTouchUpInside];
    
    if (WIDTH_CONTROLLER_DEFAULT == 320) {
        buttonOne.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        buttonTwo.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        buttonThree.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    }
    
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
        buttonOne.frame = CGRectMake(32.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, jianju4 + 50 + 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), yuanWidth, yuanWidth);
        buttonTwo.frame = CGRectMake(32.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT + 43.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT + yuanWidth, jianju4 + 50 + 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), yuanWidth, yuanWidth);
        buttonThree.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - yuanWidth/2, jianju4 + 50 + 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + yuanWidth + 40.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), yuanWidth, yuanWidth);
    }
    
    imageViewGou = [CreatView creatImageViewWithFrame:CGRectMake(yuanWidth/2 - 18, yuanWidth - 40, 36, 36) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"bluegou"]];
    testThreeVC = [[TWOTestThreeViewController alloc] init];
}

- (void)buttonOne:(UIButton *)button
{
    [imageViewGou removeFromSuperview];
    
    
    buttonTwo.layer.borderColor = [[UIColor whiteColor] CGColor];
    [buttonTwo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    buttonThree.layer.borderColor = [[UIColor whiteColor] CGColor];
    [buttonThree setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [buttonOne addSubview:imageViewGou];
    buttonOne.layer.borderColor = [[UIColor profitColor] CGColor];
    [buttonOne setTitleColor:[UIColor profitColor] forState:UIControlStateNormal];
    testThreeVC.scoreTwo = self.scoreOne + 2;
    pushVC(testThreeVC);
}

- (void)buttonTwo:(UIButton *)button
{
    [imageViewGou removeFromSuperview];
    
    buttonOne.layer.borderColor = [[UIColor whiteColor] CGColor];
    [buttonOne setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    buttonThree.layer.borderColor = [[UIColor whiteColor] CGColor];
    [buttonThree setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    buttonTwo.layer.borderColor = [[UIColor profitColor] CGColor];
    [buttonTwo setTitleColor:[UIColor profitColor] forState:UIControlStateNormal];
    [buttonTwo addSubview:imageViewGou];
    testThreeVC.scoreTwo = self.scoreOne + 6;
    pushVC(testThreeVC);
}

- (void)buttonThree:(UIButton *)button
{
    [imageViewGou removeFromSuperview];
    
    buttonOne.layer.borderColor = [[UIColor whiteColor] CGColor];
    [buttonOne setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    buttonTwo.layer.borderColor = [[UIColor whiteColor] CGColor];
    [buttonTwo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    buttonThree.layer.borderColor = [[UIColor profitColor] CGColor];
    [buttonThree setTitleColor:[UIColor profitColor] forState:UIControlStateNormal];
    [buttonThree addSubview:imageViewGou];
    testThreeVC.scoreTwo = self.scoreOne + 10;
    pushVC(testThreeVC);
}

//封装button的圆度
- (void)changeButtonYuanDu:(UIButton *)button
{
    button.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:17];
    button.layer.cornerRadius = (WIDTH_CONTROLLER_DEFAULT - 32.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT*2 - 43.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT)/2/2;
    button.layer.masksToBounds = YES;
    button.layer.borderColor = [[UIColor whiteColor] CGColor];
    button.layer.borderWidth = 2;
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
