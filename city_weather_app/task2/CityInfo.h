//
//  CityInfo.h
//  task2
//
//  Created by Elizaveta on 4/24/19.
//  Copyright © 2019 Elizaveta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityInfo : NSObject

@property (nonatomic, readwrite) NSString* country;
@property (nonatomic, readwrite) NSString* monument;
@property (nonatomic, readwrite) NSString* monument_image;
@property (nonatomic, readwrite) NSNumber* temperature;

-(id)initWithParams: (NSString*) country
           monument: (NSString*) monument
              image: (NSString*) m_image
               temp: (NSNumber*) temp;

@end
