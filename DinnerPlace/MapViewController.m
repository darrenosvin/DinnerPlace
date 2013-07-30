//
//  MapViewController.m
//  DinnerPlace
//
//  Created by Shivangi on 25/07/13.
//  Copyright (c) 2013 osvin. All rights reserved.
//

#import "MapViewController.h"
#import "DinnerPlace.h"
#import "RNBlurModalView.h"

@interface MapViewController ()
{
    CLLocationManager*locationManager;

}

@end

@implementation MapViewController
@synthesize mapView,arrayPlaces,pinAnnotationView;
@synthesize dictPlace;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    if (self) {
        // Custom initialization
        dictPlace = [dict retain];
        
        NSLog(@" dictPlace ==== %@ ",dictPlace);
        
       
    }
    
    return self;
}


#pragma mark Show location on map

-(void)showLocationOnMap {
    

        static  int i=0;
        
        MKCoordinateRegion region = {{0.0, 0.0 }, { 0.0, 0.0 }};
        
        
        NSLog(@" L1 = %F",[[dictPlace objectForKey:@"Latitude"]doubleValue]);
        NSLog(@"L = %F",[[dictPlace objectForKey:@"Longitude"]doubleValue]);
        
        
        region.center.latitude = [[dictPlace objectForKey:@"Latitude"]doubleValue];
        region.center.longitude = [[dictPlace objectForKey:@"Longitude"]doubleValue];
        region.span.longitudeDelta = 0.2f;
        region.span.latitudeDelta = 0.2f;
        [mapView setRegion:region animated:YES];
        

        DinnerPlace *dinnerPlace = [[DinnerPlace alloc] init];
        dinnerPlace.title = [dictPlace objectForKey:@"CompanyName"];
        dinnerPlace.subtitle=[dictPlace objectForKey:@"Address"];
        dinnerPlace.coordinate = region.center;
        dinnerPlace.tag = i;
        i++;
        [mapView addAnnotation:dinnerPlace];
        
        //----------------- pin Color-----------------------
//        UIImage * image =[UIImage imageNamed:@"4.png"];
//        UIImageView *imageView = [[[UIImageView alloc] initWithImage:image]
//                                  autorelease];
//        [pinAnnotationView addSubview:imageView];

    
    
}




-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation> )annotation {
    
    if (annotation == mapView.userLocation) {
        
        //This code will execute when the current location is called.
      //  mapView.showsUserLocation = YES;
        //This will show the current location as blue dot in your mapview
      //  [OSLocation() startUpdatingCurrentLocation];
        return nil;
    }
    else {
        
        static NSString *defaultPinID = @"com.invasivecode.pin";
        
                    pinAnnotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
                    if ( pinAnnotationView == nil ) pinAnnotationView = [[[MKPinAnnotationView alloc]
                                                      initWithAnnotation:annotation reuseIdentifier:defaultPinID] autorelease];
        
       
        
        pinAnnotationView.animatesDrop=YES;
        pinAnnotationView.canShowCallout = YES;
    
        return pinAnnotationView;
        
        
    }
}



-(void)backBtnClicked{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)showCurrentLoction:(id )sender
{
    NSLog(@"===== showCurrentLoction ");
    
    mapView.showsUserLocation = YES;

    
       
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    
    //mapView.showsUserLocation = YES;
     
}



- (void)viewDidLoad
{
    [super viewDidLoad];

    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mainBackGround.png"]];
    
    self.mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
    mapView.delegate=self;
    [self.view addSubview:self.mapView];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [topView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"navBar.png"]]];
    [self.view addSubview:topView];
    
    topView.layer.shadowColor = [[UIColor blackColor] CGColor];
    topView.layer.shadowOffset = CGSizeMake(1.0f, 5.0f);
    topView.layer.shadowRadius = 3.0f;
    topView.layer.shadowOpacity = 0.9f;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(70, 0, 320-70-65, 40)];
    label.text = @"Map View";
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextAlignment:1];
    [label setTextColor:[UIColor whiteColor]];
    [label setFont:[UIFont boldSystemFontOfSize:17]];
    [self.view addSubview:label];
    
    //236x80
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(5,8,60,30);
    [btn setBackgroundImage:[UIImage imageNamed:@"back-btn.png"] forState:UIControlStateNormal];
    [btn setTitle:@"Back" forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont fontWithName:@"arial" size:17]];
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
    //move text 10 pixels down and right
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(1.5f,10.0f, 0.0f, 0.0f)];
    [btn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    //  rect = btn.frame;
    [self.view addSubview:btn];
    
//    UIButton *btnCurrentLoc = [UIButton buttonWithType:UIButtonTypeCustom];
//    btnCurrentLoc.frame = CGRectMake(219,8,100,30);
//    btnCurrentLoc.backgroundColor=[UIColor colorWithRed:0.4028 green:0.4028 blue:0.4028 alpha:1.0000];
//    [btnCurrentLoc setTitle:@"Current Location" forState:UIControlStateNormal];
//    btnCurrentLoc.titleLabel.lineBreakMode=NSLineBreakByCharWrapping;
//    btnCurrentLoc.titleLabel.font=[UIFont fontWithName:@"Arial" size:12];
//    btnCurrentLoc.layer.borderWidth=1.0f;
//    btnCurrentLoc.layer.borderColor=[UIColor whiteColor].CGColor;
//    btnCurrentLoc.layer.cornerRadius=8.0f;
//    //[btnCurrentLoc setImage:[UIImage imageNamed:@"blankBtn.png"] forState:UIControlStateNormal];
//    [btnCurrentLoc addTarget:self action:@selector(showCurrentLoction:) forControlEvents:UIControlEventTouchUpInside];
//    //rect = btn.frame;
//    [self.view addSubview:btnCurrentLoc];

    [self performSelectorOnMainThread:@selector(showLocationOnMap) withObject:nil waitUntilDone:YES];
    
   	// Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
