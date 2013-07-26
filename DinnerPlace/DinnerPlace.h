//
//  DinnerPlace.h
//  DinnerPlace
//
//  Created by osvin admin on 7/22/13.
//  Copyright (c) 2013 osvin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DinnerPlace : NSObject <MKAnnotation> 


@property (nonatomic, assign)  CLLocationCoordinate2D coordinate;
@property (nonatomic, assign)  NSInteger tag;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *address1,*address2;
@property (nonatomic, copy) NSString *comments;
@property (nonatomic, copy) NSString *placeID;
@property (nonatomic, copy) NSString *strImgURL;

@end
