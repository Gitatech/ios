#import "Sorted.h"

@implementation ResultObject
@end

@implementation Sorted

// Complete the sorted function below.
- (ResultObject*)sorted:(NSString*)string {
    ResultObject *value = [ResultObject new];
    NSArray *array = [string componentsSeparatedByString:@" "];

    if ([Sorted isSorted:array]) {
        value.status = YES;
    }
    
    // TODO:
    [Sorted swapArray:array];
    // TODO:
    [Sorted reverseArray:array];
    
    if ([Sorted isSorted:[Sorted swapArray:array]]) {
        value.status = YES;
    } else if ([Sorted isSorted:[Sorted reverseArray:array]]) {
        value.status = YES;
    }
    value.status = NO;
    return value;
}

// check, if inputArray is sorted or not
+ (BOOL)isSorted:(NSArray *)inputArray {
    if ([inputArray count]<=1) {
        return YES;
    }
    
    for (int i=1; i<[inputArray count]; i++) {
        if ([inputArray[i-1] integerValue]>[inputArray[i] integerValue]) {
            return  NO;
        }
    }
    return YES;
}

// check, if inputArray could be sorted by swapping items
+ (NSArray *)swapArray:(NSArray *)inputArray {
    return @[];
}

// check, if inputArray could be sorted by reversing components
+ (NSArray *)reverseArray:(NSArray *)inputArray {
    return @[];
}

@end
