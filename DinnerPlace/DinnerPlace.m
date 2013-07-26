//
//  DinnerPlace.m
//  DinnerPlace
//
//  Created by osvin admin on 7/22/13.
//  Copyright (c) 2013 osvin. All rights reserved.
//

#import "DinnerPlace.h"

@implementation DinnerPlace

@synthesize coordinate,title,subtitle;
@synthesize tag;
@synthesize address1,address2;
@synthesize comments;
@synthesize placeID;
@synthesize strImgURL;

-(void)dealloc{
    
    [super dealloc];

	[title      release];
    [subtitle   release];
    [address1   release];
    [address2   release];
    [comments   release];
    [placeID    release];
    [strImgURL  release];
}

@end
