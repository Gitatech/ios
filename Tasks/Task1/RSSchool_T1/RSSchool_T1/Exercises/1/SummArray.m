#import "SummArray.h"

@implementation SummArray
// Complete the summArray function below.
- (NSNumber *)summArray:(NSArray *)array {
    NSInteger summ = 0;
    NSLog(@"Array: %@", array);
    
    // get the summ of array
    for (NSNumber *item in array) {
        summ += [item integerValue];
    }
    
    NSLog(@"Summ = %ld", (long)summ);
    return [NSNumber numberWithInteger:summ];
}

@end
