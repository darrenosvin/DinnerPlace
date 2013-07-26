//
//  Constant.h
//  DinnerPlace
//
//  Created by osvin admin on 7/17/13.
//  Copyright (c) 2013 osvin. All rights reserved.
//

#ifndef DinnerPlace_Constant_h
#define DinnerPlace_Constant_h

static NSString *const kPreURL = @"http://clientdemo.osvin.biz/FindDinnerPlaceapi/FDinnerApi.svc/";


/*
 //Login
 http://clientdemo.osvin.biz/FindDinnerPlaceapi/FDinnerApi.svc/RegisterUser?facebookID=21dfdfdfdff&firstName=Muneer&lastName=muneer&DOB=11/31/9999%2011:59:58%20PM&Gender=Male&emailAddress=Sector%2040-D%20Chandigarh&deviceID=45454df5455
 //
 (15:31) Muneer Mohd: http://clientdemo.osvin.biz/FindDinnerPlaceapi/FDinnerApi.svc/GetRatings?PlaceID=1
(15:31) Muneer Mohd: http://clientdemo.osvin.biz/FindDinnerPlaceapi//FDinnerApi.svc/PostRating?PlaceID=1&facebookID=22&Rating=5
 (15:31) Muneer Mohd: http://clientdemo.osvin.biz/FindDinnerPlaceapi//FDinnerApi.svc/GetComments?PlaceID=1
 (15:32) Muneer Mohd: http://clientdemo.osvin.biz/FindDinnerPlaceapi//FDinnerApi.svc/PostComment?PlaceID=1&facebookID=22&commenttext=this%20is%20wonderfull%20place%20for%20dinner
 (15:32) hardeep.singh: ok sir g
 (15:32) Muneer Mohd: http://clientdemo.osvin.biz/FindDinnerPlaceapi//FDinnerApi.svc/GetDinnerPlaceDetail?PlaceID=1
 
 GetPlace
 (15:32) Muneer Mohd: http://clientdemo.osvin.biz/FindDinnerPlaceapi//FDinnerApi.svc/GetDinnerPlace
 
 
 (15:33) hardeep.singh: sir g itna kush bus b karo na.
 (15:33) Muneer Mohd: http://clientdemo.osvin.biz/FindDinnerPlaceapi//FDinnerApi.svc/GetUserProfile?facebookID=221
 (15:33) Muneer Mohd: ruko abhi kaha or h abhi to .
 (15:33) Muneer Mohd: chalo apki maan li bus krta hu ye ye sare method
 Your connection was closed due to an error

 
 */


#define FONT_SIZE    14.0f

#define CELL_CONTENT_WIDTH    320.0f
#define CELL_CONTENT_MARGIN   2.0f

#define fbIsLogin @"FBISLogin"
#define fbProfile @"fbProfile_"


#import "AppDelegate+OSPlus.h"
#import "FXReachability.h"
#import "OSCurrentLocation.h"
#import "OSRequest.h"
#import "NSString+BlueStr.h"
#import "UserProfile.h"
#import "AsyncImageView.h"


#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define isPhone568 ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 568)
#define iPhone568ImageNamed(image) (isPhone568 ? [NSString stringWithFormat:@"%@-568h.%@", [image stringByDeletingPathExtension], [image pathExtension]] : image)
#define OImageName(image) ([UIImage imageNamed:iPhone568ImageNamed(image)])


//INMainThread
#define ensureInMainThread(); if (!NSThread.isMainThread) { [self performSelectorOnMainThread:_cmd withObject:nil waitUntilDone:NO];    return; }

//INBackGroundThread
#define inBackGroundThread(); if (NSThread.isMainThread) { [self performSelectorInBackground:_cmd withObject:nil]; return; }


//-------Version

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#endif
