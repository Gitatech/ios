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
    NSString *romanNumber = [romanString uppercaseString];
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
    return resultArabic;
}

- (NSString *)romanFromArabic:(NSString *)arabicString {
    // Sort the keys in dictionary in descending order
    NSArray *dictionaryKeys = [self.romanDictionary allKeys];
    NSArray *sortedKeys = [dictionaryKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        int firstItem = (int)[self.romanDictionary objectForKey:obj1];
        int secondItem = (int)[self.romanDictionary objectForKey:obj2];
        return firstItem < secondItem;
//        return [[_romanDictionary objectForKey:obj1] compare:[_romanDictionary objectForKey:obj2]];
    }];
    NSLog(@"get all keys %@", dictionaryKeys);
    NSLog(@"get sorted %@", sortedKeys);
    
    int integerFromArarbic = [arabicString intValue]; // get intValue from the Arabic string
    NSMutableString *resultRomanString = [NSMutableString new];
    
    while (integerFromArarbic > 0) {
        for (NSNumber *item in sortedKeys) {
            // choose the correct item according to the conditions
            NSNumber *part = [NSNumber numberWithInt:1];
            if ([item isEqualToNumber:@(50)] || [item isEqualToNumber:@(100)]) {
                part = [NSNumber numberWithInt:10];
            } else if ([item isEqualToNumber:@(500)] || [item isEqualToNumber:@(1000)]) {
                part = [NSNumber numberWithInt:100];
            }
            
            // extract roman symbols from the dictionary and collect them into resultRomanString
            if (integerFromArarbic - item.intValue >= 0) {
                // TODO:
                [resultRomanString appendString:_romanDictionary[item]];
                integerFromArarbic = integerFromArarbic - item.intValue;
                break;
            } else
                if (integerFromArarbic - item.intValue + part.intValue >= 0) {
                    // TODO:
                    [resultRomanString appendString:self.romanDictionary[part]];
                    [resultRomanString appendString:self.romanDictionary[item]];
                    integerFromArarbic = integerFromArarbic - item.intValue + part.intValue;
                break;
            }
        }
    }
    return [resultRomanString autorelease];
}

- (void)dealloc
{
    // release all the properties
    [_romanDictionary release];
    [_arabicDictionary release];
    [super dealloc];
}

@end
