//
//  OSAnnotationView.h
//  DinnerPlace
//
//  Created by Shivangi on 19/07/13.
//  Copyright (c) 2013 osvin. All rights reserved.
//

#import <MapKit/MapKit.h>

typedef void(^AnnotaionCallBack)(id status,id data);


@interface OSAnnotationView : MKAnnotationView

@property (nonatomic, copy) AnnotaionCallBack callback;

@end
