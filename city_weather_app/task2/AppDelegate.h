//
//  AppDelegate.h
//  task2
//
//  Created by Elizaveta on 4/24/19.
//  Copyright © 2019 Elizaveta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

