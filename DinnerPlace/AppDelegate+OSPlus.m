//
//  AppDelegate+OSPlus.m
//  Exam Buddy
//
//  Created by osvin admin on 6/18/13.
//  Copyright (c) 2013 osvin. All rights reserved.
//

#import "AppDelegate+OSPlus.h"

@implementation AppDelegate (OSPlus)


#pragma mark IndicatorView

/************************************** NetWorkStatus **********************************************/

-(void)internetConnetionStatus:(NSString *)title andConnectionMessage:(NSString *)message {

    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];

    ensureInMainThread();
    [alertView show];
    [alertView release];
     alertView = nil;
    
}

-(void)updateNetworkStatus {

             switch ([FXReachability sharedInstance].status)
         {

            case FXReachabilityStatusUnknown:
            {
                [self internetConnetionStatus:@"Unknown Error" andConnectionMessage:@"Check your internet connection"];
                break;
            }

            case FXReachabilityStatusNotReachable:
            {
                [self internetConnetionStatus:@"Not reachable" andConnectionMessage:@"Internet connection not connected"];
                 break;
            }
                
            case FXReachabilityStatusReachableViaWWAN:
            {
                [self internetConnetionStatus:@"Reachable via WWAN" andConnectionMessage:@"Internet connection connected"];
                 break;
            }

            case FXReachabilityStatusReachableViaWiFi:
            {
                [self internetConnetionStatus:@"Reachable via WiFi" andConnectionMessage:@"Internet connection connected"];
                 break;
            }

           default:{
               
               [self internetConnetionStatus:@"Unknown Status" andConnectionMessage:@"Unknow internet status"];
               break;
            }
    }

}

/************************************** StarIndicatorView **********************************************/

-(void)startIndicatorView {

    if (!self.indicatorView) {

        self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [self.indicatorView setFrame:self.window.frame];
        self.indicatorView.backgroundColor = [UIColor blackColor];
        self.indicatorView.alpha = 0.7;
        [self.window addSubview:self.indicatorView];
    
    }


            ensureInMainThread();
            self.indicatorView.hidden = NO;
            self.window.userInteractionEnabled = NO;
            [self.indicatorView startAnimating];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    

}

/************************************** StopIndicatorView **********************************************/
-(void)stopIndicatorView {

    ensureInMainThread();
    [self.indicatorView stopAnimating];
    [self.indicatorView hidesWhenStopped];
    self.window.userInteractionEnabled = YES;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

}


-(void)requestFaield:(NSError *)error{

    NSString *errorMes;

    if (!error || [error isKindOfClass:[NSNull class]]) {

        errorMes = @"Unknown error occure";
    }else{

        errorMes = [NSString stringWithFormat:@"%@",error];
    }

    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Request Error!" message:errorMes delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];

    ensureInMainThread();
    if (self.indicatorView.isAnimating)
         [self stopIndicatorView];
    
               [alertView show];
        [alertView release];
         alertView = nil;
}


@end
