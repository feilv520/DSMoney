//
//  TWOTestFourViewController.m
//  DSLC
//
//  Created by ios on 16/5/24.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOTestFourViewController.h"
#import "TWOTestFiveViewController.h"

@interface TWOTestFourViewController ()

{
    UIButton *buttonOne;
    UIButton *buttonTwo;
    UIButton *buttonThree;
    UIButton *buttonFour;
    UIImageView *imageGou;
    TWOTestFiveViewController *testFiveVC;
}

@end

@implementation TWOTestFourViewController

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
    
    UILabel *labelQuestion = [CreatView creatWithLabelFrame:CGRectMake(0, 80.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT, 50) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:17] text:@"您的投资态度是？"];
    [imageBackGround addSubview:labelQuestion];
    
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
        labelQuestion.frame = CGRectMake(0, 46.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT, 50);
    }
    
    CGFloat juLi4 = 46.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20);
    CGFloat yuanWidth = (WIDTH_CONTROLLER_DEFAULT - 32.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT*2 - 43.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT)/2;
    
    buttonOne = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(32.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, 80.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 50 + 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), yuanWidth, yuanWidth) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"本金不赔\n稳定收益"];
    [imageBackGround addSubview:buttonOne];
    [self changeButtonYuanDu:buttonOne];
    buttonOne.titleLabel.numberOfLines = 2;
    [buttonOne addTarget:self action:@selector(buttonOne:) forControlEvents:UIControlEventTouchUpInside];
    
    buttonTwo = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(32.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT + 43.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT + yuanWidth, 80.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 50 + 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), yuanWidth, yuanWidth) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"本金不赔\n浮动收益"];
    [imageBackGround addSubview:buttonTwo];
    [self changeButtonYuanDu:buttonTwo];
    buttonTwo.titleLabel.numberOfLines = 2;
    [buttonTwo addTarget:self action:@selector(buttonTwo:) forControlEvents:UIControlEventTouchUpInside];
    
    buttonThree = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(32.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, 80.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 50 + 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + yuanWidth + 40.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), yuanWidth, yuanWidth) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"      高收益\n有限本金浮动"];
    [imageBackGround addSubview:buttonThree];
    [self changeButtonYuanDu:buttonThree];
    buttonThree.titleLabel.numberOfLines = 2;
    [buttonThree addTarget:self action:@selector(buttonThree:) forControlEvents:UIControlEventTouchUpInside];
    
    buttonFour = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(32.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT + 43.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT + yuanWidth, 80.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 50 + 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + yuanWidth + 40.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), yuanWidth, yuanWidth) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"      高收益\n较大本金浮动"];
    [imageBackGround addSubview:buttonFour];
    [self changeButtonYuanDu:buttonFour];
    buttonFour.titleLabel.numberOfLines = 2;
    [buttonFour addTarget:self action:@selector(buttonFour:) forControlEvents:UIControlEventTouchUpInside];
    
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
        buttonOne.frame = CGRectMake(32.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, juLi4 + 50 + 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), yuanWidth, yuanWidth);
        buttonTwo.frame = CGRectMake(32.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT + 43.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT + yuanWidth, juLi4 + 50 + 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), yuanWidth, yuanWidth);
        buttonThree.frame = CGRectMake(32.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, juLi4 + 50 + 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + yuanWidth + 40.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), yuanWidth, yuanWidth);
        buttonFour.frame = CGRectMake(32.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT + 43.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT + yuanWidth, juLi4 + 50 + 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + yuanWidth + 40.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), yuanWidth, yuanWidth);
    }
    
    imageGou = [CreatView creatImageViewWithFrame:CGRectMake(yuanWidth/2 - 18, yuanWidth - 36 - 10, 36, 36) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"bluegou"]];
    testFiveVC = [[TWOTestFiveViewController alloc] init];
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
    testFiveVC.scoreFour = self.scoreThree + 0;
    pushVC(testFiveVC);
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
    testFiveVC.scoreFour = self.scoreThree + 4;
    pushVC(testFiveVC);
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
    testFiveVC.scoreFour = self.scoreThree + 8;
    pushVC(testFiveVC);
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
    testFiveVC.scoreFour = self.scoreThree + 10;
    NSLog(@"ffffffffffffffff%f", testFiveVC.scoreFour);
    pushVC(testFiveVC);
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
