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
#import "TWOProductJinDuTableViewCell.h"
#import "TWOProductAssetModel.h"
#import "TWOProductWaitingTableViewCell.h"

@interface TWOProductDDetailViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate> {
    UIButton *button1;
    UIButton *button2;
    UILabel *labelLine;
    
    BOOL openFlag;
    
    NSArray *titleArray;
    
    UIView *firstView;
    UIScrollView *photoScrollView;
    UIPageControl *mainPageControl;
    
    CGSize size;
    NSIndexPath *path;
    NSIndexPath *flagPath;
    
    CGRect cellRect;
    
    BOOL moreOpenFlag;
    
    // 资产详情model
    TWOProductAssetModel *assetModel;
    
    // 资产详情数组
    NSMutableArray *progressArray;
    NSMutableArray *valueArray;
    
    UIWebView *webView;
    
    //判断打开符号
    NSMutableArray *moreOpenArray;
    
    CGFloat widthNumber;
    
    UIView *lineView;
    UIView *lineViewSectionWithOne;
    
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TWOProductDDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorFromHexCode:@"#F5F6F7"];
    
    [self.navigationItem setTitle:@"资产详情"];
    
    moreOpenArray = [NSMutableArray array];
    
    openFlag = YES;
    
    moreOpenFlag = NO;
    
    titleArray = @[@"产品名称",@"产品类型",@"资产总额",@"预期年化收益率",@"开售时间",@"起息日",@"结息日",@"预计到账日",@"收益分配方式",@"融资方名称",@"项目定向用途",@"还款来源",@"抵押资产"];
    
    progressArray = [NSMutableArray array];
    
    valueArray = [NSMutableArray array];
    
    [self getAssetDetailFuction];
    
    //    if (valueArray.count == 0) {
    [self tableViewShow];
    
    //    }
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = [UIColor colorFromHexCode:@"#F5F6F7"];
    _tableView.separatorColor = Color_Clear;
    [_tableView registerNib:[UINib nibWithNibName:@"TWOProductDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOProductJinDuTableViewCell" bundle:nil] forCellReuseIdentifier:@"reuseJinDu"];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOProductWaitingTableViewCell" bundle:nil] forCellReuseIdentifier:@"waiting"];
    
    //    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
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
        if (!openFlag) {
            if (moreOpenArray.count == 0) {
                return 45;
            } else {
                if (indexPath.row == moreOpenArray.count) {
                    return 45;
                } else {
                    if ([[moreOpenArray objectAtIndex:indexPath.row] isEqualToString:@"1"]) {
                        
                        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName, nil];
                        
                        CGSize mySize = [[[progressArray objectAtIndex:indexPath.row] objectForKey:@"pDetail"] boundingRectWithSize:CGSizeMake(widthNumber, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
                        
                        return 80 + mySize.height;
                    } else {
                        return 120;
                    }
                }
            }
        } else {
            return 50;
        }
    } else {
        if (indexPath.row == 0) {
            return 50;
        } else {
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName, nil];
            
            CGSize sizeDetail = [[assetModel assetProjectResume] boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
            
            return sizeDetail.height;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        if (!openFlag) {
            return progressArray.count + 1;
        } else {
            return titleArray.count + 1;
        }
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
            
            labelLine = [CreatView creatWithLabelFrame:CGRectMake(0, 43, WIDTH_CONTROLLER_DEFAULT/2, 2) backgroundColor:[UIColor profitColor] textColor:nil textAlignment:NSTextAlignmentCenter textFont:nil text:nil];
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
            cell.titleLabel.text = self.assetTitle;
            cell.valueLabel.hidden = YES;
            cell.titleLabel.hidden = NO;
            
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.titleLabel.hidden = NO;
            cell.titleLabel.text = @"基本信息";
            cell.valueLabel.hidden = YES;
            
            cell.lineView.hidden = NO;
            
        } else {
            
            cell.lineView.hidden = YES;
            
            cell.titleLabel.hidden = NO;
            cell.valueLabel.hidden = NO;
            cell.titleLabel.text = [titleArray objectAtIndex:indexPath.row - 1];
            if (valueArray.count != 0) {
                
                cell.valueLabel.text = [NSString stringWithFormat:@"%@",[valueArray objectAtIndex:indexPath.row - 1]];
            }
            
            //            webView.hidden = YES;
            
        }
    } else {
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"资产说明";
            cell.titleLabel.hidden = NO;
            cell.valueLabel.hidden = YES;
            
            cell.lineView.hidden = NO;
            
        } else {
            
            cell.lineView.hidden = YES;
            
            cell.titleLabel.text = [assetModel assetProjectDetail];
            cell.titleLabel.hidden = YES;
            cell.valueLabel.hidden = YES;
            
            NSString *detailString = [assetModel assetProjectResume];
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName, nil];
            
            CGSize sizeDetail = [detailString boundingRectWithSize:CGSizeMake(cell.frame.size.width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
            
            webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, sizeDetail.height)];
            webView.userInteractionEnabled = NO;
            [cell addSubview:webView];
            
            //            webView.hidden = NO;
            
            detailString = [detailString stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            detailString = [detailString stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            detailString = [detailString stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
            detailString = [detailString stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
            detailString = [detailString stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
            
            [webView loadHTMLString:detailString baseURL:nil];
        }
    }
    
    if (!openFlag) {
        if (indexPath.section == 1) {
            
            // 判断数组是否有数值,如果有就显示正常的,否则只显示待续
            if (progressArray.count == 0) {
                
                TWOProductWaitingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"waiting"];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            } else {
                if (indexPath.row == progressArray.count) {
                    
                    TWOProductWaitingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"waiting"];
                    
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                } else {
                    
                    TWOProductJinDuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseJinDu"];
                    
                    [cell.moreButton addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
                    
                    NSString *detailString = [[progressArray objectAtIndex:indexPath.row] objectForKey:@"pDetail"];
                    
                    cell.dateLabel.text = [[progressArray objectAtIndex:indexPath.row] objectForKey:@"pDate"];
                    cell.valueLabel.text = detailString;
                    
                    widthNumber = cell.valueLabel.frame.size.width;
                    
                    if ((detailString.length / (widthNumber / 13.0)) <= 3.0) {
                        cell.moreButton.hidden = YES;
                    } else {
                        cell.moreButton.hidden = NO;
                    }
                    
                    if (WIDTH_CONTROLLER_DEFAULT == 320.0) {
                        cell.lineView.frame = CGRectMake(cell.bianImageView.center.x - 1, 50, 2, 70);
                    }
                    
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                }
            }
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

- (void)moreAction:(id)sender{
    
    TWOProductJinDuTableViewCell * cell = (TWOProductJinDuTableViewCell *)[[sender superview] superview];
    
    path = [self.tableView indexPathForCell:cell];
    
    [moreOpenArray replaceObjectAtIndex:path.row withObject:@"1"];
    
    //    if (flagPath.row == path.row || flagPath == nil) {
    
    cellRect = cell.valueLabel.frame;
    
    [cell.moreButton setTitle:@"收起" forState:UIControlStateNormal];
    cell.fuhaoImage.image = [UIImage imageNamed:@"TWOPUp"];
    [cell.moreButton removeTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.moreButton addTarget:self action:@selector(sMoreAction:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.valueLabel.text = [[progressArray objectAtIndex:path.row] objectForKey:@"pDetail"];
    
    cell.valueLabel.numberOfLines = 0;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName, nil];
    
    size = [cell.valueLabel.text boundingRectWithSize:CGSizeMake(cell.valueLabel.frame.size.width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    cell.valueLabel.frame = CGRectMake(cell.valueLabel.frame.origin.x, cell.valueLabel.frame.origin.y, cell.valueLabel.frame.size.width, size.height + 10);
    
    if (WIDTH_CONTROLLER_DEFAULT == 320.0) {
        cell.lineView.frame = CGRectMake(cell.bianImageView.center.x - 3, 50, 2, 70);
    }
    
    //        NSIndexPath *myPath=[NSIndexPath indexPathForRow:path.row - 1 inSection:path.section];
    //
    //        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:myPath,nil]  withRowAnimation:UITableViewRowAnimationNone];
    
    [self.tableView reloadData];
    
    //        flagPath = path;
    //    } else {
    //        [self sMoreAction:nil];
    //    }
    NSLog(@"moreOpenArray - %@",moreOpenArray);
    
}

- (void)sMoreAction:(id)sender{
    
    TWOProductJinDuTableViewCell *cell = (TWOProductJinDuTableViewCell *)[[sender superview] superview];
    
    path = [self.tableView indexPathForCell:cell];
    
    //    if (flagPath.row == path.row) {
    
    [moreOpenArray replaceObjectAtIndex:path.row withObject:@"0"];
    
    [cell.moreButton setTitle:@"查看更多" forState:UIControlStateNormal];
    cell.fuhaoImage.image = [UIImage imageNamed:@"TWOPDown"];
    [cell.moreButton removeTarget:self action:@selector(sMoreAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.moreButton addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.valueLabel.text = [[progressArray objectAtIndex:path.row] objectForKey:@"pDetail"];
    
    cell.valueLabel.numberOfLines = 3;
    
    cell.valueLabel.frame = cellRect;
    
    if (WIDTH_CONTROLLER_DEFAULT == 320.0) {
        cell.lineView.frame = CGRectMake(cell.bianImageView.center.x - 3, 50, 2, 70);
    }
    //
    //        NSIndexPath *myPath=[NSIndexPath indexPathForRow:path.row - 1 inSection:path.section];
    //
    //        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:myPath,nil]  withRowAnimation:UITableViewRowAnimationNone];
    
    [self.tableView reloadData];
    
    //    } else {
    
    //        [moreOpenArray replaceObjectAtIndex:flagPath.row - 1 withObject:@"0"];
    //
    //        [cell.moreButton setTitle:@"查看更多" forState:UIControlStateNormal];
    //        cell.fuhaoImage.image = [UIImage imageNamed:@"TWOPDown"];
    //        [cell.moreButton removeTarget:self action:@selector(sMoreAction:) forControlEvents:UIControlEventTouchUpInside];
    //        [cell.moreButton addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    //
    //        cell.valueLabel.text = [[progressArray objectAtIndex:flagPath.row - 1] objectForKey:@"pDetail"];
    //
    //        cell.valueLabel.numberOfLines = 3;
    //
    //        cell.valueLabel.frame = cellRect;
    //
    //        if (WIDTH_CONTROLLER_DEFAULT == 320.0) {
    //            cell.lineView.frame = CGRectMake(cell.bianImageView.center.x - 3, 50, 2, 70);
    //        }
    //
    //        //    [self.tableView reloadData];
    //        NSIndexPath *myPath=[NSIndexPath indexPathForRow:flagPath.row - 1 inSection:flagPath.section];
    //        NSIndexPath *myTPath=[NSIndexPath indexPathForRow:path.row - 1 inSection:path.section];
    //        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:myPath,myTPath,nil]  withRowAnimation:UITableViewRowAnimationNone];
    //
    //        flagPath = path;
    //    }
    
    NSLog(@"moreOpenArrays - %@",moreOpenArray);
    
}

#pragma mark 资产详情接口
#pragma mark --------------------------------

- (void)getAssetDetailFuction{
    NSDictionary *parameter = @{@"assetId":self.assetId,@"clientType":@"iOS"};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"asset/getAssetDetail" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"产品详情ppppppppppppppp%@",responseObject);
        
        assetModel = [[TWOProductAssetModel alloc] init];
        [assetModel setValuesForKeysWithDictionary:[responseObject objectForKey:@"Asset"]];
        
        [valueArray addObject:[assetModel assetName]];
        [valueArray addObject:[assetModel assetTypeName]];
        [valueArray addObject:[assetModel assetAmount]];
        [valueArray addObject:[assetModel assetAnnualYieldb]];
        [valueArray addObject:[assetModel assetSaleTime]];
        [valueArray addObject:[assetModel assetInterestBdate]];
        [valueArray addObject:[assetModel assetInterestEdate]];
        [valueArray addObject:[assetModel assetToaccountDate]];
        [valueArray addObject:[assetModel assetYieldDistribType]];
        [valueArray addObject:[assetModel assetFinancierName]];
        [valueArray addObject:[assetModel assetFundsUse]];
        [valueArray addObject:[assetModel assetRepaymentSource]];
        [valueArray addObject:[assetModel assetManager]];
        
        progressArray = [[responseObject objectForKey:@"Asset"] objectForKey:@"Progress"];
        
        for (NSInteger i = 0; i < progressArray.count; i++) {
            [moreOpenArray addObject:@"0"];
        }
        
        [_tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
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
