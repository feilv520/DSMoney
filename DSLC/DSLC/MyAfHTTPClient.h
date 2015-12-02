//
//  MyAfHTTPClient.h
//  DSLC
//
//  Created by 马成铭 on 15/11/2.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "define.h"

//网络请求成功，回掉的块
typedef void (^success)(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject);

//网络请求成功，其他错误比如登陆信息错误，回掉的块
typedef void (^failure)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error);

@interface MyAfHTTPClient : AFHTTPSessionManager

+ (_Nullable instancetype)sharedClient;


// get
//- (nullable NSURLSessionDataTask *)GET:(nullable NSString *)URLString
//                            parameters:(nullable id)parameters
//                               success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSString * _Nullable responseObject))success
//                               failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure;

// post
- (void)postWithURLString:(nullable NSString *)URLString
                             parameters:(nullable id)parameters
                                success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure;

+ (nullable NSDictionary *)parseJSONStringToNSDictionary:(nullable NSString *)JSONString;

// 上传图片
- (void)uploadFile:(nullable UIImage *)img;

// 压缩图片
- (NSData *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize;

@end
