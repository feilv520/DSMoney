//
//  SelectionViewController.m
//  DSLC
//
//  Created by ios on 15/10/9.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "SelectionViewController.h"
#import "SelectionOfThing.h"
#import "SelectionOfSafe.h"
#import "SelectionV.h"
#import "define.h"

@interface SelectionViewController (){

    UIScrollView *backgroundScrollView;
    
    UIScrollView *scrollView;

}
@end

@implementation SelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    [self makeBackgroundView];
    [self makeScrollView];
    [self makeThreeButtons];
    [self makeOnlyView];
    [self makePayButton];
    [self makeSafeView];
}

// 添加控件
- (void)makeBackgroundView{
    backgroundScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT)];
    backgroundScrollView.backgroundColor = mainColor;
    backgroundScrollView.scrollEnabled = NO;
    
    if (WIDTH_CONTROLLER_DEFAULT == 320) {
        backgroundScrollView.scrollEnabled = YES;
        backgroundScrollView.contentSize = CGSizeMake(0, HEIGHT_CONTROLLER_DEFAULT);
    }
    
    [self.view addSubview:backgroundScrollView];
}

// 广告滚动控件
- (void)makeScrollView{
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 180)];
    scrollView.backgroundColor = Color_White;
    scrollView.contentSize = CGSizeMake(WIDTH_CONTROLLER_DEFAULT * 3,0);
    scrollView.pagingEnabled = YES;
    
    [backgroundScrollView addSubview:scrollView];
    
    UIImageView *banner1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shouyebanner"]];
    UIImageView *banner2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shouyebanner"]];
    UIImageView *banner3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shouyebanner"]];
    
    banner1.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 180);
    banner2.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT, 0, WIDTH_CONTROLLER_DEFAULT, 180);
    banner3.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT * 2, 0, WIDTH_CONTROLLER_DEFAULT, 180);
    
    [scrollView addSubview:banner1];
    [scrollView addSubview:banner2];
    [scrollView addSubview:banner3];
    
}

// 三个按钮View
- (void)makeThreeButtons{
    UIView *threeView = [[UIView alloc] initWithFrame:CGRectMake(0, 180, WIDTH_CONTROLLER_DEFAULT, 90)];
    
    threeView.backgroundColor = mainColor;
    [self.view addSubview:threeView];
    
    NSArray *nameArray = @[@"安全保障",@"千万风险金",@"新手指南"];
    NSArray *photoArray = @[@"shouyeqiepian_03",@"shouyeqiepian_05",@"shouyeqiepian_07"];
    
    CGFloat marginX = 25;
    CGFloat buttonX = 90;
    CGFloat buttonY = 110;
    
    
    for (NSInteger i = 0; i < nameArray.count; i++) {
        
        NSBundle *rootBundle = [NSBundle mainBundle];
        SelectionV *buttonView = [[rootBundle loadNibNamed:@"SelectionV" owner:nil options:nil] lastObject];
        
        CGFloat bVX = marginX + i * (marginX + buttonX);
        
        buttonView.frame = CGRectMake(bVX, 0, buttonX, buttonY);
        
        [buttonView.selectionButton setImage:[UIImage imageNamed:[photoArray objectAtIndex:i]] forState:UIControlStateNormal];
        buttonView.titleLabel.text = [nameArray objectAtIndex:i];
        
        [threeView addSubview:buttonView];
    }
    
}

// 专享模块
// NSLog(@"%@",[UIFont familyNames]); 输出全部的字体
- (void)makeOnlyView{
    
    NSBundle *rootBundle = [NSBundle mainBundle];
    
    SelectionOfThing *selectionFTView = (SelectionOfThing *)[[rootBundle loadNibNamed:@"SelectionOfThing" owner:nil options:nil] lastObject];
    
    CGFloat margin_left = 22.5;
    
    selectionFTView.frame = CGRectMake(margin_left, 285, 330, 215);
    
    selectionFTView.layer.cornerRadius = 4;
    
    selectionFTView.layer.masksToBounds = YES;
    
    selectionFTView.moreButton.layer.cornerRadius = 10;
    
    selectionFTView.moreButton.layer.masksToBounds = YES;
    //给图层添加一个有色边框
    selectionFTView.moreButton.layer.borderWidth = 1;
    
    selectionFTView.moreButton.layer.borderColor = [[UIColor colorWithRed:117.0 / 255.0 green:119.0 / 255.0 blue:125.0 / 255.0 alpha:1] CGColor];
    
    NSMutableAttributedString *numberText = [[NSMutableAttributedString alloc] initWithString:@"8.02%"];
    NSMutableAttributedString *dayText = [[NSMutableAttributedString alloc] initWithString:@"3 天"];
    NSMutableAttributedString *moneyText = [[NSMutableAttributedString alloc] initWithString:@"24.3 万元"];
    NSMutableAttributedString *firstMoneyText = [[NSMutableAttributedString alloc] initWithString:@"1,000 元"];
    
    NSRange numRange = NSMakeRange(0, [[numberText string] rangeOfString:@"%"].location);
    NSRange markRange = NSMakeRange([[numberText string] rangeOfString:@"%"].location, 1);
    
    [numberText addAttribute:NSForegroundColorAttributeName value:Color_Red range:numRange];
    [numberText addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:45.0] range:numRange];
    [numberText addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:28.0] range:markRange];
    [selectionFTView.numberLabel setAttributedText:numberText];
    
    NSRange markDayRange = NSMakeRange([[dayText string] rangeOfString:@"天"].location , 1);
    NSRange markWRange = NSMakeRange([[moneyText string] rangeOfString:@"万"].location , 2);
    NSRange markYuanRange = NSMakeRange([[firstMoneyText string] rangeOfString:@"元"].location , 1);
    
    [dayText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0] range:markDayRange];
    [moneyText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0] range:markWRange];
    [firstMoneyText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0] range:markYuanRange];
    
    [selectionFTView.dayLabel setAttributedText:dayText];
    [selectionFTView.moneyLabel setAttributedText:moneyText];
    [selectionFTView.firstLabel setAttributedText:firstMoneyText];
    
    [self.view addSubview:selectionFTView];
    
}

// 立即抢购
- (void)makePayButton{
    UIButton *payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    payButton.frame = CGRectMake(51, 520, WIDTH_CONTROLLER_DEFAULT - 104, 43);
    
    [payButton setBackgroundImage:[UIImage imageNamed:@"shouyeqiepian_17"] forState:UIControlStateNormal];
    [payButton setTitle:@"立即抢购" forState:UIControlStateNormal];
    
    [self.view addSubview:payButton];
    
}

// 保障
- (void)makeSafeView{
 
    NSBundle *rootBundle = [NSBundle mainBundle];
    
    SelectionOfSafe *selectionSafeView = (SelectionOfSafe *)[[rootBundle loadNibNamed:@"SelectionOfSafe" owner:nil options:nil] lastObject];
    
    selectionSafeView.frame = CGRectMake(92, 570, 182, 17);
    
    [self.view addSubview:selectionSafeView];
    
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
