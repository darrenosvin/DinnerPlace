//
//  OperatViewController.m
//  DinnerPlace
//
//  Created by osvin admin on 7/16/13.
//  Copyright (c) 2013 osvin. All rights reserved.
//

#import "OperatViewController.h"
#import "CreateNewPlaceViewController.h"
#import "EditPlaceViewController.h"

@interface OperatViewController ()

@end

@implementation OperatViewController

#pragma mark Action

-(void)actionBtnClicked:(id)sender  {


    UIViewController *viewController = [[UIViewController alloc]init];

    if (![sender tag]) { //Create

        viewController = [[CreateNewPlaceViewController alloc]init];
        
    }else{ //Edit
        
        viewController = [[EditPlaceViewController alloc]init];
    }

    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark Back
-(void)back:(id)sender {

//    CATransition *animation = [CATransition animation];
//    [animation setDuration:0.45];
//    [animation setType:kCATransitionPush];
//    [animation setSubtype:kCATransitionFromRight];
//    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
//    [[self.navigationController.view layer] addAnimation:animation forKey:@"SwitchToView1"];

    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark ViewLifeCycel

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(70, 0, 320-70-65, 40)];
    label.text = @"Create/Edit";
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
    [self.view addSubview:btn];


    //236x80
  UIButton   *btnCreate = [UIButton buttonWithType:UIButtonTypeRoundedRect];
     btnCreate.frame = CGRectMake(320/2-236/2, 100, 236, 80);
    btnCreate.tag = 0;
    [btnCreate setBackgroundImage:[UIImage imageNamed:@"LoginButton.png"] forState:UIControlStateNormal];
    [btnCreate addTarget:self action:@selector(actionBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnCreate];
    [btnCreate setTitle:@"Create" forState:UIControlStateNormal];
    [btnCreate setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnCreate.titleLabel setFont:[UIFont fontWithName:@"arial" size:35]];

    [self createLabelConstrants:btnCreate];

    //----------
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn2.frame = CGRectOffset(btnCreate.frame, 0, 150);
    btn2.tag = 1;
    [btn2 setBackgroundImage:[UIImage imageNamed:@"LoginButton.png"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(actionBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    [btn2 setTitle:@"Edit" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2.titleLabel setFont:[UIFont fontWithName:@"arial" size:35]];



	// Do any additional setup after loading the view.

    
}

- (void)createLabelConstrants:(UIButton *)label {

    UIView *superview = self.view;
    NSDictionary *variables = NSDictionaryOfVariableBindings(label, superview);
    NSArray *constraints =
    [NSLayoutConstraint constraintsWithVisualFormat:@"V:[superview]-(<=1)-[label]"
                                            options: NSLayoutFormatAlignAllCenterX
                                            metrics:nil
                                              views:variables];
    [self.view addConstraints:constraints];

    constraints =
    [NSLayoutConstraint constraintsWithVisualFormat:@"H:[superview]-(<=1)-[label]"
                                            options: NSLayoutFormatAlignAllCenterY
                                            metrics:nil
                                              views:variables];
    [self.view addConstraints:constraints];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
