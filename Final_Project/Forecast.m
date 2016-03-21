//
//  Forecast.m
//  Final_Project
//
//  Created by Pham Anh on 3/21/16.
//  Copyright © 2016 com.gaxxanh. All rights reserved.
//

#import "Forecast.h"

@implementation Forecast

- (id) initWithDay:(NSString *)day andMinTemp:(int)minTemp andMaxTemp:(int)maxTemp;
{
    self = [super init];
    if (self) {
        _day = day;
        _minTemp = [NSString stringWithFormat:@"Min %d ºC", minTemp];
        _maxTemp = [NSString stringWithFormat:@"Max %d ºC", maxTemp];
    }
    return self;
}

@end
