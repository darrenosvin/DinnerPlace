//
//  WebViewController.h
//  Jewelry
//
//  Created by Shivangi Chaudhary on 31/03/13.
//  Copyright (c) 2013 Shivangi Chaudhary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSString *strURL;


-(id)initWithURL:(NSString *)strURL_;



@end
