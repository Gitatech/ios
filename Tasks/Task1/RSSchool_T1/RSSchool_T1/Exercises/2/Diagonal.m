#import "Diagonal.h"

@implementation Diagonal

// Complete the diagonalDifference function below.
- (NSNumber *) diagonalDifference:(NSArray *)array {
    NSInteger diag1 = 0; // main diagonal items summ
    NSInteger diag2 = 0; // side diagonal items summ
    NSNumber *difference;
    int dim = (int)[array count]; // get matrix dimension
    
//    int counter = 0;
//    for (NSString *row in array) {
//        NSMutableArray *mrarray = [NSMutableArray new];
//        mrarray = [[row componentsSeparatedByString:@" "] mutableCopy];
//        diag1 += [mrarray[counter] integerValue];
//        counter++;
//    }
//
//    int ncounter = (int)[array count] - 1; // n - 1
//    for (NSString *row in array) {
//        NSMutableArray *mrarray = [NSMutableArray new];
//        mrarray = [[row componentsSeparatedByString:@" "] mutableCopy];
//
//        diag2 += [mrarray[ncounter] integerValue];
//        ncounter--;
//    }

    // the same solution, but much shorter
    for (int k=0; k<[array count]; k++) { // go throwgh the matrix
        NSMutableArray *mrarray = [NSMutableArray new];
        mrarray = [[array[k] componentsSeparatedByString:@" "] mutableCopy]; // get the current row
        diag1 += [mrarray[k] integerValue];
        diag2 += [mrarray[dim - 1 - k] integerValue];
    }
    
    difference = [NSNumber numberWithInteger:labs(diag1 - diag2)];
    return difference;
}

@end
