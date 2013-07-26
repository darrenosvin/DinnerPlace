//
//  OSCurrentLocation.h
//  Menumam
//
//  Created by osvin admin on 2/26/13.
//  Copyright (c) 2013 osvin admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "OSPlace.h"


@interface OSCurrentLocation : NSObject <CLLocationManagerDelegate>


@property (nonatomic, retain) NSString          *someProperty;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, assign) float lat,lng;
@property (nonatomic, strong) OSPlace *place;

-(void)startUpdatingCurrentLocation;
-(void)stopUpdatingCurrentLocation;
-(BOOL)locationServiceOn;
-(CLAuthorizationStatus )locationAuthorizationStatus;

@end

OSCurrentLocation * OSLocation(void);