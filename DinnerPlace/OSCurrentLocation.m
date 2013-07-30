//
//  OSCurrentLocation.m
//  Menumam
//
//  Created by osvin admin on 2/26/13.
//  Copyright (c) 2013 osvin admin. All rights reserved.
//

#import "OSCurrentLocation.h"

static OSCurrentLocation *sharedMyManager = nil;


@implementation OSCurrentLocation
@synthesize someProperty;
@synthesize locationManager;
@synthesize lat,lng;
@synthesize place;


#pragma mark - Singleton Methods


+ (id)sharedInstance {
    
    @synchronized(self) {
        
        if(sharedMyManager == nil)
            sharedMyManager = [[super allocWithZone:NULL] init];
    }
    
    return sharedMyManager;
    
}

+ (id)allocWithZone:(NSZone *)zone {
    
    return [[self sharedInstance] retain];
    
}

- (id)copyWithZone:(NSZone *)zone {
    
    return self;
}

- (id)retain {
    
    return self;
}
- (unsigned)retainCount {
    return UINT_MAX; //denotes an object that cannot be released
}
- (oneway void)release {
    // never release
}
- (id)autorelease {
    return self;
}
- (id)init {
    if (self = [super init]) {
        someProperty = [[NSString alloc] initWithString:@"Default Property Value"];
    }
    return self;
}
- (void)dealloc {
    // Should never be called, but just here for clarity really.
    [someProperty release];
    [super dealloc];
}

#pragma mark - Location Service Status.

-(CLAuthorizationStatus )locationAuthorizationStatus {

    return [CLLocationManager authorizationStatus];
}

-(BOOL)locationServiceOn {

    return  [CLLocationManager locationServicesEnabled];
}



#pragma mark - Location Updating.

-(void)startUpdatingCurrentLocation {

    if (!locationManager) {

        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
        [locationManager startUpdatingLocation];

    }else {

          [locationManager startUpdatingLocation];

    }
  
    
}

-(void)stopUpdatingCurrentLocation
{
    [locationManager stopUpdatingLocation];
    
}

#pragma mark - CLLocationManager_Delegate


-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{


}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {

    CLLocation *newLocation = [locations objectAtIndex:0];
    [self locationManagerUpdateLocation:newLocation oldLocation:nil];

}


- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {

    [self locationManagerUpdateLocation:newLocation oldLocation:oldLocation];
        
}

-(void)locationManagerUpdateLocation:(CLLocation *)newLocaion oldLocation:(CLLocation *)oldLocation {


    int degrees = newLocaion.coordinate.latitude;
    double decimal = fabs(newLocaion.coordinate.latitude - degrees);
    int minutes = decimal * 60;
    double seconds = decimal * 3600 - minutes * 60;

    //    NSString *latStr = [NSString stringWithFormat:@"%d° %d' %1.4f\"",
    //                     degrees, minutes, seconds];
    self.lat =   newLocaion.coordinate.latitude;//[latStr floatValue];

    degrees = newLocaion.coordinate.longitude;
    decimal = fabs(newLocaion.coordinate.longitude - degrees);
    minutes = decimal * 60;
    seconds = decimal * 3600 - minutes * 60;
    //    NSString *longt = [NSString stringWithFormat:@"%d° %d' %1.4f\"",
    //                       degrees, minutes, seconds];
    self.lng = newLocaion.coordinate.longitude;//[longt floatValue];


    if (place == nil) {
        place = [[OSPlace alloc]init];
    }
    
    place.currentLocation = newLocaion;

    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:newLocaion completionHandler:^(NSArray *placeMark,NSError *error){


        CLPlacemark *placemark = [placeMark objectAtIndex:0];

        place.ISOCountryCode        = placemark.ISOcountryCode;
        place.country               = placemark.country;
        place.postalCode            = placemark.postalCode;
        place.administrativeArea    = placemark.administrativeArea;
        place.subAdministrativeArea = placemark.subAdministrativeArea;
        place.locality              = placemark.locality;
        place.subLocality           = placemark.subLocality;
        place.thoroughfare          = placemark.thoroughfare;
        place.subThoroughfare       = placemark.subThoroughfare;

//        NSLog(@"ISOCountryCode = %@, country = %@ postalCode= %@ administrativeArea= %@  subAdministrativeArea = %@ locality=  %@ subLocality=  %@ thoroughfare = %@  subThoroughfare = %@  ",ISOCountryCode,country,postalCode,administrativeArea,subAdministrativeArea,locality,subLocality,thoroughfare,subThoroughfare);

    }];

    
}


@end

OSCurrentLocation * OSLocation(void)
{
    return [OSCurrentLocation sharedInstance];
}
