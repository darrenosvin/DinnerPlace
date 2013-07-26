//
//  DisplayMap.h
//  MapKitDisplay
//
//  Created by Chakra on 12/07/10.
//  Copyright 2010 Chakra Interactive Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>



@interface DisplayMap : NSObject <MKAnnotation> {

	CLLocationCoordinate2D coordinate; 
	NSString *title; 
	NSString *subtitle;
    
    UIColor *color;
    NSInteger tag;
    
    

}

@property (nonatomic, assign)  CLLocationCoordinate2D coordinate; 
@property (nonatomic, copy)    NSString *title;
@property (nonatomic, copy)    NSString *subtitle;
@property (nonatomic, copy)    NSString *address;
@property (nonatomic, copy)    NSString *notes;
@property (nonatomic, copy)    NSString *placeID;
@property (nonatomic, retain)  UIColor *color;
@property (nonatomic, assign)    NSInteger tag;


@end
