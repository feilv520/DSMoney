//
//  AddressBookViewController.h
//  DSLC
//
//  Created by ios on 15/11/16.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "BaseViewController.h"

@interface AddressBookViewController : BaseViewController

//返回tableview右方indexArray
+(NSMutableArray*)IndexArray:(NSArray*)stringArr;

//返回联系人
+(NSMutableArray*)LetterSortArray:(NSArray*)stringArr;

//返回一组字母排序数组(中英混排)排序后的数组
+(NSMutableArray*)SortArray:(NSArray*)stringArr;

@end
