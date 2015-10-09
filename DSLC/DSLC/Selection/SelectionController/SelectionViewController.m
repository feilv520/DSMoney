//
//  SelectionViewController.m
//  DSLC
//
//  Created by ios on 15/10/9.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "SelectionViewController.h"
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
