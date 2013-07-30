//
//  OSPlace.h
//  DinnerPlace
//
//  Created by osvin admin on 7/25/13.
//  Copyright (c) 2013 osvin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSPlace : NSObject

@property (nonatomic, assign) float latitude;
@property (nonatomic, assign) float longitude;

@property (nonatomic, strong) NSString   *ISOCountryCode;
@property (nonatomic, strong) NSString   *country;
@property (nonatomic, strong) NSString   *postalCode;
@property (nonatomic, strong) NSString   *administrativeArea;
@property (nonatomic, strong) NSString   *subAdministrativeArea;
@property (nonatomic, strong) NSString   *locality;
@property (nonatomic, strong) NSString   *subLocality;
@property (nonatomic, strong) NSString   *thoroughfare;
@property (nonatomic, strong) NSString   *subThoroughfare;
@property (nonatomic, strong) CLLocation *currentLocation;

//-(void)updateLocation:(CLLocation *)location;

@end
