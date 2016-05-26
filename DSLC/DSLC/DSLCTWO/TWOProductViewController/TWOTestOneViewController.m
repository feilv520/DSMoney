//
//  TWOTestOneViewController.m
//  DSLC
//
//  Created by ios on 16/5/24.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOTestOneViewController.h"
#import "TWOTestTwoViewController.h"

@interface TWOTestOneViewController ()

{
    UIButton *buttonOne;
    UIButton *buttonTwo;
    UIButton *buttonThree;
    UIButton *buttonFour;
    UIImageView *imageGou;
    TWOTestTwoViewController *testTwoVC;
}

@end

@implementation TWOTestOneViewController

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

    UILabel *labelQuestion = [CreatView creatWithLabelFrame:CGRectMake(0, 96.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT, 50) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:17] text:@"在您每年的家庭收入中,可用于金融\n投资(储蓄存款除外)的比例为？"];
    [imageBackGround addSubview:labelQuestion];
    labelQuestion.numberOfLines = 2;
    
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
        labelQuestion.frame = CGRectMake(0, 46.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT, 50);
    }
    
    CGFloat jianJu4s = 46.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20);
    
    CGFloat yuanWidth = (WIDTH_CONTROLLER_DEFAULT - 32.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT*2 - 43.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT)/2;
    
    buttonOne = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(32.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, 96.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 50 + 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), yuanWidth, yuanWidth) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"小于10%"];
    [imageBackGround addSubview:buttonOne];
    [self changeButtonYuanDu:buttonOne];
    buttonOne.tag = 1;
    [buttonOne addTarget:self action:@selector(buttonOne:) forControlEvents:UIControlEventTouchUpInside];
    
    buttonTwo = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(32.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT + 43.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT + yuanWidth, 96.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 50 + 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), yuanWidth, yuanWidth) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"10%至25%"];
    [imageBackGround addSubview:buttonTwo];
    [self changeButtonYuanDu:buttonTwo];
    buttonTwo.tag = 2;
    [buttonTwo addTarget:self action:@selector(buttonTwo:) forControlEvents:UIControlEventTouchUpInside];
    
    buttonThree = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(32.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, 96.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 50 + 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + yuanWidth + 40.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), yuanWidth, yuanWidth) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"25%至50%"];
    [imageBackGround addSubview:buttonThree];
    [self changeButtonYuanDu:buttonThree];
    buttonThree.tag = 3;
    [buttonThree addTarget:self action:@selector(buttonThree:) forControlEvents:UIControlEventTouchUpInside];
    
    buttonFour = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(32.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT + 43.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT + yuanWidth, 96.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 50 + 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + yuanWidth + 40.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), yuanWidth, yuanWidth) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"大于50%"];
    [imageBackGround addSubview:buttonFour];
    [self changeButtonYuanDu:buttonFour];
    buttonFour.tag = 4;
    [buttonFour addTarget:self action:@selector(buttonFour:) forControlEvents:UIControlEventTouchUpInside];
    
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
        buttonOne.frame = CGRectMake(32.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, jianJu4s + 50 + 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), yuanWidth, yuanWidth);
        buttonTwo.frame = CGRectMake(32.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT + 43.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT + yuanWidth, jianJu4s + 50 + 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), yuanWidth, yuanWidth);
        buttonThree.frame = CGRectMake(32.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, jianJu4s + 50 + 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + yuanWidth + 40.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), yuanWidth, yuanWidth);
        buttonFour.frame = CGRectMake(32.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT + 43.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT + yuanWidth, jianJu4s + 50 + 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + yuanWidth + 40.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), yuanWidth, yuanWidth);
    }
    
    imageGou = [CreatView creatImageViewWithFrame:CGRectMake(yuanWidth/2 - 18, yuanWidth/2 + 13, 36, 36) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"bluegou"]];
    testTwoVC = [[TWOTestTwoViewController alloc] init];
}

- (void)buttonOne:(UIButton *)button
{
    [imageGou removeFromSuperview];
    
    buttonTwo.layer.borderColor = [[UIColor whiteColor] CGColor];
    [buttonTwo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    buttonThree.layer.borderColor = [[UIColor whiteColor] CGColor];
    [buttonThree setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    buttonFour.layer.borderColor = [[UIColor whiteColor] CGColor];
    [buttonFour setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [buttonOne addSubview:imageGou];
    buttonOne.layer.borderColor = [[UIColor profitColor] CGColor];
    [buttonOne setTitleColor:[UIColor profitColor] forState:UIControlStateNormal];
    testTwoVC.scoreOne = 2;
    pushVC(testTwoVC);
}

- (void)buttonTwo:(UIButton *)button
{
    [imageGou removeFromSuperview];
    
    buttonOne.layer.borderColor = [[UIColor whiteColor] CGColor];
    [buttonOne setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    buttonThree.layer.borderColor = [[UIColor whiteColor] CGColor];
    [buttonThree setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    buttonFour.layer.borderColor = [[UIColor whiteColor] CGColor];
    [buttonFour setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    buttonTwo.layer.borderColor = [[UIColor profitColor] CGColor];
    [buttonTwo setTitleColor:[UIColor profitColor] forState:UIControlStateNormal];
    [buttonTwo addSubview:imageGou];
    testTwoVC.scoreOne = 4;
    pushVC(testTwoVC);
}

- (void)buttonThree:(UIButton *)button
{
    [imageGou removeFromSuperview];
    
    buttonOne.layer.borderColor = [[UIColor whiteColor] CGColor];
    [buttonOne setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    buttonTwo.layer.borderColor = [[UIColor whiteColor] CGColor];
    [buttonTwo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    buttonFour.layer.borderColor = [[UIColor whiteColor] CGColor];
    [buttonFour setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    buttonThree.layer.borderColor = [[UIColor profitColor] CGColor];
    [buttonThree setTitleColor:[UIColor profitColor] forState:UIControlStateNormal];
    [buttonThree addSubview:imageGou];
    testTwoVC.scoreOne = 8;
    pushVC(testTwoVC);
}

- (void)buttonFour:(UIButton *)button
{
    [imageGou removeFromSuperview];
    
    buttonOne.layer.borderColor = [[UIColor whiteColor] CGColor];
    [buttonOne setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    buttonThree.layer.borderColor = [[UIColor whiteColor] CGColor];
    [buttonThree setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    buttonTwo.layer.borderColor = [[UIColor whiteColor] CGColor];
    [buttonTwo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    buttonFour.layer.borderColor = [[UIColor profitColor] CGColor];
    [buttonFour setTitleColor:[UIColor profitColor] forState:UIControlStateNormal];
    [buttonFour addSubview:imageGou];
    testTwoVC.scoreOne = 10;
    pushVC(testTwoVC);
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
