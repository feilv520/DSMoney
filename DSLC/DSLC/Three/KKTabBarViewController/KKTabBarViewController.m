//
//  KKTabBarViewController.m
//  KKTabBarViewDemo
//
//  Created by yaodd on 14-1-26.
//  Copyright (c) 2014年 yaodd. All rights reserved.
//

#import "KKTabBarViewController.h"
#import "define.h"
#import "LoginViewController.h"

@interface KKTabBarViewController (){
    UIButton *indexButton;
    UIButton *firstButton;
}

@property (nonatomic, assign) CGFloat pageWidth;
@property (nonatomic, assign) CGFloat pageHeight;
@property (nonatomic, strong) UIView *tabbarView;

@property (nonatomic, strong) NSDictionary *flagLogin;

@end

@implementation KKTabBarViewController

//    if ([[self.flagLogin objectForKey:@"loginFlag"] isEqualToString:@"YES"]) {
//        [self autoLogin];
//    }

// 登录标识文件
- (NSDictionary *)flagLogin{
    if (_flagLogin == nil) {
        if (![FileOfManage ExistOfFile:@"isLogin.plist"]) {
            [FileOfManage createWithFile:@"isLogin.plist"];
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"loginFlag",nil];
            [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
        }
    }
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"isLogin.plist"]];
    self.flagLogin = dic;
    return _flagLogin;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}
- (id)initWithControllerArray:(NSArray *)controllerArray
{
    _controllerArray = [NSArray arrayWithArray:controllerArray];
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    [self initTabPage];
    [self initTabBar];
    
    
}

- (id)init{
    self = [super init];
    if (self) {
        _tabBarPosition = kTabBarPositionBottom;
        _tabBarHidden = NO;
        _transitionAnimated = YES;
        _suppurtGestureTransition = YES;
    }
    return  self;
}

//初始化每个页面，把分页加进去
- (void)initTabPage
{
    _pageWidth = self.view.frame.size.width;
    _pageHeight = self.view.frame.size.height;
    CGRect scrollFrame = CGRectMake(0, 0, _pageWidth, _pageHeight);
    CGSize contentSize = CGSizeMake(_pageWidth * [_controllerArray count], _pageHeight);
    _tabScrollView = [[UIScrollView alloc]initWithFrame:scrollFrame];
    [_tabScrollView setContentSize:contentSize];
    [_tabScrollView setPagingEnabled:YES];
    [_tabScrollView setDelegate:self];
    [_tabScrollView setBounces:NO];
    [_tabScrollView setShowsHorizontalScrollIndicator:NO];
    [_tabScrollView setShowsVerticalScrollIndicator:NO];
    [_tabScrollView setScrollEnabled:_suppurtGestureTransition];
    //把分页的view加进scrollview
    for (int i = 0; i < [_controllerArray count]; i ++) {
        //从controller数组中取出controller的view
        UIView *tabView = ((UIViewController *)[_controllerArray objectAtIndex:i]).view;
        [tabView setFrame:CGRectMake(i * _pageWidth, 0, tabView.frame.size.width, tabView.frame.size.height)];
        [_tabScrollView addSubview:tabView];
        
    }
    
    self.tabbarView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 53, self.view.frame.size.width, 53)];
    self.tabbarView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_tabScrollView];
    [self.view addSubview:_tabbarView];
    
    _curPage = 0;
    _tabBarHidden = NO;
}
//初始化切换页面的按钮
- (void)initTabBar
{
//    CGFloat buttonWidth = _pageWidth / [_controllerArray count];
    CGFloat buttonWidth = 35;
    for (int i = 0 ; i < [_tabButtonArray count]; i ++) {
        CGFloat buttonHeight;
        
        UIButton *tabButton = [_tabButtonArray objectAtIndex:i];
//        if (tabButton.frame.size.height == 0) {
            buttonHeight = 30;
//        } else{
//            buttonHeight = tabButton.frame.size.height;
//        }
//        if (_tabBarPosition == kTabBarPositionTop) {
//            buttonY = 0;
//        } else{
//            buttonY = _pageHeight - buttonHeight;
//        }
        [tabButton setFrame:CGRectMake(30 + _pageWidth / [_controllerArray count] * i, 20, buttonWidth, buttonHeight)];
        [tabButton setTag:i];
        [tabButton addTarget:self action:@selector(tabAction:) forControlEvents:UIControlEventTouchDown];
        [tabButton setHidden:self.tabBarHidden];
        if (tabButton.tag == _curPage) {
            [tabButton setSelected:YES];
        }
        if (i == 0) {
            indexButton = tabButton;
            firstButton = tabButton;
        }
        [self.tabbarView addSubview:tabButton];
    }
    
}

//设置底部按钮的高度
- (void)setTabBarHeight:(CGFloat)tabBarHeight
{
    _tabBarHeight = tabBarHeight;
//    NSLog(@"height %f",self.view.frame.size.height);
    self.labelLine = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 53, self.view.frame.size.width, 1)];
    [self.view addSubview:self.labelLine];
    self.labelLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.labelLine.alpha = 0.7;
    
    for (UIButton *button in _tabButtonArray) {
        
        CGRect buttonFrame = button.frame;
        buttonFrame.size.height = _tabBarHeight;
//        if (_tabBarPosition == kTabBarPositionTop) {
            buttonFrame.origin.y = 10;
//        } else{
//            buttonFrame.origin.y = self.view.frame.size.height - _tabBarHeight;
//        }
        button.frame = buttonFrame;
    }
}

- (void)setTabBarPosition:(TabBarPosition)tabBarPosition
{
    _tabBarPosition = tabBarPosition;
    for (UIButton *button in _tabButtonArray) {
        CGRect buttonFrame = button.frame;
//        if (_tabBarPosition == kTabBarPositionTop) {
            buttonFrame.origin.y = 0;
//        } else{
//            buttonFrame.origin.y = _pageHeight - buttonFrame.size.height;
//        }
        button.frame = buttonFrame;
        
    }
}
- (void)setSuppurtGestureTransition:(BOOL)suppurtGestureTransition
{
    _suppurtGestureTransition = suppurtGestureTransition;
    [_tabScrollView setScrollEnabled:_suppurtGestureTransition];
}
//切换页面按钮点击事件
- (void)tabAction:(UIButton *)button
{
    if (button.tag == 3) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"hideWithTabbarView" object:indexButton];
//        if ([[self.flagLogin objectForKey:@"loginFlag"] isEqualToString:@"NO"]) {
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"showLoginView" object:nil];
//            return ;
//        } else {
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"dian" object:nil];
//        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:nil];
    } else {
    indexButton = button;
    }
    
    [_tabScrollView setContentOffset:CGPointMake(button.tag * _pageWidth, 0) animated:_transitionAnimated];
    for (UIButton *tempButton in _tabButtonArray) {
        if (button.tag != tempButton.tag) {
            [tempButton setSelected:NO];
        }
    }
    
    [button setSelected:YES];
    
}
#pragma UIScrollViewDelegate mark
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
    CGFloat offset = [scrollView contentOffset].x;
    int curPage = offset / _pageWidth;
    for (UIButton *button in _tabButtonArray) {
        if (button.tag == curPage) {
            [button setSelected:YES];
        }
        else{
            [button setSelected:NO];
        }
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offset = [scrollView contentOffset].x;
    _curPage = offset / _pageWidth;
    for (UIButton *button in _tabButtonArray) {
        if (button.tag == _curPage) {
            [button setSelected:YES];
        }
        else{
            [button setSelected:NO];
        }
    }
}

//设置是否隐藏掉切换页面的按钮
- (void)setTabBarHidden:(BOOL)tabBarHidden
{
    BOOL ytesz = tabBarHidden;
    //    NSLog(@"%d subView",[[self.view subviews] count]);
    for (UIButton *tabButton  in _tabButtonArray) {
        [tabButton setHidden:ytesz];
        //        [tabButton setHidden:NO];
    }
}

- (void)setLabelLineHidden:(BOOL)LabelLineHidden
{
    self.labelLine.hidden = LabelLineHidden;
}

- (void)setTabbarViewHidden:(BOOL)tabbarViewHidden
{
    self.tabbarView.hidden = tabbarViewHidden;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
