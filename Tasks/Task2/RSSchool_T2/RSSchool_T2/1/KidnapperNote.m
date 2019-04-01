#import "KidnapperNote.h"

@implementation KidnapperNote
// your code here
- (BOOL)checkMagazine:(NSString *)magaine note:(NSString *)note {
    
    // create arrays with words from string
    NSMutableArray *magazineWords = [[magaine.lowercaseString copy] componentsSeparatedByString:@" "];
    NSMutableArray *noteWords = [[note.lowercaseString copy] componentsSeparatedByString:@" "];
    
    // create counted sets for comparing items
    NSCountedSet *MagazineSet = [NSCountedSet.new initWithArray:magazineWords];
    NSCountedSet *noteSet = [NSCountedSet.new initWithArray:noteWords];
    
    // remove all objects from note if they are present
    [noteSet minusSet:MagazineSet];
    NSInteger counter = noteSet.count;

    if (counter==0) {
        return YES;
    }
    return NO;
}

@end
