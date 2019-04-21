//
//  PhoneNumberViewController.m
//  RSSchool_T4
//
//  Created by Mikalai Kholin on 21/04/2019.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import "PhoneNumberViewController.h"

@implementation PhoneNumberViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    UITextField *phoneNumber =[[UITextField alloc] initWithFrame:CGRectMake(5, 300, 300, 20)];
    phoneNumber.placeholder = @"Phone Number";
    phoneNumber.layer.borderColor = [UIColor blueColor].CGColor;
    phoneNumber.layer.borderWidth = 1.f;
    phoneNumber.keyboardType = UIKeyboardTypePhonePad;
    //phoneNumber.text=@"37529139";
    [phoneNumber addTarget:self action:@selector(checkPhoneNumberValue:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:phoneNumber];
    
    
    
    [phoneNumber release];
    
    
}

-(void)checkPhoneNumberValue: (UITextField*)phoneNumberTextField {
    
    NSMutableString *phoneNumber = [[[NSMutableString alloc] initWithString:phoneNumberTextField.text]  autorelease];
    
    [phoneNumber replaceCharactersInRange:NSMakeRange(0, [self checkPlusPosition:phoneNumber]) withString:@""];
    [phoneNumber replaceCharactersInRange:NSMakeRange(0, [self checkCountryFlagInPosition:phoneNumber]) withString:@""];
    
    NSRegularExpression *rx = [NSRegularExpression regularExpressionWithPattern:@"[^0-9+]" options:0 error:nil];
    [rx replaceMatchesInString:phoneNumber options:0 range:NSMakeRange(0, [phoneNumber length]) withTemplate:@""];
    phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    phoneNumber = [self textFromNumber:phoneNumber];
    
    NSLog(@"%@", phoneNumber);
    
    phoneNumberTextField.text = @"";
    phoneNumberTextField.text = [[NSString alloc]initWithString:phoneNumber];
    
    [phoneNumber release];
}

-(NSMutableString*) textFromNumber: (NSString*)number{
    NSArray<Country *> *countries = [[NSArray alloc] initWithArray:[self countriesList]];
    
    NSMutableString *phoneNumberWithFormat = [[NSMutableString alloc] initWithString:@""];
    
    for (Country *country in countries){
        if (country.code.length <= number.length){
            if ([country.code isEqualToString:[number substringToIndex:(country.code.length)]]){
                [phoneNumberWithFormat appendFormat:(@"%@", country.flag)];
                [phoneNumberWithFormat appendFormat:@"+"];
                [phoneNumberWithFormat appendFormat:(@"%@ ", country.code)];
                [phoneNumberWithFormat appendFormat:[self phoneNumberFormat:[number substringFromIndex:country.code.length] :country]];
                return phoneNumberWithFormat;
            }
        }
    }
    
    [countries release];
    
    [phoneNumberWithFormat appendFormat:@"+"];
    
    if (number.length>=12){
        [phoneNumberWithFormat appendFormat:(@"%@", [number substringToIndex:12])];
        return phoneNumberWithFormat;
    }
    [phoneNumberWithFormat appendFormat:(@"%@", number)];
    return phoneNumberWithFormat;
}

-(NSMutableString*) phoneNumberFormat: (NSString*)number :(Country*) country{
    
    NSLog(@"%@", country.name);
    NSString *mask = [NSString new];
    
    if (country.numberOfDigitsInPhoneNumber == 8){
        mask = @"(xx) xxx-xxx";
    }
    if (country.numberOfDigitsInPhoneNumber == 9){
        mask = @"(xx) xxx-xx-xx";
    }
    if (country.numberOfDigitsInPhoneNumber == 10){
        mask = @"(xxx) xxx-xx-xx";
    }
    
    NSMutableString *phoneNumber = [[NSMutableString alloc] initWithString:@""];
    NSLog(@"%@", phoneNumber);
    
    int j=0;
    for (int i=0; i<number.length; i++){
        if (i>=country.numberOfDigitsInPhoneNumber){
            return phoneNumber;
        }
        NSLog(@"%@", phoneNumber);
        while (!([[NSString stringWithFormat:@"%c", [mask characterAtIndex:j]] isEqualToString:@"x"])&(j<mask.length-1)){
            [phoneNumber appendFormat:[NSString stringWithFormat:@"%c", [mask characterAtIndex:j]]];
            j++;
            NSLog(@"%d", j);
            //cm = [NSString stringWithFormat:@"%c", [mask characterAtIndex:j]];
        }
        NSLog(@"%@", phoneNumber);
        [phoneNumber appendFormat:[NSString stringWithFormat:@"%c", [number characterAtIndex:i]]];
        NSLog(@"%@", phoneNumber);
        j++;
    }
    
    [mask release];
    return phoneNumber;
}


-(int)checkCountryFlagInPosition: (NSString*)text{
    NSArray<Country *> *countries = [[NSArray alloc] initWithArray:[self countriesList]];
    
    for (int i=text.length-1; i>=0; i--){
        NSString *c = [NSString stringWithFormat:@"%c", [text characterAtIndex:i]];
        for (Country *country in countries){
            if ([country.flag isEqualToString:c]){
                [country release];
                return i;
            }
        }
        [c release];
    }
    return 0;
}

-(int)checkPlusPosition: (NSString*)text{
    for (int i=text.length-1; i>=0; i--){
        NSString *c = [NSString stringWithFormat:@"%c", [text characterAtIndex:i]];
        if ([c isEqualToString:@"+"]){
            return i;
        }
        [c release];
    }
    return 0;
}

-(NSArray*) countriesList{
    NSArray *countries = [[[NSArray alloc] initWithObjects:[[Country alloc]initWithName:@"Russia" andShortName:@"RU" andCode:@"7" andFlag:@"🇷🇺" andNumberOfDigitsInPhoneNumber:10],
                                                          //[[Country alloc]initWithName:@"Kazakhstan" andShortName:@"KZ" andCode:@"7" andFlag:@"🇰🇿" andNumberOfDigitsInPhoneNumber:10],
                                                          [[Country alloc]initWithName:@"Moldova" andShortName:@"MD" andCode:@"373" andFlag:@"🇲🇩" andNumberOfDigitsInPhoneNumber:8],
                                                          [[Country alloc]initWithName:@"Armenia" andShortName:@"AM" andCode:@"374" andFlag:@"🇦🇲" andNumberOfDigitsInPhoneNumber:8],
                                                          [[Country alloc]initWithName:@"Belarus" andShortName:@"BY" andCode:@"375" andFlag:@"🇧🇾" andNumberOfDigitsInPhoneNumber:9],
                                                          [[Country alloc]initWithName:@"Ukraine" andShortName:@"UA" andCode:@"380" andFlag:@"🇺🇦" andNumberOfDigitsInPhoneNumber:9],
                                                          [[Country alloc]initWithName:@"Tajikistan" andShortName:@"TJ" andCode:@"992" andFlag:@"🇹🇯" andNumberOfDigitsInPhoneNumber:9],
                                                          [[Country alloc]initWithName:@"Turkmenistan" andShortName:@"TM" andCode:@"993" andFlag:@"🇹🇲" andNumberOfDigitsInPhoneNumber:8],
                                                          [[Country alloc]initWithName:@"Azerbaijan" andShortName:@"AZ" andCode:@"994" andFlag:@"🇦🇿" andNumberOfDigitsInPhoneNumber:9],
                                                          [[Country alloc]initWithName:@"Kyrgyzstan" andShortName:@"KG" andCode:@"996" andFlag:@"🇰🇬" andNumberOfDigitsInPhoneNumber:9],
                                                          [[Country alloc]initWithName:@"Uzbekistan" andShortName:@"UZ" andCode:@"998" andFlag:@"🇺🇿" andNumberOfDigitsInPhoneNumber:9]
                          , nil] autorelease];
    return countries;
    
}


@end
