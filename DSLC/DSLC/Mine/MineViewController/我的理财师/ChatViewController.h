//
//  ChatViewController.h
//  Content
//
//  Created by ios on 15/11/17.
//  Copyright © 2015年 ios. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ChatViewController : BaseViewController
@property (nonatomic) NSString *IId;
@property (nonatomic) NSString *chatName;
@property (nonatomic) BOOL userORplanner;
@end
