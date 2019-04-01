//
//  CAInfo.h
//  RSSchool_T2
//
//  Created by Admin on 01.04.2019.
//  Copyright © 2019 Alexander Shalamov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DoomsdayMachine.h"

NS_ASSUME_NONNULL_BEGIN

@interface CAInfo : NSObject <AssimilationInfo>

@property (nonatomic, readwrite) NSInteger years;
@property (nonatomic, readwrite) NSInteger months;
@property (nonatomic, readwrite) NSInteger weeks;
@property (nonatomic, readwrite) NSInteger days;
@property (nonatomic, readwrite) NSInteger hours;
@property (nonatomic, readwrite) NSInteger minutes;
@property (nonatomic, readwrite) NSInteger seconds;

- (instancetype)initDate :(NSInteger)years :(NSUInteger)months :(NSUInteger)days
                        :(NSInteger)hours :(NSInteger)minutes :(NSInteger)seconds;

@end

NS_ASSUME_NONNULL_END
