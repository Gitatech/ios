#import "KidnapperNote.h"

@implementation KidnapperNote
// your code here
- (BOOL)checkMagazine:(NSString *)magaine note:(NSString *)note {
    BOOL result = NO;
    // create arrays with words from string
    NSArray *magazineWords = [magaine.lowercaseString componentsSeparatedByString:@" "];
    NSArray *noteWords = [note.lowercaseString componentsSeparatedByString:@" "];
    
    // create counted sets for comparing items
    NSCountedSet *magazineSet = [NSCountedSet.new initWithArray:magazineWords];
    NSCountedSet *noteSet = [NSCountedSet.new initWithArray:noteWords];
    
    // remove all objects from note if they are present
    [noteSet minusSet:magazineSet];
    NSInteger counter = noteSet.count;

    if (counter==0) {
        result = YES;
    }
    
    [magazineSet release];
    [noteSet release];
    return result;
}

- (void)dealloc
{
    [super dealloc];
}

@end
