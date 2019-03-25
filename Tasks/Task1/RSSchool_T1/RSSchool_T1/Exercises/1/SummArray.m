#import "SummArray.h"

@implementation SummArray

// Complete the summArray function below.
- (NSNumber *)summArray:(NSArray *)array {
    double summ = 0;
    
    // get the summ of array
    for (NSNumber *item in array) {
        summ += [item doubleValue];
    }
    return [NSNumber numberWithDouble:summ];
}

@end
