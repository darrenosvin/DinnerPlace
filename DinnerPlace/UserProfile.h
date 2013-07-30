//
//  UserProfile.h
//  DinnerPlace
//
//  Created by osvin admin on 7/22/13.
//  Copyright (c) 2013 osvin. All rights reserved.
//


//Name.....
@interface UserName : NSObject 

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *middleName;
@property (nonatomic, strong) NSString *fullName;

@end


//Profile.....
#import <Foundation/Foundation.h>

@interface UserProfile : NSObject <NSCoding>

@property (nonatomic, strong) UserName *userName;

@property (nonatomic, strong) NSString *firstName_;
@property (nonatomic, strong) NSString *lastName_;
@property (nonatomic, strong) NSString *userDOB;
@property (nonatomic, strong) NSString *userFBId;
@property (nonatomic, strong) NSString *userImgURL;
@property (nonatomic, strong) NSString *userGender;
@property (nonatomic, strong) NSString *userEmail;


@end
