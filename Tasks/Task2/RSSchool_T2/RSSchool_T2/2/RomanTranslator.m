#import "RomanTranslator.h"

@implementation RomanTranslator
// your code here
//I             1
//V             5
//X             10
//L             50
//C             100
//D             500
//M             1000

-(instancetype)init {
    self = [super init];
    if (self) {
        // initialize dictionaries of numbers
        _romanDictionary = @{ @1:@"I", @5:@"V", @10:@"X", @50:@"L", @100:@"C", @500:@"D", @1000:@"M" };
        _arabicDictionary = @{ @"I":@1, @"V":@5, @"X":@10, @"L":@50, @"C":@100, @"D":@500, @"M":@1000 };
    }
    return self;
}

- (NSString *)arabicFromRoman:(NSString *)romanString {
    NSString *romanNumber = [[romanString uppercaseString] copy];
    NSInteger romanLenght = romanNumber.length;
    //    NSInteger currentValue = 0;
    NSInteger lastValue = 0;
    NSInteger resultValue = 0;
    
    for (NSInteger i=romanLenght-1; i>=0; i--) {
        NSString *item = [romanNumber substringWithRange:NSMakeRange(i, 1)]; // get only 1 symbol
        NSInteger currentValue = [[self.arabicDictionary valueForKey:item] integerValue]; // extract value from dictionary
        // check the numbers in the neighboring positions to select the correct V,L,C,D value
        if (currentValue < lastValue) {
            resultValue = resultValue - currentValue;
        } else {
            resultValue = resultValue + currentValue;
        }
        lastValue = currentValue;
    }
    
    NSString *resultArabic = [NSString stringWithFormat:@"%@", [NSNumber numberWithInteger:resultValue]];
    return [resultArabic autorelease];
}

- (NSString *)romanFromArabic:(NSString *)arabicString {
    NSString *resultRoman = nil;
    return [resultRoman autorelease];
}

- (void)dealloc
{
    [self.romanDictionary release];
    [self.arabicDictionary release];
    [super dealloc];
}

@end
