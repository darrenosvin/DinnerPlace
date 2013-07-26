//
//  NSString+BlueStr.h
//  ContactsList
//
//  Created by osvin admin on 3/14/13.
//  Copyright (c) 2013 ZeroTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BlueStr)

//CheckValidation
- (BOOL) phoneNumberValidationAndRemoveSpecialCharaecter;
- (BOOL) phoneNumberValidation;
- (BOOL) emailValidation;
- (BOOL) urlValidation; 
- (BOOL) empty;

//RemoveSpecialharacter
- (NSString *) removeSepecialCharacter;

/*+--------------------- URLEncode ---------------------+
  |                                                     |
  |                                                     |
  |                                                     |
  |                                                     |
  |                                                     |
  +----------------------------------------------------+*/

  -(NSString *)urlEncode;
  -(NSString *)minimalUrlEncode;

UIKIT_EXTERN NSString * NSStringFromIndexPath(NSIndexPath *);

@end
