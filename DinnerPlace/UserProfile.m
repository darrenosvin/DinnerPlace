//
//  UserProfile.m
//  DinnerPlace
//
//  Created by osvin admin on 7/22/13.
//  Copyright (c) 2013 osvin. All rights reserved.
//



#import "UserProfile.h"


@implementation UserProfile


@synthesize userName;
@synthesize userDOB;
@synthesize userFBId;
@synthesize userImgURL;
@synthesize userGender;
@synthesize userEmail;
@synthesize firstName_;
@synthesize lastName_;

-(void)encodeWithCoder:(NSCoder *)encoder {

    [encoder encodeObject:self.userName.firstName  forKey:@"firstName"];
    [encoder encodeObject:self.userName.lastName   forKey:@"lastName"];
    [encoder encodeObject:self.userName.middleName forKey:@"middleName"];
    [encoder encodeObject:self.userName.fullName   forKey:@"fullName"];

    [encoder encodeObject:self.firstName_    forKey:@"firstName_"]; //lastName_
    [encoder encodeObject:self.lastName_    forKey:@"lastName_"]; 
    [encoder encodeObject:self.userDOB    forKey:@"userDOB"];
    [encoder encodeObject:self.userFBId   forKey:@"userFBId"];
    [encoder encodeObject:self.userImgURL forKey:@"userImgURL"];
    [encoder encodeObject:self.userGender forKey:@"userGender"];
    [encoder encodeObject:self.userEmail  forKey:@"userEmail"];

}

-(id)initWithCoder:(NSCoder *)decoder {
    
    self.userName.firstName  = [decoder decodeObjectForKey:@"firstName"];
    self.userName.lastName   = [decoder decodeObjectForKey:@"lastName"];
    self.userName.middleName = [decoder decodeObjectForKey:@"middleName"];
    self.userName.fullName   = [decoder decodeObjectForKey:@"fullName"];

    self.firstName_  = [decoder decodeObjectForKey:@"firstName_"];
    self.lastName_   = [decoder decodeObjectForKey:@"lastName_"];
    self.userDOB     = [decoder decodeObjectForKey:@"userDOB"];
    self.userFBId    = [decoder decodeObjectForKey:@"userFBId"];
    self.userImgURL  = [decoder decodeObjectForKey:@"userImgURL"];
    self.userGender  = [decoder decodeObjectForKey:@"userGender"];
    self.userEmail   = [decoder decodeObjectForKey:@"userEmail"];
    return self;
    
}

-(void)dealloc {

    [super dealloc];

    [userName   release];
    [userDOB    release];
    [userEmail  release];
    [userGender release];
    [userFBId   release];
    [userImgURL release];
    
}
@end
