#import "ArrayPrint.h"

@implementation NSArray (RSSchool_Extension_Name)

- (NSString *)print{
    
    NSMutableString *mResultLine = [[NSMutableString alloc] initWithString:@"["];
    
    for (int i=0; i<self.count; i++){
        if ([self[i] isKindOfClass: [NSString class]]){
            [mResultLine appendFormat:@"\"%@\"", self[i]];
        }
        if ([self[i] isKindOfClass: [NSNumber class]]){
            [mResultLine appendFormat:@"%@", [self[i] stringValue]];
        }
        if ([self[i] isKindOfClass: [NSNull class]]){
            [mResultLine appendFormat:@"null"];
        }
        if ([self[i] isKindOfClass: [NSArray class]]){
            [mResultLine appendFormat:@"%@", [self[i] print]];
        }
        if (!([self[i] isKindOfClass: [NSString class]])&!([self[i] isKindOfClass: [NSNumber class]])&!([self[i] isKindOfClass: [NSNull class]])&!([self[i] isKindOfClass: [NSArray class]])){
            [mResultLine appendFormat:@"unsupported"];
        }
        if (i<self.count - 1){
            [mResultLine appendFormat:@","];
        }
    }
    
    [mResultLine appendFormat:@"]"];
    
    NSString *resultLine = [NSString stringWithString:mResultLine];
    
    return resultLine;
}

@end
