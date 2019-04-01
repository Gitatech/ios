#import "MatrixHacker.h"

//@interface Character : NSObject <Character>
//
//@property (nonatomic, assign, getter=isClone) BOOL clone;
//@property (nonatomic, copy) NSString *name;
//
//@end

typedef id<Character> (^searchBlock)(NSString *name);

@interface MatrixHacker()

@property (nonatomic, copy) searchBlock myBlock;

@end

@implementation MatrixHacker

- (void)injectCode:(id<Character> (^)(NSString *))theBlock {
    _myBlock = theBlock;
}

- (NSArray<id<Character>> *)runCodeWithData:(NSArray<NSString *> *)names {
    NSMutableArray<id<Character>> *array = [[NSMutableArray new] autorelease];
    for (NSString *name in names) {
//        if (_myBlock != nil) {
            id<Character> myCharacter = _myBlock(name);
            if (_myBlock != nil && [myCharacter.class respondsToSelector:@selector(createWithName:isClone:)]) {
                if ([name isEqualToString:@"Neo"]) {
                    myCharacter = [myCharacter.class createWithName:name isClone:NO];
                } else {
                    myCharacter = [myCharacter.class createWithName:name isClone:YES];
                }
            }
            [array addObject:myCharacter];
//        }
    }
    return array;
}

- (void)dealloc
{
    [_myBlock release];
    [super dealloc];
}

@end
