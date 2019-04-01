#import "DoomsdayMachine.h"
#import "CAInfo.h"

@implementation DoomsdayMachine

// constatnt value
static NSString *const ZERO_HOUR = @"14 August 2208 03:13:37";

-(id<AssimilationInfo>)assimilationInfoForCurrentDateString:(NSString *)dateString {
    NSDateFormatter *humanDateFormatter = [[NSDateFormatter new] autorelease];
    [humanDateFormatter setDateFormat:@"dd MMMM yyyy HH:mm:ss"];
//    NSString  *assimilationDate = @"14 August 2208 03:13:37";
    NSDate *assimilationDate = [humanDateFormatter dateFromString:ZERO_HOUR];
    
    NSDateFormatter *borgDateFormatter = [[NSDateFormatter new] autorelease];
    [borgDateFormatter setDateFormat:@"yyyy:MM:dd@ss\\mm/HH"];
    
    NSDate *inputDate = [borgDateFormatter dateFromString:dateString];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:(kCFCalendarUnitYear |
                                                         kCFCalendarUnitMonth |
                                                         kCFCalendarUnitDay |
                                                         kCFCalendarUnitHour |
                                                         kCFCalendarUnitMinute |
                                                         kCFCalendarUnitSecond)
                                               fromDate:inputDate
                                                 toDate:assimilationDate
                                                options:0];
    CAInfo *assimilationInfo = [[[CAInfo alloc] initDate:dateComponents.year : dateComponents.month : dateComponents.day : dateComponents.hour : dateComponents.minute : dateComponents.second] autorelease];
//    assimilationInfo.years = dateComponents.year;
//    assimilationInfo.months = dateComponents.month;
//    assimilationInfo.days = dateComponents.day;
//    assimilationInfo.hours = dateComponents.hour;
//    assimilationInfo.minutes = dateComponents.minute;
//    assimilationInfo.seconds = dateComponents.second;
    return assimilationInfo;
}

-(NSString *)doomsdayString {
//    NSString  *zeroHour = @"14 August 2208 03:13:37";
    NSDateFormatter *dateFormatter = [[NSDateFormatter new] autorelease];
    [dateFormatter setDateFormat:@"dd MMMM yyyy HH:mm:ss"];
    
    NSDate *assimilationDate = [dateFormatter dateFromString:ZERO_HOUR];
    NSDateFormatter  *humanDateFormatter = [[NSDateFormatter new] autorelease];
    [humanDateFormatter setDateFormat:@"EEEE, MMMM dd, yyyy"];
    
    NSString *doomsdayResult = [humanDateFormatter stringFromDate:assimilationDate];
    NSLog(@"doomsDay %@", doomsdayResult);
    return doomsdayResult;
}

- (void)dealloc
{
    [super dealloc];
}
@end
