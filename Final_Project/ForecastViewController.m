//
//  Forecast.m
//  Final_Project
//
//  Created by Pham Anh on 3/21/16.
//  Copyright © 2016 com.gaxxanh. All rights reserved.
//

#import "ForecastViewController.h"
#import "OpenWeatherMapAPI.h"
#import "Forecast.h"

@interface ForecastViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tblForecast;
@property (nonatomic, strong) NSMutableArray *listForecast;

@end

@implementation ForecastViewController 

#pragma mark - View Life Cycle

- (void) viewDidLoad
{
    self.tblForecast.delegate = self;
    self.tblForecast.dataSource = self;
    
    self.navigationItem.title = @"Forecast";
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStyleDone target:self action:@selector(pop)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    [self request];
}

#pragma mark - Private Methods

- (void) pop;
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void) request;
{
    NSString *cityName = [[NSUserDefaults standardUserDefaults] objectForKey:@"City"];
    if (cityName != nil) {
        [sOpenWeatherMapAPI weatherForecastForCityName:cityName completionBlock:^(NSArray *forecastList) {
            _listForecast = [[NSMutableArray alloc] init];
            for (NSDictionary *day in forecastList) {
                
                NSString *_day = [self getDateFromUnixFormat:[day objectForKey:@"dt"]];
                NSDictionary *temp = [day objectForKey:@"temp"];
                int minTemp = [[temp objectForKey:@"max"] intValue];
                int maxTemp = [[temp objectForKey:@"min"] intValue];
                
                Forecast *instanceForecast = [[Forecast alloc] initWithDay:_day andMinTemp:minTemp andMaxTemp:maxTemp];
                [_listForecast addObject:instanceForecast];
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tblForecast reloadData];
            });
        }];
    }
}

- (NSString *) getDateFromUnixFormat:(NSString *)unixFormat
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[unixFormat intValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM"];
    NSString *dte=[dateFormatter stringFromDate:date];
    return dte;
}

#pragma mark - Table View Delegate

#pragma mark - Table View DataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([tableView isEqual:_tblForecast]) {
        return 1;
    }
    return 0;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:_tblForecast]) {
        if (section == 0) {
            return [_listForecast count];
        }
    }
    
    return 0;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [_tblForecast dequeueReusableCellWithIdentifier:@"Cell"];
    UILabel *labelDay = (UILabel *)[cell.contentView viewWithTag:2];
    UILabel *labelMinTemp = (UILabel *)[cell.contentView viewWithTag:3];
    UILabel *labelMaxTemp = (UILabel *)[cell.contentView viewWithTag:4];
    
    Forecast *insForecast = [_listForecast objectAtIndex:indexPath.row];
    labelDay.text = insForecast.day;
    labelMinTemp.text = insForecast.minTemp;
    labelMaxTemp.text = insForecast.maxTemp;
    
    return cell;
}


@end
