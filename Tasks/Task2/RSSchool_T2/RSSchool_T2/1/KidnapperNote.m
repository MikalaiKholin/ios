#import "KidnapperNote.h"

@implementation KidnapperNote

- (BOOL)checkMagazine:(NSString *)magaine note:(NSString *)note;{
    
    NSString *magazineInLowercase = [magaine lowercaseString];
    NSArray *wordsInNote = [note componentsSeparatedByString:@" "];
    
    for (NSString *wordInNote in wordsInNote){
        NSString *wordInNoteInLowercase = [wordInNote lowercaseString];
        if (![magazineInLowercase containsString:wordInNoteInLowercase]){
            return NO;
        }
        magazineInLowercase = [magazineInLowercase stringByReplacingOccurrencesOfString:wordInNoteInLowercase withString:@""];
        
    }
    
    return YES;
}

@end
