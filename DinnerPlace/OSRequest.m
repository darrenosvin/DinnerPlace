//
//  OSRequest.m
//  DinnerPlace
//
//  Created by osvin admin on 7/17/13.
//  Copyright (c) 2013 osvin. All rights reserved.
//

#import "OSRequest.h"

@implementation OSRequest


+(void)sendAsyncReque:(BOOL)isAsync url:(NSString *)apiURL completionHandle:(void(^)(id data, NSError *error))handler {


    if (![FXReachability isReachable]) {

        return;
    }



    NSString *strURL = [kPreURL stringByAppendingString:apiURL];
              strURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL    *URL    = [NSURL URLWithString:strURL];

    NSLog(@"%@",strURL);



    NSURLCacheStoragePolicy policy   = NSURLCacheStorageNotAllowed;
    NSURLRequest           *request2 = [NSURLRequest requestWithURL:URL cachePolicy:policy timeoutInterval:60.0];

    //StartIndicatorView.
    [appDelegate() startIndicatorView];

    if (isAsync) {
        
        NSOperationQueue       *queue    = [[NSOperationQueue alloc] init];

    [NSURLConnection sendAsynchronousRequest:request2 queue:queue completionHandler:^(NSURLResponse* response, id data, NSError* error) {


        if (error) {

            [appDelegate() requestFaield:error];
            return;
        }

        //----
        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                             options:kNilOptions
                                                               error:&jsonError];

        NSLog(@"%@",json);

        
        if (json) {

            //CallBack
            handler(json,jsonError);
            
        }else {
            
            //CallBack
            handler(nil,jsonError);
        }

        //StopIndicatorView...
        [appDelegate() stopIndicatorView];
        
    }];
        
        [queue release];
        

    }else {

    //************************************************* SynchronousRequest ****************************************************************

        NSError *requestError;
        NSURLResponse *urlResponse = nil;
        NSData *response = [NSURLConnection sendSynchronousRequest:request2 returningResponse:&urlResponse error:&requestError];

        if (response == nil) {

            // Check for problems
            if (requestError != nil) {
                
            }

            [appDelegate() requestFaield:requestError];
            
        }
        else {
            // Data was received.. continue processing
            //----
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:response
                                                                 options:kNilOptions
                                                                   error:&requestError];
            handler(json,nil);

        }
    }
    
}

@end
