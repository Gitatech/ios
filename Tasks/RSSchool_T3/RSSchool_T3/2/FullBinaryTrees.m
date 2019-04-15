#import "FullBinaryTrees.h"
// good luck

@implementation FullBinaryTrees

// nodes
// root
// parent
// child - left child - right child
// leaf

// [0,0,0,null,null,0,0,null,null,0,0]

// root item is always be
// 2nd & 3rd are always be
// @[@"0", @"0", @"0", ... ]
// (N-1)/2 - max length of right/left child

- (NSString *)stringForNodeCount:(NSInteger)count {
    if (count == 0 || (count-1)%2 != 0) {
       return [NSString stringWithFormat:@"[]"];
    }

    if (count == 1) {
        return [NSString stringWithFormat:@"[%@]", @"[0]"];
    }

    if (count == 3) {
        return [NSString stringWithFormat:@"[%@]", @[@[@"0",@"0",@"0"]]];
    }

    NSArray *initArray = @[@(0), @(0), @(0)];
    NSMutableArray *treeArray = [[initArray copy] autorelease];
//    for (int i=0; i<(count-1)/2; i++) { // go through layers
//
//    }
    
    NSString *result = [NSString stringWithFormat:@"[%@]", treeArray];
    return result;
}

#pragma mark - trailing null nodes are omitted from the output
-(NSArray *)trimArray:(NSArray *)inputArray {
    NSMutableArray *array = [[inputArray copy] autorelease];
    while ([(NSString *)inputArray.lastObject isEqualToString:@"null"] && inputArray.count > 0) {
        [array removeLastObject];
    }
    return array;
}

@end
