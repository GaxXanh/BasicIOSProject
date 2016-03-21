//
//  OpenWeatherMapAPI.h
//  Final_Project
//
//  Created by Pham Anh on 3/21/16.
//  Copyright © 2016 com.gaxxanh. All rights reserved.
//

#import <UIKit/UIKit.h>

#define sOpenWeatherMapAPI [OpenWeatherMapAPI sharedInstance]

@interface OpenWeatherMapAPI : UIViewController

+ (instancetype) sharedInstance;
- (void) searchWeatherWithCityName:(NSString *)cityName completionBlock:(void(^)(NSDictionary * weather))completion;
- (void) weatherForecastForCityName:(NSString *)cityName completionBlock:(void (^)(NSArray *))completion;

@end


//#import <Foundation/Foundation.h>
//
//#define sSoundCloudAPI [SoundCloudAPI sharedInstance]
//
//@interface SoundCloudAPI : NSObject
//
//+ (instancetype)sharedInstance;
//
//- (void)exploreGenresWithCompletionBlock:(void(^)(NSArray *genreDict))completion;
//
//- (void)exploreTracksWithGenreCode:(NSString *)genreCode offset:(int)offset completionBlock:(void(^)(NSArray *tracks))completion;
//
//- (void)searchTracksWithKeyWord:(NSString *)keyword offset:(int)offset completionBlock:(void(^)(NSArray *tracks))completion;
//
//- (void)autoCompleteWithKeyWord:(NSString *)keyword completionBlock:(void(^)(NSArray *tracks))completion;
//
//@end