//
//  MainViewController.m
//  DinnerPlace
//
//  Created by osvin admin on 7/16/13.
//  Copyright (c) 2013 osvin. All rights reserved.
//

//typedef void(^BottomBack)(NSInteger status,BOOL free);

@protocol BottomViewDelegate;

@interface BottomView : UIView
{
    
}

@property (strong, nonatomic) id <BottomViewDelegate> delegate;
@property(nonatomic,retain) NSMutableArray *arraybutton;

@end

@protocol BottomViewDelegate <NSObject>

-(void)bottomView:(BottomView *)view btnClicked:(UIButton *)btn index:(NSInteger)tag;

@end


@implementation BottomView
@synthesize delegate = _delegate;
@synthesize arraybutton;


-(void)bottomBtnClicked:(id)sender{
    
    NSInteger tag = [sender tag];
    [self.delegate bottomView:self btnClicked:sender index:tag];
    
    NSLog(@"=== bottom tag %i",tag);
    
}
//--

#pragma mark ViewLifeCycle...

-(id)initWithFrame:(CGRect)rect {
    
    self = [super initWithFrame:rect];
    
    arraybutton=[[NSMutableArray alloc]initWithObjects:@"bottomGenre.png",@"bottomPrice.png",@"bottomTag.png", nil];

    if (self) {

        float btnHeight = self.frame.size.height;
        float btnWidth = (320.0-2.0*2.0)/3.0;

        CGRect rect = CGRectMake(0.0, 0.0, btnWidth, btnHeight);

        for (int i =0; i<3; i++) {
            
            //236x80
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectOffset(rect, (i*btnWidth)+(i*2), 0);
            btn.tag = i;
            [btn setBackgroundImage:[UIImage imageNamed:[arraybutton objectAtIndex:i]] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(bottomBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
          //  rect = btn.frame;
            [self addSubview:btn];
            

        }

    }

    return self;
    
}

@end



#import "MainViewController.h"

#import "OperatViewController.h"
#import "PlacesListViewController.h"
#import "PlaceDetailViewController.h"
#import "RouteViewController.h"



#import "RNBlurModalView.h"
#import "DinnerPopupView.h"
#import "DinnerPlace.h"

#import "OSAnnotationView.h"
#import "Place.h"
#import "PlaceMark.h"
#import "MapView.h"
#import "RegexKitLite.h"

@interface MainViewController ()<BottomViewDelegate,DinnerPopupViewDelegate>
{
    CLLocationManager *locationManager;
    CLLocation *locationC;
    MKPolyline *  routeLine;
}


@end

@implementation MainViewController
@synthesize arrayPlaces = _arrayPlaces;
@synthesize mapView;
@synthesize pinAnnotationView;



#pragma mark Show location on map

-(void)showLocationOnMap {
    
    for (NSDictionary *dict in self.arrayPlaces)  {


        static  int i;

        MKCoordinateRegion region = {{0.0, 0.0 }, { 0.0, 0.0 }};

        NSString *lat = [dict objectForKey:@"Latitude"];
        NSString *lng = [dict objectForKey:@"Longitude"];

        if (lat && ![lat empty]) 
            region.center.latitude = [[dict objectForKey:@"Latitude"]doubleValue];

        else {
            i++;
            continue;
        }

        if (lng && ![lng empty])
            region.center.longitude = [[dict objectForKey:@"Longitude"]doubleValue];

        else {
            i++;
            continue;
        }

        region.span.longitudeDelta = 0.2f;
        region.span.latitudeDelta = 0.2f;
        [mapView setRegion:region animated:YES];
       
//        MKCoordinateSpan span;
//        span.latitudeDelta = 0.2;
//        span.longitudeDelta = 0.2;
//       
//        CLLocationCoordinate2D location=mapView.userLocation.coordinate;
//        location.latitude=[[dict objectForKey:@"Latitude"]doubleValue];//30.7363236;
//        location.longitude=[[dict objectForKey:@"Longitude"]doubleValue];//76.7350951;
//        region.span=span;
//        region.center=location;

        //NSLog(@"====== LOcation Found %f %f",location.latitude,location.longitude);

        DinnerPlace *dinnerPlace = [[DinnerPlace alloc] init];
        dinnerPlace.title = [dict objectForKey:@"CompanyName"];
        dinnerPlace.address1=[dict objectForKey:@"Address"];
        dinnerPlace.address2=[dict objectForKey:@"Address2"];

        dinnerPlace.coordinate = region.center;
        dinnerPlace.tag = [[dict objectForKey:@"PlaceID"]integerValue];
        dinnerPlace.placeID = [dict objectForKey:@"PlaceID"];
        dinnerPlace.strImgURL = [dict objectForKey:@"Icon"];
        [mapView addAnnotation:dinnerPlace];

        //----------------- pin Color-----------------------
        UIImage * image =[UIImage imageNamed:@"6.png"];//[UIImage imageNamed:[NSString stringWithFormat:@"%i.png",i+1]];//
        UIImageView *imageView = [[[UIImageView alloc] initWithImage:image]
                                  autorelease];
        [pinAnnotationView addSubview:imageView];
        i++;
                
    }
    
    
}


//-(void)stop{
//    
//      mapView.showsUserLocation=NO;
//    [locationManager stopUpdatingLocation];
//}
//

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay {

    MKOverlayView* overlayView = nil;
    
    MKPolylineView  * _routeLineView = [[[MKPolylineView alloc]initWithPolyline:routeLine] autorelease];
    _routeLineView.fillColor = [UIColor yellowColor];
    _routeLineView.strokeColor = [UIColor purpleColor];
    _routeLineView.lineWidth = 5;
    _routeLineView.lineCap = kCGLineCapSquare;    
    overlayView = _routeLineView;
    
    return overlayView;
    
}

-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation> )annotation {
    
        if (annotation == mapView.userLocation) {
            
            //This code will execute when the current location is called.
             mapView.showsUserLocation = YES;
            //This will show the current location as blue dot in your mapview
            [OSLocation() startUpdatingCurrentLocation];
            return nil;
        }
        else {
                  
            static NSString *defaultPinID = @"com.invasivecode.pin";
            
//            pinAnnotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
//            if ( pinAnnotationView == nil ) pinAnnotationView = [[[MKPinAnnotationView alloc]
//                                              initWithAnnotation:annotation reuseIdentifier:defaultPinID] autorelease];

           OSAnnotationView *view = [[[OSAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:defaultPinID]autorelease];

            //view.animatesDrop=YES;
           //view.canShowCallout = YES;
            
            [view setRightCalloutAccessoryView:[UIButton buttonWithType:UIButtonTypeInfoDark]];
            
            view.callback = ^(id view,id secton){
                
                OSAnnotationView *annotiam = (OSAnnotationView *)view;
                DinnerPlace *ann =   [annotiam annotation];
                
                DinnerPopupView *dinnerPlace = [[DinnerPopupView alloc]initWithFrame:CGRectMake(30, 0, 250, 400)];
                dinnerPlace.delegate = self;
            
                RNBlurModalView *blurModal = [[RNBlurModalView alloc]initWithViewController:self view:dinnerPlace];

                //http://clientdemo.osvin.biz/FindDinnerPlaceapi/FDinnerApi.svc/GetTopComments?PlaceID=2
                
                //Data..
                dinnerPlace.title.text = ann.title;
                dinnerPlace.address1 = ann.address1;
                dinnerPlace.address2 = ann.address2;

                dinnerPlace.tag = ann.tag;

                NSString *strImage = ann.strImgURL;
                strImage =  [strImage stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

                dinnerPlace.imageView.imageURL = [NSURL URLWithString:strImage];
                blurModal.animationDelay = 0.0;
                blurModal.animationDuration = 0.1;

                NSString *strReQuest = [NSString stringWithFormat:@"GetTopComments?PlaceID=%@",ann.placeID];

                [OSRequest sendAsyncReque:YES url:strReQuest completionHandle:^(NSData *data,NSError *error) {

                    NSDictionary *dict = (NSDictionary *)data;

                   NSArray *array = [dict objectForKey:@"GetTopCommentsDetailResult"];
                        
                    
                    dispatch_sync(dispatch_get_main_queue(), ^{

                        [dinnerPlace showComments:array];
                        [dinnerPlace showAddress];

                        [blurModal show];

                        

                    });//end block
                    
                }];
                

                
            };
           
            return view;
            
//            pinAnnotationView.animatesDrop=YES;
//            //pinView.canShowCallout = YES;
//            [pinAnnotationView setRightCalloutAccessoryView:[UIButton buttonWithType:UIButtonTypeInfoDark]];
//            return pinAnnotationView;

            
        }
}

//- (void)mapView:(MKMapView *)view annotationView:(MKAnnotationView *)annotationView calloutAccessoryControlTapped:(UIControl *)control
//{
//    
//    [mapView deselectAnnotation:annotationView.annotation animated:YES];
//    
//    DinnerPopupView *dinnerPlace = [[DinnerPopupView alloc]initWithFrame:CGRectMake(30, 0, 250, 350)];
//    RNBlurModalView *blurModal = [[RNBlurModalView alloc]initWithViewController:self view:dinnerPlace];
//    [blurModal show];
//    
//}



#pragma mark Bottom_Buttons_Delegate....

-(void)bottomView:(id)view btnClicked:(UIButton *)btn index:(NSInteger)tag{

    if (tag == 0) {

    }else if (tag ==1){

    }else if (tag == 2){
        
    }

}

-(void)dinnerPlace:(DinnerPopupView *)view  {

    NSDictionary *dictPlace;
    
    for (NSDictionary *dict in self.arrayPlaces) {


        if ([[dict objectForKey:@"PlaceID"]integerValue] == view.tag) {

            dictPlace = dict;
            break;
        }
        
    }

    PlaceDetailViewController *placeDetailViewController = [[PlaceDetailViewController alloc]initWithDict:dictPlace];
    [self.navigationController pushViewController:placeDetailViewController animated:YES];
    [placeDetailViewController release];
    
}

-(void)showRoot:(DinnerPopupView *)view{

    NSDictionary *dictPlace;

    for (NSDictionary *dict in self.arrayPlaces) {


        if ([[dict objectForKey:@"PlaceID"]integerValue] == view.tag) {

            dictPlace = dict;
            break;
        }
        
    }


    RouteViewController *routViewController = [[RouteViewController alloc]initWithDict:dictPlace];
    [self.navigationController pushViewController:routViewController animated:YES];
    [routViewController release];

}

#pragma mark TopButtonOperation


-(void)topButtonClicked:(id)sender{

    if (![sender tag]) {
        OperatViewController *operatViewController = [[OperatViewController alloc]init];

        [self.navigationController pushViewController:operatViewController animated:YES];
        [operatViewController release];
               
    }else {
        
        PlacesListViewController *placeListViewController = [[PlacesListViewController alloc]initWitharray:self.arrayPlaces];
         [self.navigationController pushViewController:placeListViewController animated:YES];

    }
    
}


#pragma mark touchcontroll

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

}

#pragma mark ViewLifeCycle....

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) {
        // Custom initialization
    }
    
    return self;
}



-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mainBackGround.png"]];

    self.mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
     mapView.delegate=self;
    [self.view addSubview:self.mapView];
     mapView.showsUserLocation = YES;
        
    BottomView *bottomView = [[BottomView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-50, 320, 50)];
    bottomView.delegate =  self;
    [self.view addSubview:bottomView];

    //236x80
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10,10,56,30);
    [btn setBackgroundImage:[UIImage imageNamed:@"back-btn.png"] forState:UIControlStateNormal];
    [btn setTitle:@"opret" forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont fontWithName:@"arial" size:17]];
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
    //move text 10 pixels down and right
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, 8.0f, 0.0f, 0.0f)];
    [btn addTarget:self action:@selector(topButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    //  rect = btn.frame;
    [self.view addSubview:btn];

    //236x80
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(320-70,10,56,30);
    btn.tag = 1;
    [btn setTitle:@"List" forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"back-btn.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(topButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn.titleLabel setFont:[UIFont fontWithName:@"arial" size:17]];
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
    //move text 10 pixels down and right
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(2.0f, 15.0f, 0.0f, 0.0f)];
    [self.view addSubview:btn];


    //GetAllDinnerPlace......
     NSString *strURL = @"GetDinnerPlace";
    
    [OSRequest sendAsyncReque:YES url:strURL completionHandle:^(id data,NSError *error){
        
        NSArray *array = [data objectForKey:@"GetDinnerPlaceResult"];

        if (array.count) {

            self.arrayPlaces = [[NSMutableArray alloc]initWithArray:array];
            [self performSelectorOnMainThread:@selector(showLocationOnMap) withObject:nil waitUntilDone:YES];
        
        }
        
    }];

	// Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
