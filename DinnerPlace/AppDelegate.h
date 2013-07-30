//
//  AppDelegate.h
//  DinnerPlace
//
//  Created by osvin admin on 7/16/13.
//  Copyright (c) 2013 osvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "UserProfile.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RootViewController      *rootViewController;
@property (strong, nonatomic) UINavigationController  *navController;
@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;

@property (strong, nonatomic) FBSession *session;
@property (assign, nonatomic) BOOL fbLogin;

//UserProfile....
@property (strong, nonatomic) UserProfile *userProfile;

//CoreData
@property (readonly, strong, nonatomic) NSManagedObjectContext       *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel         *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

AppDelegate * appDelegate(void);