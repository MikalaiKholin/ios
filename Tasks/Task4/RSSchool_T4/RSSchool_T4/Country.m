//
//  Country.m
//  RSSchool_T4
//
//  Created by Mikalai Kholin on 21/04/2019.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import "Country.h"

@implementation Country

- (id) initWithName: (NSString*)name andShortName:(NSString*)shortName andCode:(NSString*)code andFlag:(NSString*)flag andNumberOfDigitsInPhoneNumber:(int)numberOfDigitsInPhoneNumber;{
    _name = name;
    _shortName = shortName;
    _code = code;
    _flag = flag;
    _numberOfDigitsInPhoneNumber = numberOfDigitsInPhoneNumber;
    return self;
}

@end
