#import "MatrixHacker.h"
// your code here


@implementation MatrixHacker

{
    id<Character> (^hackedBlock)(NSString *name);
}


- (void)injectCode:(id<Character> (^)(NSString *name))theBlock;{
    hackedBlock = theBlock;
}

- (NSArray<id<Character>> *)runCodeWithData:(NSArray<NSString *> *)names;{
    
    NSMutableArray <id<Character>> *mOutputArray = [NSMutableArray <id<Character>> new];
    
    for (NSString *name in names){
        if ([name isEqualToString:@"Neo"]){
            id<Character> character;
            [character setName:hackedBlock(name)];
            [character setIsClone:NO];
            [mOutputArray addObject:character];
            //character = [[character class] createWithName];
        }
        else {
            id<Character> character;
            [character setName:hackedBlock(name)];
            [character setIsClone:YES];
            [mOutputArray addObject:character];
        }
        
    }
    
    NSArray <id<Character>> *outputArray = [mOutputArray copy];
    
    return outputArray;
}

@end
