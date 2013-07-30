//
//  MapViewController.h
//  DinnerPlace
//
//  Created by Shivangi on 25/07/13.
//  Copyright (c) 2013 osvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface MapViewController : UIViewController<MKMapViewDelegate,MKAnnotation,CLLocationManagerDelegate>

@property (nonatomic, strong) MKMapView           *mapView;
@property (nonatomic, strong) NSMutableArray      *arrayPlaces;
@property (nonatomic, retain) MKPinAnnotationView *pinAnnotationView ;
@property (nonatomic, retain) NSDictionary *dictPlace;

- (id)initWithDict:(NSDictionary *)dict;

@end
