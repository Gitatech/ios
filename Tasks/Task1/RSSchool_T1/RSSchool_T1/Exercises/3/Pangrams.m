#import "Pangrams.h"

@implementation Pangrams

// Complete the pangrams function below.
- (BOOL)pangrams:(NSString *)string {
    NSString *alphabet = @"abcdefghijklmnopqrstuvwxyz"; // set up the alphabet string
    Boolean flag = YES;
    
//    NSString *rr = @"Hello world 123456789!";
//    NSLog(@"!!! %@", [rr substringWithRange:NSMakeRange(6, 13)]);
//
    for (int item=0; item<[alphabet length]; item++) {
        // get each symbol from the alphabet string
        // take a substring of length 1 symbol from the position 'item'
        NSString *symbol = [alphabet substringWithRange:NSMakeRange(item, 1)];
        // compare input string on containig of the alphabet item
        if (![[string lowercaseString] containsString:symbol]) {
            flag = NO;
        }
    }
    
//    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyz"];
//    if ([[string lowercaseString] rangeOfCharacterFromSet:set].location == NSNotFound) {
//        flag = NO;
//    }
    return flag;
}

@end
