//
//  NSString+BlueStr.m
//  ContactsList
//
//  Created by osvin admin on 3/14/13.
//  Copyright (c) 2013 ZeroTech. All rights reserved.
//

#import "NSString+BlueStr.h"

@implementation NSString (BlueStr)

//Remove allSepecalCharacter

BOOL isWanted(unichar character) {
    
    if(character >= 'a' && character <= 'z')
        return YES;
    if(character >= 'A' && character <= 'Z')
        return YES;
    if(character >= '0' && character <= '9')
        return YES;
    if(character == '-' || character == '+')
        return YES;
    return NO;
    
}

-(NSString *)removeSepecialCharacter {
    
    NSString        *string= self;
    NSMutableString *filteredString=[NSMutableString new];
    
    for(NSUInteger i=0; i<[string length];i++) {
        unichar character=[string characterAtIndex: i];
        if(isWanted(character))
            [filteredString appendString: [NSString stringWithFormat: @"%c",character]];
    }
    NSString *stringFilter = [NSString stringWithString:filteredString];
    [filteredString release];
    return [NSString stringWithString:stringFilter];
}

- (BOOL) phoneNumberValidationAndRemoveSpecialCharaecter {
    
    NSString *phoneNumber = [self removeSepecialCharacter];
    //PhoneNumber
    //NSString *phoneRegex = @"[+-].[235689][0-9]{6}([0-9]{3})?";
    NSString    *phoneRegex = @"[235689][0-9]{6}([0-9]{3})?";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    
    BOOL matches = [test evaluateWithObject:phoneNumber];
    return matches;

}


- (BOOL) urlValidation {
    
    NSString *candidate = self;
    //URLValidation.
    NSString *urlRegEx =
    @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:candidate];
    
}


-(BOOL) emailValidation {
    
    NSString *email = self;
    //EmailValidation
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL isValid = [emailTest evaluateWithObject:email];
    return isValid;
    
}


-(BOOL) phoneNumberValidation  { // NSString * const phoneRegex = @"^([+-]{1})([0-9]{3})$";
   
    NSString *phoneNumber = self;
    
    //PhoneNumber
    //NSString *phoneRegex = @"[+-].[235689][0-9]{6}([0-9]{3})?";
    NSString *phoneRegex = @"[235689][0-9]{6}([0-9]{3})?";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    BOOL matches = [test evaluateWithObject:phoneNumber];
    return matches;
}

- (BOOL) empty {
    
    //Empty..
    NSString       *rawString = self;
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString       *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
   
    if ([trimmed length] == 0 || [trimmed length] < 1) {
        //Text was empty or only whitespace.
         return YES;
    }else{
        // Text was not empty.
        return NO;
    }
    
}


-(BOOL)numericIsValid {
    
    //Validation for numeric.
    NSString    *newText = self;
    NSString    *phoneRegex = @"^(?:|0|[1-9]\\d*)(?:\\.\\d*)?$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
   
    BOOL matches = [test evaluateWithObject:newText];
    return matches;
    
}

#pragma mark URLEncode
/*+--------------------- URLEncode ---------------------+*/

-(NSString *)urlEncode {
	return (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                        (CFStringRef)self,
                                                                        NULL,
                                                                        (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                        kCFStringEncodingUTF8);
}

- (NSString *)minimalUrlEncode {

    return (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                        (CFStringRef)self,
                                                                        NULL,
                                                                        (CFStringRef)@",:",
                                                                        kCFStringEncodingUTF8);
}


NSString * NSStringFromIndexPath(NSIndexPath *indexPath) {

    return [NSString stringWithFormat:@"{%i,%i}",indexPath.section,indexPath.row];
    
}



@end
