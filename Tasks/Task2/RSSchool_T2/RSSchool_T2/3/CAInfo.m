//
//  CAInfo.m
//  RSSchool_T2
//
//  Created by Admin on 01.04.2019.
//  Copyright © 2019 Alexander Shalamov. All rights reserved.
//

#import "CAInfo.h"

@implementation CAInfo

- (instancetype)initDate :(NSInteger)years :(NSUInteger)months :(NSUInteger)days
                        :(NSInteger)hours :(NSInteger)minutes :(NSInteger)seconds {
    self = [super init];
    if (self) {
        _years = years;
        _months = months;
        _days = days;
        _hours = hours;
        _minutes = minutes;
        _seconds = seconds;
    }
    return self;
}

@end
