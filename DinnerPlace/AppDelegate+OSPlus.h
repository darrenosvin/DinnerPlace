//
//  AppDelegate+OSPlus.h
//  Exam Buddy
//
//  Created by osvin admin on 6/18/13.
//  Copyright (c) 2013 osvin. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (OSPlus)

-(void)startIndicatorView;
-(void)stopIndicatorView;

-(void)requestFaield:(NSError *)error;

//NetWorkStatus...
-(void)updateNetworkStatus;

@end
