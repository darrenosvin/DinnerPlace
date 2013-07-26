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
    self.navigationController.navigationBar.hidden=NO;
    self.navigationController.navigationBar.tintColor=[UIColor blackColor];

}

#pragma mark Back.
-(void)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor colorWithRed:0.7967 green:0.0049 blue:0.0828 alpha:1.0000];
    
    
    CGRect webRect = CGRectMake(0, 42, 320, self.view.bounds.size.height);
    webView = [[UIWebView alloc]initWithFrame:webRect];
    [self.view addSubview:webView];
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
