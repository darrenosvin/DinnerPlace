//
//  RouteViewController.m
//  DinnerPlace
//
//  Created by Shivangi on 20/07/13.
//  Copyright (c) 2013 osvin. All rights reserved.
//

#import "RouteViewController.h"
#import "MapView.h"


@interface RouteViewController ()
{

    NSDictionary *dictionayr;

    
}
@end


@implementation RouteViewController

-(void)showRout {
    
    MapView* mapView = [[[MapView alloc] initWithFrame:
						 CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-44)] autorelease];

	[self.view addSubview:mapView];

    [OSLocation() startUpdatingCurrentLocation];

    if (![OSLocation() locationServiceOn] || [OSLocation() locationAuthorizationStatus] != kCLAuthorizationStatusAuthorized) {

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location Service Disabled"
                                                        message:@"To re-enable, please go to Settings and turn on Location Service for this app."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }
    
    float cuLat = [OSLocation() lat];
    float cuLng = [OSLocation() lng];

    float pLat = [[dictionayr objectForKey:@"Latitude"]floatValue];
    float pLng = [[dictionayr objectForKey:@"Longitude"]floatValue];

    // mapView.showsUserLocation = YES;

    NSLog(@"c %f c  %f plt %f pln %f",cuLat,cuLng,pLat,pLng);

    NSString *currentCountry = OSLocation().place.country;
    NSString *currentArea    = OSLocation().place.administrativeArea;

    Place* home = [[[Place alloc] init] autorelease];
	home.name = currentCountry;
	home.description = currentArea;
	home.latitude = cuLat; //18.9647
	home.longitude = cuLng;  //72.8258

    NSString *strPlace = [dictionayr objectForKey:@"CompanyName"];
    NSString *placeType = [dictionayr objectForKey:@"PlaceType"];

	Place* office = [[[Place alloc] init] autorelease];
	office.name = placeType;
	office.description = strPlace;
	office.latitude = pLat; //18.5236
	office.longitude = pLng; //73.8478

	[mapView showRouteFrom:office to:home];
    
}

-(void)back{

    [self.navigationController popViewControllerAnimated:YES];
}

-(id)initWithDict:(NSDictionary *)dict{
    
    self = [super init];
    if (self) {

        dictionayr = [dict retain];
        NSLog(@" -- %@ --- ",dict);
        
        // Custom initialization
    }
    return self;
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{

    [self showRout];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mainBackGround.png"]];

    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [topView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"navBar.png"]]];
    [self.view addSubview:topView];

    topView.layer.shadowColor = [[UIColor blackColor] CGColor];
    topView.layer.shadowOffset = CGSizeMake(1.0f, 5.0f);
    topView.layer.shadowRadius = 3.0f;
    topView.layer.shadowOpacity = 0.9f;

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    label.text = @"Route";
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextAlignment:1];
    [label setTextColor:[UIColor whiteColor]];
    [label setFont:[UIFont boldSystemFontOfSize:17]];
    [topView addSubview:label];

    //236x80
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(5,8,60,30);
    [btn setImage:[UIImage imageNamed:@"backbtn.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    //rect = btn.frame;
    [self.view addSubview:btn];

	// Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
