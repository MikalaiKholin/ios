#import "SummArray.h"

@implementation SummArray

// Complete the summArray function below.
- (NSNumber *)summArray:(NSArray *)array {
    int sumint=0;
    for (NSString *num in array){
        sumint += [num integerValue];
    }
    
    NSNumber *sum = [NSNumber numberWithInt:sumint];

     //NSNumber *sum = [array valueForKeyPath: @"@sum.self"]; lifehack
    
    return sum;
}

@end
