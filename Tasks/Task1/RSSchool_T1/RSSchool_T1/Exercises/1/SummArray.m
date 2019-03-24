#import "SummArray.h"

@implementation SummArray

// Complete the summArray function below.
- (NSNumber *)summArray:(NSArray *)array {
    
    int sumInt=0;
    for (NSString *num in array){
        sumInt += [num integerValue];
    }
    
    NSNumber *sum = [NSNumber numberWithInt:sumInt];

     //NSNumber *sum = [array valueForKeyPath: @"@sum.self"]; lifehack
    
    return sum;
}

@end
