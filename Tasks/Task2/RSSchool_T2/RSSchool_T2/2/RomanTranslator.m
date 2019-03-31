#import "RomanTranslator.h"

@implementation RomanTranslator

- (NSString *)romanFromArabic:(NSString *)arabicString;{
    
    int lenthOfNumber = (int)arabicString.length;
    int digit = 0;
    NSString *strDigit;
    NSString *digit1 = @"";
    NSString *digit5 = @"";
    NSString *digit10 = @"";
    NSMutableString *mRomanFromArabic = [[NSMutableString alloc] initWithString:@""];
    
    for ( int i=0; i<lenthOfNumber; i++){
        strDigit = [NSString stringWithFormat:@"%C", [arabicString characterAtIndex:i]];
        digit = [strDigit integerValue];
        switch ((int)lenthOfNumber - i) {
            case 1:
                digit1=@"I";
                digit5=@"V";
                digit10=@"X";
                break;
            case 2:
                digit1=@"X";
                digit5=@"L";
                digit10=@"C";
                break;
            case 3:
                digit1=@"C";
                digit5=@"D";
                digit10=@"M";
                break;
            case 4:
                digit1=@"M";
                digit5=@"";
                digit10=@"";
                break;
            default:
                break;
        }
        
        switch (digit) {
            case 1:
                [mRomanFromArabic appendFormat:@"%@",digit1];
                break;
            case 2:
                [mRomanFromArabic appendFormat:@"%@%@",digit1,digit1];
                break;
            case 3:
                [mRomanFromArabic appendFormat:@"%@%@%@",digit1,digit1,digit1];
                break;
            case 4:
                [mRomanFromArabic appendFormat:@"%@%@",digit1,digit5];
                break;
            case 5:
                [mRomanFromArabic appendFormat:@"%@",digit5];
                break;
            case 6:
                [mRomanFromArabic appendFormat:@"%@%@",digit5,digit1];
                break;
            case 7:
                [mRomanFromArabic appendFormat:@"%@%@%@",digit5,digit1,digit1];
                break;
            case 8:
                [mRomanFromArabic appendFormat:@"%@%@%@%@",digit5,digit1,digit1,digit1];
                break;
            case 9:
                [mRomanFromArabic appendFormat:@"%@%@",digit1,digit10];
                break;
                
            default:
                break;
        }
    }
    
    NSString *romanNumber = [NSString stringWithString:mRomanFromArabic];
    return romanNumber;
}

- (NSString *)arabicFromRoman:(NSString *)romanString;{
    
    int lenthOfNumber = (int)romanString.length;
    int number = 0;
    NSString *strDigit;
    
    for ( int i=lenthOfNumber-1; i>=0; i--){
        
        strDigit = [NSString stringWithFormat:@"%C", [romanString characterAtIndex:i]];
        
        if (([strDigit isEqualToString:@"I"])&(number < 5)){
            number++;
        }
        if (([strDigit isEqualToString:@"I"])&(number >= 5)){
            number--;
        }
        
        if ([strDigit isEqualToString:@"V"]){
            number = number + 5;
        }
        
        if ([strDigit isEqualToString:@"X"]&(number < 50)){
            number = number + 10;
        }
        if ([strDigit isEqualToString:@"X"]&(number >= 50)){
                number = number -10;
        }
        
        if ([strDigit isEqualToString:@"L"]){
            number = number + 50;
        }
        
        if ([strDigit isEqualToString:@"C"]&(number < 500)){
            number = number + 100;
        }
        if ([strDigit isEqualToString:@"C"]&(number >= 500)){
            number = number -100;
        }
                
        if ([strDigit isEqualToString:@"D"]){
            number = number + 500;
        }
        
        if ([strDigit isEqualToString:@"M"]){
            number = number + 1000;
        }
    }
    
    NSString *arabicNumber =[NSString stringWithFormat:@"%d", number];
    return arabicNumber;
    
}

@end
