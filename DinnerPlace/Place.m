//
//  Place.m
//
//  Created by kadir pekel on 2/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Place.h"


@implementation Place

@synthesize name;
@synthesize description;
@synthesize latitude;
@synthesize longitude;


+ (instancetype)instanceWithObject:(id)object {

    return  [[self alloc]initWithObject:@"nothing"];
    
}


- (void) dealloc
{
	[name release];
	[description release];
	[super dealloc];
}

@end
