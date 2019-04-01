#import "TinyURL.h"

@implementation TinyURL
// your code here
/*
 URL shortening services like tinyurl.com or vk.cc allow you to enter a URL
 such as https://drive.google.com/file/d/1EBGP1ntXPGVSfYyKGenOdzgh_hna4vg4/view
 and get back a short one such as https://vk.cc/9dEj5S
 
 Design the encode and decode methods for the TinyURL service.
 There is no restriction on how your encode/decode algorithm should work.
 You just need to ensure that a URL can be encoded to a tiny URL
 and the tiny URL can be decoded to the original URL.
 */
static NSString *const ALPHABET = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

- (NSURL *)encode:(NSURL *)originalURL {
    NSString *originalURLString = [originalURL absoluteString];
    NSLog(@"original string = %@", originalURL);
    NSMutableString *encodedString = [[[NSMutableString new] initWithString:originalURLString] autorelease];
    for (NSInteger i=0; i<encodedString.length; i++) {
        [encodedString appendFormat:@"%C", [ALPHABET characterAtIndex:arc4random_uniform((int)[ALPHABET length])]];
    }
    NSLog(@"result string = %@", encodedString);
    NSURL *result = [[NSURL alloc] initWithString:encodedString];
    return result;
}

- (void)dealloc
{
    [super dealloc];
}

@end
