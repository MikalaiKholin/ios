#import "Encryption.h"

@implementation Encryption

// Complete the encryption function below.
- (NSString *)encryption:(NSString *)string {
    
    NSString *stringWithoutSpaces = [string stringByReplacingOccurrencesOfString:@" "
                                                                      withString:@""];
    int row = 0;
    int column = 0;
    
    row = (int)sqrt(stringWithoutSpaces.length);
    
    if (row*row>=stringWithoutSpaces.length){
        column = row;
    }
    else{
        column = row + 1;
    }
    
    NSMutableString *mEncryptedString = [[NSMutableString alloc] initWithString:@""];
    
    for (int i=0; i<column; i++){
        for (int j=0; j<=row; j++){
            if (j*column+i<stringWithoutSpaces.length) {
                [mEncryptedString appendFormat:@"%C", [stringWithoutSpaces characterAtIndex:j*column+i]];
            }
        }
        if (i<column-1){
            [mEncryptedString appendFormat:@" "];
        }
    }
    
    NSString *encryptedString = [NSString stringWithString:mEncryptedString];
    
    return encryptedString;
}

@end
