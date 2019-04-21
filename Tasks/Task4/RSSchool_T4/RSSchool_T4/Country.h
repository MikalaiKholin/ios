//
//  Country.h
//  RSSchool_T4
//
//  Created by Mikalai Kholin on 21/04/2019.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Country : NSObject

@property (retain ,nonatomic) NSString *name;
@property (retain ,nonatomic) NSString *shortName;
@property (retain ,nonatomic) NSString * code;
@property (retain ,nonatomic) NSString *flag;
@property (nonatomic) int numberOfDigitsInPhoneNumber;

- (id) initWithName: (NSString*)name andShortName:(NSString*)shortName andCode:(NSString*)code andFlag:(NSString*)flag andNumberOfDigitsInPhoneNumber:(int)numberOfDigitsInPhoneNumber;

@end

NS_ASSUME_NONNULL_END
