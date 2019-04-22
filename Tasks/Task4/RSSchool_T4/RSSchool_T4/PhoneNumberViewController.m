//
//  PhoneNumberViewController.m
//  RSSchool_T4
//
//  Created by Mikalai Kholin on 21/04/2019.
//  Copyright © 2019 iOSLab. All rights reserved.
//


//


#import "PhoneNumberViewController.h"

@implementation PhoneNumberViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.userInteractionEnabled = YES;
    
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
    
    NSRegularExpression *rx = [NSRegularExpression regularExpressionWithPattern:@"[^0-9]" options:0 error:nil];
    [rx replaceMatchesInString:phoneNumber options:0 range:NSMakeRange(0, [phoneNumber length]) withTemplate:@""];
    //phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    phoneNumber =  [self formatPhoneNumber:phoneNumber];
    
    //NSLog(@"%@", phoneNumber);
    
    //phoneNumberTextField.text = @"";
    phoneNumberTextField.text = [[NSString alloc]initWithString:phoneNumber];
    
    [phoneNumber release];
}

-(NSString*) formatPhoneNumber: (NSString*)number{
    NSArray<Country *> *countries = [[NSArray alloc] initWithArray:[self countriesList]];
    
    NSMutableString *phoneNumberWithFormat = [[NSMutableString alloc] initWithString:@""];
    
    for (Country *country in countries){
        if (country.code.length <= number.length){
            if ([country.code isEqualToString:[number substringToIndex:(country.code.length)]]){
                [phoneNumberWithFormat appendFormat:[self formatLocalPhoneNumber:[number substringFromIndex:country.code.length] :country]];
                NSString *result =[[[NSString alloc] initWithString:phoneNumberWithFormat]autorelease];
                [phoneNumberWithFormat release];
                return result;
            }
        }
    }
    
    [countries release];
    
    [phoneNumberWithFormat appendFormat:@"+"];
    if (number.length>=12){
        [phoneNumberWithFormat appendFormat:(@"%@", [number substringToIndex:12])];
        NSString *result =[[[NSString alloc] initWithString:phoneNumberWithFormat]autorelease];
        [phoneNumberWithFormat release];
        return result;
    }
    [phoneNumberWithFormat appendFormat:(@"%@", number)];
    NSString *result =[[[NSString alloc] initWithString:phoneNumberWithFormat]autorelease];
    [phoneNumberWithFormat release];
    return result;
}

-(NSString*) formatLocalPhoneNumber: (NSString*)number :(Country*) country{
    NSMutableString *phoneNumber = [[NSMutableString alloc] initWithString:@""];
    //[phoneNumber appendFormat:(@"%@", country.flag)];
    //[phoneNumber appendFormat:@"+"];
    //[phoneNumber appendFormat:(@"%@ ", country.code)];
    
    //NSLog(@"number -%@-", number);
    NSString *mask = [NSString new];
    
    
    if (country.numberOfDigitsInPhoneNumber == 8){
        [phoneNumber appendFormat:@"%@+%@", country.flag, country.code];
        mask = @"(xx) xxx-xxx";
    }
    if ((country.numberOfDigitsInPhoneNumber == 9)&!([country.shortName isEqualToString:@"KZ"])){
        [phoneNumber appendFormat:@"%@+%@", country.flag, country.code];
        mask = @"(xx) xxx-xx-xx";
    }
    if ([country.shortName isEqualToString:@"KZ"]){
        [phoneNumber appendFormat:@"%@+%@", country.flag, @"7(7"];
        mask = @"xx) xxx-xx-xx";
    }
    if (country.numberOfDigitsInPhoneNumber == 10){
        [phoneNumber appendFormat:@"%@+%@", country.flag, country.code];
        mask = @"(xxx) xxx-xx-xx";
    }
    
    
    NSLog(@"%@", mask);
    NSLog(@"pn --%@---", phoneNumber);
    
    int j=0;
    for (int i=0; i<number.length; i++){
        if (i>=country.numberOfDigitsInPhoneNumber){
            break;
        }
        //NSLog(@"%@", phoneNumber);
        while (!([[NSString stringWithFormat:@"%c", [mask characterAtIndex:j]] isEqualToString:@"x"])&(j<mask.length-1)){
            [phoneNumber appendFormat:[NSString stringWithFormat:@"%c", [mask characterAtIndex:j]]];
            j++;
            //NSLog(@"%d", j);
        }
        NSLog(@"%@", phoneNumber);
        [phoneNumber appendFormat:[NSString stringWithFormat:@"%c", [number characterAtIndex:i]]];
        NSLog(@"%@", phoneNumber);
        j++;
    }
    NSString *result =[[[NSString alloc] initWithString:phoneNumber]autorelease];
    [phoneNumber release];
    [mask release];
    return result;
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
    NSArray *countries = [[[NSArray alloc] initWithObjects:[[Country alloc]initWithName:@"Kazakhstan" andShortName:@"KZ" andCode:@"77" andFlag:@"🇰🇿" andNumberOfDigitsInPhoneNumber:9],
                           [[Country alloc]initWithName:@"Russia" andShortName:@"RU" andCode:@"7" andFlag:@"🇷🇺" andNumberOfDigitsInPhoneNumber:10],
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
