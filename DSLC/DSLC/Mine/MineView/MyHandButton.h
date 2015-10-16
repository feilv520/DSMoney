//
//  MyHandButton.h
//  DSLC
//
//  Created by 马成铭 on 15/10/16.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyHandButton;

@protocol MyHandButtonDelegate <NSObject>

@optional
- (void)lockView:(MyHandButton *)lockView didFinishPath:(NSString *)path;

@end

@interface MyHandButton : UIView

@property (nonatomic, assign) id<MyHandButtonDelegate> delegate;

@end
