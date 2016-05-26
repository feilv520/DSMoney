//
//  TWOProductDDetailViewController.m
//  DSLC
//
//  Created by 马成铭 on 16/5/24.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOProductDDetailViewController.h"
#import "TWOProductDetailTableViewCell.h"
#import "TRankinglistViewController.h"
#import "TWOProductDDDetailView.h"

@interface TWOProductDDetailViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate> {
    UIButton *button1;
    UIButton *button2;
    UILabel *labelLine;
    
    BOOL openFlag;
    
    NSArray *titleArray;
    
    UIView *firstView;
    UIScrollView *photoScrollView;
    UIPageControl *mainPageControl;
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TWOProductDDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorFromHexCode:@"#F5F6F7"];
    
    [self.navigationItem setTitle:@"资产详情"];
    
    openFlag = YES;
    
    titleArray = @[@"产品名称",@"产品类型",@"资产总额",@"预期年化收益率",@"开售时间",@"起息日",@"结息日",@"预计到账日",@"收益分配方式",@"融资方名称",@"项目定向用途",@"还款来源",@"抵押资产"];
    
    [self tableViewShow];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = [UIColor colorFromHexCode:@"#F5F6F7"];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOProductDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (!openFlag) {
        return 2;
    } else {
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 50;
        } else {
            return 150;
        }
    } else if (indexPath.section == 1) {
        
        return 50;
    } else {
        if (indexPath.row == 0) {
            return 50;
        } else {
            return 120;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 14;
    } else {
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 0.1;
    } else if (section == 1) {
        
        return 45;
    } else {
        
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0)
        return 152;
    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView *twoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 45)];
        
        button1 = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT/2, 45) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] titleText:@"资产介绍"];
        [twoView addSubview:button1];
        button1.tag = 101;
        button1.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        [button1 addTarget:self action:@selector(button1Press:) forControlEvents:UIControlEventTouchUpInside];
        
        button2 = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2, 0, WIDTH_CONTROLLER_DEFAULT/2, 45) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] titleText:@"项目进度"];
        [twoView addSubview:button2];
        button2.tag = 201;
        button2.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        [button2 addTarget:self action:@selector(button2Press:) forControlEvents:UIControlEventTouchUpInside];
        
        if (labelLine == nil) {
            
            labelLine = [CreatView creatWithLabelFrame:CGRectMake(0, 43, WIDTH_CONTROLLER_DEFAULT/2, 2) backgroundColor:[UIColor daohanglan] textColor:nil textAlignment:NSTextAlignmentCenter textFont:nil text:nil];
        }
        [twoView addSubview:labelLine];
        
        return twoView;

    } else {
        return nil;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        
        if (firstView == nil) {
    
            firstView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 150)];
            
            firstView.backgroundColor = Color_White;
            
            photoScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 150)];
            photoScrollView.delegate = self;
            photoScrollView.pagingEnabled = YES;
            photoScrollView.contentSize = CGSizeMake(3 * WIDTH_CONTROLLER_DEFAULT, 1);
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushWithController:)];
            
            [photoScrollView addGestureRecognizer:tap];
            
            UIImageView *image1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"首页banner"]];
            
            image1.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 150);
            
            UIImageView *image2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"组-21-拷贝-14"]];
            
            image2.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT, 0, WIDTH_CONTROLLER_DEFAULT, 150);
            
            UIImageView *image3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"组-21-拷贝-13"]];
            
            image3.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT * 2, 0, WIDTH_CONTROLLER_DEFAULT, 150);
            
            NSBundle *mainBundle = [NSBundle mainBundle];
            
            TWOProductDDDetailView *detailView = (TWOProductDDDetailView *)[[mainBundle loadNibNamed:@"TWOProductDDDetailView" owner:nil options:nil] lastObject];
            
            detailView.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT * 3, 0, 44, 150);
            
            [photoScrollView addSubview:image1];
            [photoScrollView addSubview:image2];
            [photoScrollView addSubview:image3];
            [photoScrollView addSubview:detailView];
            
            [firstView addSubview:photoScrollView];
            
            if (mainPageControl == nil) {
                
                mainPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 120, WIDTH_CONTROLLER_DEFAULT, 30)];
                
                mainPageControl.numberOfPages = 3;
                mainPageControl.currentPage = 0;
                
                [self changePageControlImage];
            }
            
            [firstView addSubview:mainPageControl];
            
        }
        return firstView;
    } else {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TWOProductDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [cell.titleLabel setFont:[UIFont systemFontOfSize:14]];
            cell.titleLabel.text = @"成安基金国富通亿丰商城项目";
            cell.valueLabel.hidden = YES;
            cell.titleLabel.hidden = NO;
            
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.titleLabel.hidden = NO;
            cell.titleLabel.text = @"基本信息";
            cell.valueLabel.hidden = YES;
            
        } else {
            cell.titleLabel.text = [titleArray objectAtIndex:indexPath.row - 1];
            cell.valueLabel.hidden = NO;
            cell.titleLabel.hidden = NO;
        
        }
    } else {
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"资产说明";
            cell.titleLabel.hidden = NO;
            cell.valueLabel.hidden = YES;
            
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)button1Press:(id)sender{
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        labelLine.frame = CGRectMake(0, 43, WIDTH_CONTROLLER_DEFAULT * 0.5, 2);
        
        openFlag = YES;
    } completion:^(BOOL finished) {
        [self.tableView reloadData];
    }];
}

- (void)button2Press:(id)sender{
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        labelLine.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT * 0.5, 43, WIDTH_CONTROLLER_DEFAULT * 0.5, 2);
        
        openFlag = NO;
    } completion:^(BOOL finished) {
        [self.tableView reloadData];
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView == photoScrollView) {
        
        CGPoint offset = scrollView.contentOffset;
        CGRect bounds = scrollView.frame;
        [mainPageControl setCurrentPage:offset.x / bounds.size.width];
    }
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
{
    if (scrollView == photoScrollView) {
        
        NSLog(@"%f",scrollView.contentOffset.x);
        NSLog(@"%lf",WIDTH_CONTROLLER_DEFAULT * 2 + 44.0);
        if (scrollView.contentOffset.x > (WIDTH_CONTROLLER_DEFAULT * 2 + 44)) {
            TRankinglistViewController *rankingVC = [TRankinglistViewController new];
            pushVC(rankingVC);
        }
    }
}

//改变pagecontrol中圆点样式
- (void)changePageControlImage
{
    static UIImage *imgCurrent = nil;
    static UIImage *imgOther = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        imgCurrent = [UIImage imageNamed:@"TWODDBlue"];
        imgOther = [UIImage imageNamed:@"TWODDWhite"];
    });
    
    
    if (iOS7) {
        [mainPageControl setValue:imgCurrent forKey:@"_currentPageImage"];
        [mainPageControl setValue:imgOther forKey:@"_pageImage"];
    } else {
        for (int i = 0;i < 3; i++) {
            UIImageView *imageVieW = [mainPageControl.subviews objectAtIndex:i];
            imageVieW.frame = CGRectMake(imageVieW.frame.origin.x, imageVieW.frame.origin.y, 20, 20);
            imageVieW.image = mainPageControl.currentPage == i ? imgCurrent : imgOther;
        }
    }
}

- (void)pushWithController:(UITapGestureRecognizer *)tap{
    TRankinglistViewController *rankingVC = [TRankinglistViewController new];
    pushVC(rankingVC);
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
