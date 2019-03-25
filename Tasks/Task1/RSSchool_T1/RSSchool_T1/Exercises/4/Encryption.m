#import "Encryption.h"

@implementation Encryption

// Complete the encryption function below.
- (NSString *)encryption:(NSString *)string {
    // clear text without whitespaces
    NSString *clearText = [[string componentsSeparatedByString:@" "] componentsJoinedByString:@""];
    // text length without spaces
    int textLenght = (int)[clearText length];
    double sqrtLenght = sqrt(textLenght); // sqrt(L)
    
    int row = (int)floor(sqrtLenght); // (round to shorter) length of each word
    int column = (int)ceil(sqrtLenght); // (round to larger) number of levels
   
    // sqrt(L) <= row , row <= column , column <= sqrt(L)
    if (row*column<textLenght){
        row++;
    }
    
    // split the text into the columns
    // fill the array with strings of length of 'column' characters
    NSMutableArray *textArray = [NSMutableArray new];
    for (int item = 0; item<row; item++) {
        int separator = column;
        if (row - 1 == item) {
            separator = textLenght - item*column;
        }
        textArray[item] = [clearText substringWithRange:NSMakeRange(item*column, separator)];
    }
    
    // encrypting
    NSMutableString *ecryptedString = [NSMutableString new];
    for (int k=0; k<column; k++) {
        for (NSString *item in textArray) {
            // get the one symbol of each word and collect them into new combinations
            if ([item length]>k) {
                [ecryptedString appendString:[item substringWithRange:NSMakeRange(k, 1)]];
            }
        }
        [ecryptedString appendString:@" "];
    }
    
    // form the resulting string of the type NSString
    NSString *resultString = [ecryptedString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return resultString;
}

@end
