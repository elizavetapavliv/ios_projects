//
//  ViewController.m
//  task2
//
//  Created by Elizaveta on 4/24/19.
//  Copyright © 2019 Elizaveta. All rights reserved.
//

#import "ViewController.h"
#import "CityInfo.h"

NSDictionary* cities = nil;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *indicator;
@property (weak, nonatomic) IBOutlet UIPickerView *city_picker;
@property (weak, nonatomic) IBOutlet UILabel *country_indicator;
@property (weak, nonatomic) IBOutlet UILabel *monument_indicator;
@property (strong, nonatomic) IBOutlet UIImageView *monument_view;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    cities = @{@"Neapolis" : [[CityInfo alloc] initWithParams:@"Italy" monument: @"Castel Nuovo" image:@"neapolis.jpg" temp: @15],
               @"Florentia" : [[CityInfo alloc] initWithParams:@"Italy" monument: @"Palazzo Pitti" image:@"florentia.jpg" temp: @9],
               @"Amsterdam" : [[CityInfo alloc] initWithParams:@"Netherlands" monument: @"Koninklijk Paleis" image:@"amsterdam.jpg" temp: @-1],
               @"Hague" : [[CityInfo alloc] initWithParams:@"Netherlands" monument: @"Monument Willem Drees" image:@"hague.jpg" temp: @5],
               @"Miami" : [[CityInfo alloc] initWithParams:@"USA" monument:@"Villa Vizcaya" image: @"miami.jpg" temp: @20],
               @"San Francisco" : [[CityInfo alloc] initWithParams:@"USA" monument: @"Pioneer Monument" image:@"san_francisco.jpg" temp: @19] };
    
    self.city_picker.delegate = (id)self;
    self.city_picker.dataSource = (id)self;
    
    [self refresh:self];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return cities.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return cities.allKeys[row];
}

- (IBAction)refresh:(id)sender {
    NSInteger ind = [self.city_picker selectedRowInComponent:0];
    CityInfo* city_info = cities[cities.allKeys[ind]];
    NSNumber* temperature = city_info.temperature;
    
    
    if ([temperature intValue] <  0) {
        [[self indicator] setTextColor:UIColor.blueColor];
    }
    else if ([temperature intValue] > 10) {
        [[self indicator] setTextColor:UIColor.redColor];
    }
    else {
          [[self indicator] setTextColor:UIColor.greenColor];
    }
    
    [[self indicator] setText: [NSString stringWithFormat:@"%@ C", [temperature stringValue]]];
    [[self country_indicator] setText: city_info.country];
    [[self monument_indicator] setText: city_info.monument];
    
    UIImage* monument = [UIImage imageNamed: city_info.monument_image];
    self.monument_view = [[UIImageView alloc] initWithFrame:self.monument_view.frame];
    self.monument_view.contentMode = UIViewContentModeScaleAspectFit;
    self.monument_view.image = monument;
    [self.view addSubview:self.monument_view];
}

@end
