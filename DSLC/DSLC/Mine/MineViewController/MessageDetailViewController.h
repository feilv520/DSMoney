//
//  MessageDetailViewController.h
//  DSLC
//
//  Created by 马成铭 on 15/10/19.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "BaseViewController.h"

@interface MessageDetailViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@property (nonatomic, strong) NSString *textString;

@end
