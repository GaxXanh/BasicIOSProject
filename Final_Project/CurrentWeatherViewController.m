//
//  CurrentWeather.m
//  Final_Project
//
//  Created by Pham Anh on 3/21/16.
//  Copyright © 2016 com.gaxxanh. All rights reserved.
//

#import "CurrentWeatherViewController.h"
#import "ForecastViewController.h"
#import "SettingViewController.h"
#import "Constant.h"
#import "OpenWeatherMapAPI.h"

BOOL isFirstTime;

@interface CurrentWeatherViewController ()

@property (weak, nonatomic) IBOutlet UILabel *labelCityName;
@property (weak, nonatomic) IBOutlet UILabel *labelTemperature;
@property (weak, nonatomic) IBOutlet UILabel *labelHumidity;
@property (weak, nonatomic) IBOutlet UILabel *labelMaxTemp;
@property (weak, nonatomic) IBOutlet UILabel *labelMinTemp;
@property (weak, nonatomic) IBOutlet UILabel *labelWindSpeed;

@end

@implementation CurrentWeatherViewController

- (IBAction)showForecastScreen:(id)sender
{
    ForecastViewController *forecastViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ForecastViewController"];
    [self.navigationController pushViewController:forecastViewController animated:YES];
}

- (IBAction)showSettingScreen:(id)sender
{
    SettingViewController *settingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingViewController"];
    [self.navigationController pushViewController:settingViewController animated:YES];
}

#pragma mark - View Life Cycle

- (void) viewDidLoad
{
    isFirstTime = false;
    [self request];
    self.navigationItem.title = @"Weather";
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"City"] != nil ||
        ![[[NSUserDefaults standardUserDefaults] objectForKey:@"City"]  isEqual: @"Hanoi"]) {
        [[NSUserDefaults standardUserDefaults] setValue:@"Hanoi" forKey:@"City"];
    }
}

- (void) viewDidAppear:(BOOL)animated
{
    if (isFirstTime) {
        [self request];
    }
    isFirstTime = true;
}

- (void) viewWillDisappear:(BOOL)animated
{
    [self.labelCityName setText:nil];
    [self.labelTemperature setText:nil];
    [self.labelHumidity setText:nil];
    [self.labelMaxTemp setText:nil];
    [self.labelMinTemp setText:nil];
    [self.labelWindSpeed setText:nil];
}

#pragma mark - Private Methods

- (void) request
{
    NSString *cityName = [[NSUserDefaults standardUserDefaults] objectForKey:@"City"];
    [sOpenWeatherMapAPI searchWeatherWithCityName:cityName
                                  completionBlock:^(NSDictionary *weather) {
                                      
                                      NSDictionary *list = [[weather objectForKey:@"list"] objectAtIndex:0];
                                      NSString *nameCity = [list objectForKey:@"name"];
                                      NSDictionary *main = [list objectForKey:@"main"];
                                      NSInteger temp = [[main objectForKey:@"temp"] intValue];
                                      NSString *tempString = [NSString stringWithFormat:@"Temperature: %ld ºC", (long)temp];
                                      NSInteger humidity = [[main objectForKey:@"humidity"] integerValue];
                                      NSString *humidityString = [NSString stringWithFormat:@"Wind speed: %ld", (long)humidity];
                                      NSInteger maxTemp = [[main objectForKey:@"temp_max"] intValue];
                                      NSString *maxTempString = [NSString stringWithFormat:@"Max Temp: %ld ºC", (long)maxTemp];
                                      NSInteger minTemp = [[main objectForKey:@"temp_min"] intValue];
                                      NSString *minTempString = [NSString stringWithFormat:@"Min Temp: %ld ºC", (long)minTemp];
                                      NSDictionary *wind = [list objectForKey:@"wind"];
                                      CGFloat windSpeed = [[wind objectForKey:@"speed"] floatValue];
                                      NSString *windSpeedString = [NSString stringWithFormat:@"Wind speed: %.2f km/h", windSpeed * 3.6];

                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          
                                          [self.labelCityName setText:nameCity];
                                          [self.labelTemperature setText:tempString];
                                          [self.labelHumidity setText:humidityString];
                                          [self.labelMaxTemp setText:maxTempString];
                                          [self.labelMinTemp setText:minTempString];
                                          [self.labelWindSpeed setText:windSpeedString];
                                          
                                      });
                                  }];
}

@end
