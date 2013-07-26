//
//  OSRequest.h
//  DinnerPlace
//
//  Created by osvin admin on 7/17/13.
//  Copyright (c) 2013 osvin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^OSRequestCallBack)(int status,id data);

@interface OSRequest : NSObject

@property (nonatomic, copy) OSRequestCallBack callback;

+(void)sendAsyncReque:(BOOL)isAsync url:(NSString *)apiURL completionHandle:(void(^)(id data, NSError *error))handler;
@end
