//
//  WebViewController.m
//  Jewelry
//
//  Created by Shivangi Chaudhary on 31/03/13.
//  Copyright (c) 2013 Shivangi Chaudhary. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController
@synthesize  webView;
@synthesize  strURL;



-(id)initWithURL:(NSString *)strURL_
{
    self = [super init];
    
    if (self) {
        
        NSLog(@" urlStr  ============ %@",strURL_);
        strURL =[NSString stringWithString:strURL_];
        // Custom initialization
        
    }
    
    return self;
    
}


#pragma mark- WebViewDelegate


-(void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [appDelegate() stopIndicatorView];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [appDelegate() stopIndicatorView];
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    
    [appDelegate() startIndicatorView];
    
}


#pragma mark- viewLifeCycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) {
        // Custom initialization
    }
    
    return self;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super  viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    //self.navigationController.navigationBar.tintColor=[UIColor blackColor];

}

#pragma mark Back.
-(void)back:(id)sender {

    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [NSThread cancelPreviousPerformRequestsWithTarget:self];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mainBackGround.png"]];

//    self.navigationController.navigationBar.layer.shadowOpacity = 1.0;
//    self.navigationController.navigationBar.layer.shadowColor = [[UIColor blackColor] CGColor];
//    self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(1.0f, 5.0f);
//    self.navigationController.navigationBar.layer.shadowRadius = 3.0f;
//    self.navigationController.navigationBar.layer.shadowOpacity = 0.9f;

    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [topView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"navBar.png"]]];
    [self.view addSubview:topView];

    topView.layer.shadowColor = [[UIColor blackColor] CGColor];
    topView.layer.shadowOffset = CGSizeMake(1.0f, 5.0f);
    topView.layer.shadowRadius = 3.0f;
    topView.layer.shadowOpacity = 0.9f;

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(70, 0, 320-70-65, 40)];
    label.text = @"Places";
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextAlignment:1];
    [label setTextColor:[UIColor whiteColor]];
    [label setFont:[UIFont boldSystemFontOfSize:17]];
    [self.view addSubview:label];

    CGRect webRect = CGRectMake(0, 42, 320, self.view.bounds.size.height);
    webView = [[UIWebView alloc]initWithFrame:webRect];
    webView.backgroundColor = [UIColor clearColor];
    webView.opaque = NO;
    [self.view insertSubview:webView belowSubview:label];
      webView.delegate = self;
    NSURL *url = [NSURL URLWithString:strURL];
     [webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        //ipad
        
        webView.frame=CGRectMake(0, 0, 768, self.view.bounds.size.height-44);
      
    }else
    {
        //iphone
    }
    
    //236x80
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(5,5,60,40);
    [btn setImage:[UIImage imageNamed:@"backbtn.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    //  rect = btn.frame;
    [self.view addSubview:btn];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
