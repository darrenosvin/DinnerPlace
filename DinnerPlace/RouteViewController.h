//
//  RouteViewController.h
//  DinnerPlace
//
//  Created by Shivangi on 20/07/13.
//  Copyright (c) 2013 osvin. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface RouteViewController : UIViewController
@property (nonatomic, assign) NSDictionary *dictionary;

-(id)initWithDict:(NSDictionary *)dict;

@end
