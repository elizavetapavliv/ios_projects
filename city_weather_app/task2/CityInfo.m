//
//  CityInfo.m
//  task2
//
//  Created by Elizaveta on 4/24/19.
//  Copyright © 2019 Elizaveta. All rights reserved.
//

#import "CityInfo.h"

@implementation CityInfo

-(id)initWithParams: (NSString*) country
           monument: (NSString*) monument
              image: (NSString*) m_image
               temp: (NSNumber*) temp  {
    self = [super init];
    self.country = country;
    self.monument = monument;
    self.monument_image = m_image;
    self.temperature = temp;
    return self;
}

@end
