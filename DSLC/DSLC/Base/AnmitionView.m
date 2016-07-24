//
//  AnmitionView.m
//  DSLC
//
//  Created by ios on 16/7/24.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "AnmitionView.h"
#import "define.h"
#import "AppDelegate.h"

@implementation AnmitionView

+ (AnmitionView *)creatView
{
    AnmitionView *anmitionV = [[AnmitionView alloc] init];
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UIButton *buttonBlack = [UIButton buttonWithType:UIButtonTypeCustom];
    [app.tabBarVC.view addSubview:buttonBlack];
    buttonBlack.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT);
    buttonBlack.backgroundColor = [UIColor blackColor];
    buttonBlack.alpha = 0.5;
    buttonBlack.tag = 721;
    [buttonBlack addTarget:self action:@selector(buttonBlackClickDisappear:) forControlEvents:UIControlEventTouchUpInside];
    
//    UIView *viewWhite = [[UIView alloc] initWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 530/2/2, 194.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 530/2, 397/2 + 30)];
//    [app.tabBarVC.view addSubview:viewWhite];
//    viewWhite.backgroundColor = [UIColor whiteColor];
//    viewWhite.tag = 111;
//    
//    UIImageView *imageWait = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, viewWhite.frame.size.width, viewWhite.frame.size.height)];
//    [viewWhite addSubview:imageWait];
    
    return anmitionV;
}

- (void)buttonBlackClickDisappear:(UIButton *)buttonTag
{
    [buttonTag removeFromSuperview];
    buttonTag = nil;
    
//    UIView *viewTag = (UIView *)[self viewWithTag:111];
//    [viewTag removeFromSuperview];
//    viewTag = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
