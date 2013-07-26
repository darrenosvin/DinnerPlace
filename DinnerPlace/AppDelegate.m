//
//  AppDelegate.m
//  DinnerPlace
//
//  Created by osvin admin on 7/16/13.
//  Copyright (c) 2013 osvin. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize userProfile;
@synthesize fbLogin;

- (void)dealloc
{
    [_window release];
    [_managedObjectContext release];
    [_managedObjectModel release];
    [_persistentStoreCoordinator release];
    [super dealloc];
}

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize rootViewController = _rootViewController;
@synthesize navController = _navController;
@synthesize session = _session;
@synthesize indicatorView = _indicatorView;

-(void)setFbLogin:(BOOL)fbLogin_ {

    //self.fbLogin = fbLogin_;

    fbLogin = fbLogin_;

    [[NSUserDefaults standardUserDefaults]setBool:fbLogin_ forKey:fbIsLogin];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}

-(void)setUserProfile:(UserProfile *)userProfile_{

    if (self.userProfile != userProfile_) {
        userProfile = [userProfile_ retain];

        NSData  *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:self.userProfile];
        [[NSUserDefaults standardUserDefaults]setObject:myEncodedObject forKey:fbProfile];
        [[NSUserDefaults standardUserDefaults]synchronize];

    }
}

-(void)applicationNetworkReachability {

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateNetworkStatus) name:FXReachabilityStatusDidChangeNotification object:nil];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{


    NSString *path = @"/Applications/Cydia.app";
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:path];

    if (fileExists) {
        //device is jailbroken
        NSLog(@"device is jailbroken");
    } else {
        NSLog(@"device is not jailbroken");

    }
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.

    self.fbLogin = [[NSUserDefaults standardUserDefaults]boolForKey:fbIsLogin];

    if (self.fbLogin) {

        NSData *data =  [[NSUserDefaults standardUserDefaults]objectForKey:fbProfile];
        self.userProfile = [NSKeyedUnarchiver unarchiveObjectWithData:data];

    }

    NSLog(@"fbLogin = %i",self.fbLogin);

    RootViewController *rootViewController = [[RootViewController alloc]init];
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:rootViewController];
    
    navController.navigationBarHidden = YES;
    navController.navigationBar.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"strip.png"]];
    
    [self.window setRootViewController:navController];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];



    //ApplicatonReachabilityStatus...
    [self applicationNetworkReachability];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
      [FBSession.activeSession handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
    [self.session close];

}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // attempt to extract a token from the url
    return [self.session handleOpenURL:url];
}



- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"DinnerPlace" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"DinnerPlace.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end

//AppDelegate Share.......
AppDelegate * appDelegate(void)
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}
