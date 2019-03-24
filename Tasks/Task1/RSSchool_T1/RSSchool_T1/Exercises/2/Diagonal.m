#import "Diagonal.h"

@implementation Diagonal

// Complete the diagonalDifference function below.
- (NSNumber *) diagonalDifference:(NSArray *)array {
    
    int diagonalDifferenceInt = 0;
    
    for (int i=0; i<array.count; i++) {
        
        NSString *stringLine = array[i];
        NSArray *arrayLine = [stringLine componentsSeparatedByString:@" "];
        diagonalDifferenceInt += [arrayLine[i] integerValue] - [arrayLine[array.count - i - 1] integerValue];
    }
    
    NSNumber *diagonalDifference= [NSNumber numberWithInt:ABS(diagonalDifferenceInt)];
    
    return diagonalDifference;
}

@end
