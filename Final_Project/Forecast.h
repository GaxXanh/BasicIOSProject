//
//  Forecast.h
//  Final_Project
//
//  Created by Pham Anh on 3/21/16.
//  Copyright © 2016 com.gaxxanh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Forecast : UIViewController

@property NSString *day;
@property NSString *minTemp;
@property NSString *maxTemp;

- (id) initWithDay:(NSString *)day andMinTemp:(int)minTemp andMaxTemp:(int)maxTemp;

@end
