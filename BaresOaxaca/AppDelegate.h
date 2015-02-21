//
//  AppDelegate.h
//  BaresOaxaca
//
//  Created by Alberto Cordero Arellanes on 16/02/15.
//  Copyright (c) 2015 AlbertoCorderoArellanes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

NSMutableArray *lblName;
NSMutableArray *imgUser;
NSMutableArray *maDescrip;

NSMutableArray *maLatitud;
NSMutableArray *maLongitud;


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

