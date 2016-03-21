//
//  OpenWeatherMapAPI.m
//  Final_Project
//
//  Created by Pham Anh on 3/21/16.
//  Copyright © 2016 com.gaxxanh. All rights reserved.
//

#import "OpenWeatherMapAPI.h"
#import "Constant.h"

@interface OpenWeatherMapAPI ()

@property NSURLSession *session;

@end

@implementation OpenWeatherMapAPI

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static OpenWeatherMapAPI *sharedInstance;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[OpenWeatherMapAPI alloc]init];
    });
    
    return sharedInstance;
}

- (instancetype) init
{
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration: configuration];
        
    }
    
    return self;
}

#pragma mark - Search Country

- (void) searchWeatherWithCityName:(NSString *)cityName completionBlock:(void (^)(NSDictionary *))completion
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:kOpenWeatherMapExploreCountryName, cityName, kOpenWeatherMapAppID]];
    NSURLSessionDataTask *dataTask = [_session dataTaskWithURL: url
                                             completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                 if (data != nil) {
                                                     NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                                                     completion(result);
                                                 } else if (error != nil) {
                                                     NSLog(@"Error: %@", error);
                                                 }
                                             }];
    [dataTask resume];
}

#pragma mark - Weather Forecast

- (void) weatherForecastForCityName:(NSString *)cityName completionBlock:(void (^)(NSArray *))completion;
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:kOpenWeatherMapExploreForecast, cityName, @(kOpenWeatherMapForecastDefaultLimit), kOpenWeatherMapAppID]];
    NSURLSessionDataTask *dataTask = [_session dataTaskWithURL:url
                                             completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                 if (data != nil) {
                                                     NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                                                     NSArray *forecastList = [result objectForKey:@"list"];
                                                     completion(forecastList);
                                                 } else if (error != nil) {
                                                     NSLog(@"Error: %@", error);
                                                 }
                                             }];
    [dataTask resume];
}
@end
