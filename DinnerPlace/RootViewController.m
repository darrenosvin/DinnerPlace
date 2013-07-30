//
//  RootViewController.m
//  DinnerPlace
//
//  Created by osvin admin on 7/16/13.
//  Copyright (c) 2013 osvin. All rights reserved.
//

#import "RootViewController.h"
#import "CreateNewPlaceViewController.h"

#import "OSAlertView.h"

@interface RootViewController ()

@end

@implementation RootViewController
@synthesize mainViewController = _mainViewController;


#pragma mark - LoginButtonClicked

-(void)LoginBtnClicked:(id)sender {

//------------

    if ([sender tag]) {

         MainViewController  *mainViewController = [[MainViewController alloc]init];
         self.mainViewController = mainViewController;
         [self.navigationController pushViewController:self.mainViewController animated:YES];
         [mainViewController release];

    }else {
        
        [self facebookLogin];
    }
   
    
}

#pragma mark - MainViewController
-(void)appSuccessfullyLogin {

    MainViewController  *mainViewController = [[MainViewController alloc]init];
    self.mainViewController = mainViewController;
    [self.navigationController pushViewController:self.mainViewController animated:YES];
    [mainViewController release];

}

#pragma mark - Facebook. 

//LOgin user profile.........
- (void)populateUserDetails
{
    
    if ([appDelegate() session].isOpen)
          [FBSession setActiveSession:appDelegate().session];

    if (appDelegate().fbLogin) {
        
        [self appSuccessfullyLogin];
        [appDelegate() stopIndicatorView];
        return ;
    }



    if (appDelegate().session.isOpen) {
 
         [appDelegate() startIndicatorView];

        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {

             if (error) {
                 
                 [appDelegate() stopIndicatorView];
             }

             NSLog(@"firstName = %@",user);

             NSString *firstName = [user objectForKey:@"first_name"];
             NSString *lastName = [user objectForKey:@"last_name"];
             NSString *fbid = [user objectForKey:@"id"];
             NSString *email = [user objectForKey:@"email"];
             NSString *gender = [user objectForKey:@"gender"];
             NSString *birthday = [user objectForKey:@"birthday"];

             if (!firstName || [firstName empty])
                 firstName = firstName;
             
             if (!lastName || [lastName empty])
                    lastName = @"";

             if (!birthday || [birthday empty])
                     birthday = @"not available";

             if (!gender || [gender empty])
                    gender = @"";

             if (!email || [email empty])
                  email = @"";

             NSLog(@"firstName = %@ %@",firstName,lastName);



             NSString *url = [NSString stringWithFormat:@"RegisterUser?facebookID=%@&firstName=%@&lastName=%@&DOB=%@&Gender=%@&emailAddress=%@&deviceID=%@",fbid,firstName,lastName,birthday,gender,email,@"0"];
           
             [OSRequest sendAsyncReque:YES url:url completionHandle:^(id data,NSError *error) {

                 if (error) {


                     
                     return;
                 }

                 NSLog(@"firstName = %@ %@",firstName,lastName);

               UserProfile *userProfile = [[UserProfile alloc]init];

                 if (firstName && ![firstName empty]) {
                     userProfile.userName.firstName = firstName;
                     userProfile.firstName_ = firstName;

                 }
                 else
                     userProfile.userName.firstName = @"";

                 NSLog(@"firstName = %@",userProfile.userName.firstName);
                            
                 if (lastName && ![lastName empty]) 
                     userProfile.userName.lastName = lastName;
                 else
                     userProfile.userName.lastName = @"";

                 if (birthday && ![birthday empty]) 
                     userProfile.userDOB = birthday;
                 else
                     userProfile.userDOB = @"";

                 if (gender && ![gender empty])
                     userProfile.userGender = gender;
                 else
                     userProfile.userGender = @"";

                 if (email && ![email empty])
                     userProfile.userEmail = email;
                 else
                     userProfile.userEmail = @"";
                                           
                    userProfile.userFBId = fbid;

                 appDelegate().userProfile = [userProfile retain];
                                    
                 appDelegate().fbLogin = YES;
                 
                     [self performSelectorOnMainThread:@selector(appSuccessfullyLogin) withObject:nil waitUntilDone:NO];
                 
                 [appDelegate() stopIndicatorView];

             }];

         }];

    }

}

//FacebookLogin

-(void)facebookLogin {

    NSArray *array = [[NSArray alloc]initWithObjects:@"email",@"user_location",@"read_stream",@"publish_stream", nil];

    if (!appDelegate().session.isOpen) {
        
        // create a fresh session object
        appDelegate().session = [[FBSession alloc] initWithPermissions:array];
        // even though we had a cached token, we need to login to make the session usable
        
        [appDelegate().session openWithBehavior:FBSessionLoginBehaviorForcingWebView completionHandler:^(FBSession *session,
                                                                                                         FBSessionState status,
                                                                                                         NSError *error)  {
            
            if (status == FBSessionStateOpenTokenExtended) {
                NSLog(@"FBSessionStateOpenTokenExtended");
            }else if (status == FBSessionStateOpen) {
                NSLog(@"FBSessionStateOpen");
            }else if (status == FBSessionStateClosed) {
                NSLog(@"FBSessionStateClosed");
            }else if (status == FBSessionStateClosedLoginFailed) {
                NSLog(@"FBSessionStateClosedLoginFailed");
            }else if (status == FBSessionStateCreated) {
                NSLog(@"FBSessionStateCreated");
            }else if (status == FBSessionStateCreatedOpening) {
                NSLog(@"FBSessionStateCreatedOpening");
            }else if (status == FBSessionStateCreatedTokenLoaded) {
                NSLog(@"FBSessionStateCreatedTokenLoaded");
            }

            if (error) {
                
                [self.navigationController popViewControllerAnimated:NO];
                return;
            }

            [self populateUserDetails];
            
        }];
        
    }else{//All ReadyOpen

        [self populateUserDetails];
    }

}

#pragma mark -  ViewLifeCycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) {
        // Custom initialization
    }
    
    return self;
}

-(void)viewDidAppear:(BOOL)animated{

    [OSLocation() startUpdatingCurrentLocation];

}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

    [OSLocation() startUpdatingCurrentLocation];

     if (!appDelegate().session.isOpen) {

     }

}

- (void)viewDidLoad
{
    [super viewDidLoad];

   
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mainBackGround.png"]];


    float viewCenter =self.view.center.y;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(320/2-236/2, viewCenter-160, 236, 80);
    btn.tag = 0;
    [btn setBackgroundImage:[UIImage imageNamed:@"LoginButton.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(LoginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"Facebook" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont fontWithName:@"arial" size:35]];
    [self.view addSubview:btn];

    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectOffset(btn.frame, 0, 150);
    btn2.tag =1;
    [btn2 setBackgroundImage:[UIImage imageNamed:@"LoginButton.png"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(LoginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    [btn2 setTitle:@"Facebook In" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2.titleLabel setFont:[UIFont fontWithName:@"arial" size:35]];
    btn2.enabled = NO;

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
