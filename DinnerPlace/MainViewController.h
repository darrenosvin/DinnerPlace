//
//  MainViewController.h
//  DinnerPlace
//
//  Created by osvin admin on 7/16/13.
//  Copyright (c) 2013 osvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MainViewController : UIViewController<MKMapViewDelegate,MKAnnotation,CLLocationManagerDelegate>

@property (nonatomic, strong) MKMapView           *mapView;
@property (nonatomic, strong) NSMutableArray      *arrayPlaces;
@property (nonatomic, retain) MKPinAnnotationView *pinAnnotationView ;
@end
