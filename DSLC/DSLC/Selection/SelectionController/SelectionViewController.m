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
#import "MyHandViewController.h"
#import "CastProduceViewController.h"
#import "ProductSettingViewController.h"
#import "MessageDetailViewController.h"

@interface SelectionViewController ()<UIScrollViewDelegate>{

    UIScrollView *backgroundScrollView;
    
    UIScrollView *bannerScrollView;
    
    UIPageControl *pageControl;

    NSTimer *timer;
    
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
    
    timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(scrollViewFuction) userInfo:nil repeats:YES];

    // 修改timer的优先级与控件一致
    // 获取当前的消息循环对象
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    // 更改timer对象的优先级
    [runLoop addTimer:timer forMode:NSRunLoopCommonModes];
    
}

// 添加控件
- (void)makeBackgroundView{
    backgroundScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT)];
    backgroundScrollView.backgroundColor = mainColor;
    backgroundScrollView.scrollEnabled = NO;
    
    if (WIDTH_CONTROLLER_DEFAULT == 320) {
        backgroundScrollView.scrollEnabled = YES;
        backgroundScrollView.contentSize = CGSizeMake(1, 667);
    }
    
    [self.view addSubview:backgroundScrollView];
}

// 广告滚动控件
- (void)makeScrollView{
    bannerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 180)];
    bannerScrollView.backgroundColor = Color_White;
    bannerScrollView.contentSize = CGSizeMake(WIDTH_CONTROLLER_DEFAULT * 5,0);
    bannerScrollView.contentOffset = CGPointMake(WIDTH_CONTROLLER_DEFAULT, 0);
    bannerScrollView.showsHorizontalScrollIndicator = NO;
    bannerScrollView.showsVerticalScrollIndicator = NO;
    bannerScrollView.pagingEnabled = YES;
    
    bannerScrollView.delegate = self;
    
    [backgroundScrollView addSubview:bannerScrollView];
    
    UIImageView *banner1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shouyebanner"]];
    UIImageView *banner2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shouyebanner"]];
    UIImageView *banner3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shouyebanner"]];
    UIImageView *banner4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shouyebanner"]];
    UIImageView *banner5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shouyebanner"]];
    
    banner1.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 180);
    banner2.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT, 0, WIDTH_CONTROLLER_DEFAULT, 180);
    banner3.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT * 2, 0, WIDTH_CONTROLLER_DEFAULT, 180);
    banner4.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT * 3, 0, WIDTH_CONTROLLER_DEFAULT, 180);
    banner5.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT * 4, 0, WIDTH_CONTROLLER_DEFAULT, 180);
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 150, WIDTH_CONTROLLER_DEFAULT, 30)];
    
    pageControl.numberOfPages = 3;
    pageControl.currentPage = 0;
    
    [bannerScrollView addSubview:banner1];
    [bannerScrollView addSubview:banner2];
    [bannerScrollView addSubview:banner3];
    [bannerScrollView addSubview:banner4];
    [bannerScrollView addSubview:banner5];
    [backgroundScrollView addSubview:pageControl];
    
}

// 三个按钮View
- (void)makeThreeButtons{
    UIView *threeView = [[UIView alloc] initWithFrame:CGRectMake(0, 180, WIDTH_CONTROLLER_DEFAULT, 90)];
    
    threeView.backgroundColor = mainColor;
    [backgroundScrollView addSubview:threeView];
    
    NSArray *nameArray = @[@"安全保障",@"千万风险金",@"新手指南"];
    NSArray *photoArray = @[@"shouyeqiepian_03",@"shouyeqiepian_05",@"shouyeqiepian_07"];
    
    CGFloat marginX = WIDTH_CONTROLLER_DEFAULT * (25 / 375.0);
    CGFloat buttonX = WIDTH_CONTROLLER_DEFAULT * (90 / 375.0);
    CGFloat buttonY = HEIGHT_CONTROLLER_DEFAULT * (110 / 667.0);
    
    for (NSInteger i = 0; i < nameArray.count; i++) {
        
        NSBundle *rootBundle = [NSBundle mainBundle];
        SelectionV *buttonView = [[rootBundle loadNibNamed:@"SelectionV" owner:nil options:nil] lastObject];
        
        CGFloat bVX = marginX + i * (marginX + buttonX);
        
        buttonView.frame = CGRectMake(bVX, 0, buttonX, buttonY);
        
        [buttonView.selectionButton setImage:[UIImage imageNamed:[photoArray objectAtIndex:i]] forState:UIControlStateNormal];
        buttonView.titleLabel.text = [nameArray objectAtIndex:i];
        
        [buttonView.selectionButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [threeView addSubview:buttonView];
    }
    
}

// 专享模块
// NSLog(@"%@",[UIFont familyNames]); 输出全部的字体
- (void)makeOnlyView{
    
    NSBundle *rootBundle = [NSBundle mainBundle];
    
    SelectionOfThing *selectionFTView = (SelectionOfThing *)[[rootBundle loadNibNamed:@"SelectionOfThing" owner:nil options:nil] lastObject];
    
    CGFloat margin_left = (22.5 / 375) * WIDTH_CONTROLLER_DEFAULT;
    
    selectionFTView.frame = CGRectMake(margin_left, 285, WIDTH_CONTROLLER_DEFAULT * (330 / 375.0), 215);
    
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
    [numberText addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:(45.0 / 375.0) * WIDTH_CONTROLLER_DEFAULT] range:numRange];
    [numberText addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:(28.0 / 375.0) * WIDTH_CONTROLLER_DEFAULT] range:markRange];
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
    
    [backgroundScrollView addSubview:selectionFTView];
    
}

// 立即抢购
- (void)makePayButton{
    UIButton *payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    payButton.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT * (51 / 375.0), 520, WIDTH_CONTROLLER_DEFAULT * (271.0 / 375.0), 43);
    
    [payButton setBackgroundImage:[UIImage imageNamed:@"shouyeqiepian_17"] forState:UIControlStateNormal];
    [payButton setTitle:@"立即抢购" forState:UIControlStateNormal];
    
    [payButton addTarget:self action:@selector(payButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [backgroundScrollView addSubview:payButton];
    
}

// 保障
- (void)makeSafeView{
 
    NSBundle *rootBundle = [NSBundle mainBundle];
    
    SelectionOfSafe *selectionSafeView = (SelectionOfSafe *)[[rootBundle loadNibNamed:@"SelectionOfSafe" owner:nil options:nil] lastObject];
    
    CGFloat button_X = WIDTH_CONTROLLER_DEFAULT * (180.0 / 375.0);
    CGFloat margin_left = ((WIDTH_CONTROLLER_DEFAULT - button_X) / 2 / 375.0) * WIDTH_CONTROLLER_DEFAULT;
    
    selectionSafeView.frame = CGRectMake(margin_left, 570, button_X, 17);
    
    [backgroundScrollView addSubview:selectionSafeView];
    
}

- (void)payButtonAction:(id)sender{
    // 手势VC
//    MyHandViewController *myhandVC = [[MyHandViewController alloc] init];
//    [self presentViewController:myhandVC animated:YES completion:^{
//        
//    }];
    
    // 在投资金
//    CastProduceViewController *castPVC = [[CastProduceViewController alloc] init];
//    [self.view.window.rootViewController presentViewController:castPVC animated:YES completion:^{
//
//    }];
    // 资产配置
    
//    [self.view.window.rootViewController presentViewController:pSettringVC animated:YES completion:^{

//    }];
//    ProductSettingViewController *pSettringVC = [[ProductSettingViewController alloc] init];
//    [self.view.window.rootViewController presentViewController:pSettringVC animated:YES completion:^{
//
//    }];
}

#pragma scrollView dalagate
// 滚动后的执行方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGPoint offset = [scrollView contentOffset];
    
    //更新UIPageControl的当前页
    CGRect bounds = scrollView.frame;
    [pageControl setCurrentPage:offset.x / bounds.size.width - 1];
    
    if (offset.x == WIDTH_CONTROLLER_DEFAULT * 4) {
        [bannerScrollView setContentOffset:CGPointMake(WIDTH_CONTROLLER_DEFAULT, 0) animated:NO];
        pageControl.currentPage = 0;
    } else if (offset.x == 0) {
        [bannerScrollView setContentOffset:CGPointMake(WIDTH_CONTROLLER_DEFAULT * 3, 0) animated:NO];
        pageControl.currentPage = 2;
    }

}

// 准备滚动时候的执行方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [timer invalidate];
    // 调用invalidate方法后,对象已经无法使用,所以要指向nil.
    timer = nil;
    
}

// 拖住完成的执行方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(scrollViewFuction) userInfo:nil repeats:YES];
    
    // 修改timer的优先级与控件一致
    // 获取当前的消息循环对象
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    // 更改timer对象的优先级
    [runLoop addTimer:timer forMode:NSRunLoopCommonModes];
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    CGPoint offset = [scrollView contentOffset];
    
    if (offset.x == WIDTH_CONTROLLER_DEFAULT * 4) {
        [bannerScrollView setContentOffset:CGPointMake(WIDTH_CONTROLLER_DEFAULT, 0) animated:NO];
        pageControl.currentPage = 0;
    } else if (offset.x == 0) {
        [bannerScrollView setContentOffset:CGPointMake(WIDTH_CONTROLLER_DEFAULT * 3, 0) animated:NO];
        pageControl.currentPage = 2;
    }
}

- (void)scrollViewFuction{
    
    [bannerScrollView setContentOffset:CGPointMake((pageControl.currentPage + 2) * WIDTH_CONTROLLER_DEFAULT, 0) animated:YES];

    pageControl.currentPage += 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonAction:(id)sender{
    
    UIButton *button = (UIButton *)sender;
    SelectionV *sView = (SelectionV *)button.superview;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:sView.titleLabel.text message:sView.titleLabel.text preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
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
