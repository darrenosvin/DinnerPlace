//
//  EditPlaceViewController.m
//  DinnerPlace
//
//  Created by osvin admin on 7/17/13.
//  Copyright (c) 2013 osvin. All rights reserved.
//

#import "EditPlaceViewController.h"

@interface EditPlaceViewController ()

@end

@implementation EditPlaceViewController


#pragma mark Back...
-(void)back:(id)sender {

//    CATransition *animation = [CATransition animation];
//    [animation setDuration:0.45];
//    [animation setType:kCATransitionPush];
//    [animation setSubtype:kCATransitionFromRight];
//    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
//    [[self.navigationController.view layer] addAnimation:animation forKey:@"SwitchToView1"];

    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark ViewLifeCycle..
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mainBackGround.png"]];
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [topView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"navBar.png"]]];
    [self.view addSubview:topView];

    topView.layer.shadowColor = [[UIColor blackColor] CGColor];
    topView.layer.shadowOffset = CGSizeMake(1.0f, 5.0f);
    topView.layer.shadowRadius = 3.0f;
    topView.layer.shadowOpacity = 0.9f;

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(70, 0, 320-70-65, 40)];
    label.text = @"Edit Place";
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
    [btn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    //  rect = btn.frame;
    [self.view addSubview:btn];	// Do any additional setup after loading the view.

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
