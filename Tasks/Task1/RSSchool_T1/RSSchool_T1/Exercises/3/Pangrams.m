#import "Pangrams.h"

@implementation Pangrams

// Complete the pangrams function below.
- (BOOL)pangrams:(NSString *)string {
    
    NSString *lowerCase = [string lowercaseString];
    
    NSArray *alphabet = @[@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",
                          @"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z"];
    
    for (int i=0; i<alphabet.count; i++) {
        
        if (![lowerCase containsString:alphabet[i]]) {
            return NO;
        }
        
    }
    
    return YES;
}

@end
