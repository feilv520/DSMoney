//
//  TWOProductPictureViewController.m
//  DSLC
//
//  Created by 马成铭 on 16/8/2.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOProductPictureViewController.h"

@interface TWOProductPictureViewController () <UIScrollViewDelegate>
{
    UIScrollView *mainScrillView;
}

@end

@implementation TWOProductPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorFromHexCode:@"#F5F6F7"];
    
    [self.navigationItem setTitle:[NSString stringWithFormat:@"%@/%ld",@"1",(unsigned long)self.pictureArr.count]];
    
    mainScrillView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT)];
    mainScrillView.bounces = NO;
    mainScrillView.pagingEnabled = YES;
    mainScrillView.delegate = self;
    mainScrillView.contentSize = CGSizeMake(WIDTH_CONTROLLER_DEFAULT * self.pictureArr.count, 1);
    [self.view addSubview:mainScrillView];
    
    for (NSInteger i = 0; i < self.pictureArr.count; i++) {
        YYAnimatedImageView *pictureImageView = [[YYAnimatedImageView alloc] initWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT * i, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT)];
        
        pictureImageView.yy_imageURL = [NSURL URLWithString:[[self.pictureArr objectAtIndex:i] objectForKey:@"imgPath"]];
        
        [mainScrillView addSubview:pictureImageView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    [self.navigationItem setTitle:[NSString stringWithFormat:@"%.0f/%ld",scrollView.contentOffset.x / WIDTH_CONTROLLER_DEFAULT + 1,(unsigned long)self.pictureArr.count]];
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
