#import "ArrayPrint.h"

@implementation NSArray (RSSchool_Extension_Name)

//Input: @[@[@0, @1, @2], [NSNull null], @[@"123",@"456",@"789"], @[@[@[@1337], @{@"Key": @"Value"}]]]
//Output: [[0,1,2],null,["123","456","789"],[[[1337],unsupported]]]

//NSNumber
//NSNull
//NSArray
//NSString
// unsupported

-(NSString *)print {
    NSMutableArray *resultArray = [[NSMutableArray new] autorelease];
    for (id item in self) {
        if ([item isKindOfClass:[NSNumber class]]) {
            NSLog(@"NSNumber item = %@", item);
            [resultArray addObject:[NSString stringWithFormat:@"%@", item]];
        } else
            if ([item isKindOfClass:[NSNull class]]) {
                NSLog(@"NSNull item = %@", item);
                [resultArray addObject:[NSString stringWithFormat:@"%@", @"null"]];
            } else
                if ([item isKindOfClass:[NSArray class]]) {
                    NSLog(@"NSArray item = %@", item);
                    [resultArray addObject:[item print]];
                } else
                    if ([item isKindOfClass:[NSString class]]) {
                        NSLog(@"NSString item = %@", item);
                        [resultArray addObject:[NSString stringWithFormat:@"\"%@\"", item]];
                    } else
                        [resultArray addObject:[NSString stringWithFormat:@"%@", @"unsupported"]];
    }

    NSString *resultString = [NSString stringWithFormat:@"%@%@%@", @"[", [resultArray componentsJoinedByString:@","], @"]"];
    NSLog(@"%@", resultString);
    return resultString;
}

@end
