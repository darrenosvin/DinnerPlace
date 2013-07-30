//
//  DinnerPopupView.h
//  DinnerPlace
//
//  Created by osvin admin on 7/17/13.
//  Copyright (c) 2013 osvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RouteViewController.h"

@protocol DinnerPopupViewDelegate;


@interface DinnerPopupView : UIView

@property (nonatomic, retain) id <DinnerPopupViewDelegate> delegate;

@property (nonatomic, retain) AsyncImageView *imageView;

@property (nonatomic, retain) UILabel     *title;
@property (nonatomic, retain) UIView      *addressView;
@property (nonatomic, retain) NSString    *address1;
@property (nonatomic, retain) NSString    *address2;
@property (nonatomic, retain) UIButton    *btnRute;
@property (nonatomic, retain) UIView      *commentsView;

-(void)showComments:(NSArray *)array;
-(void)showAddress;

@end

@protocol DinnerPopupViewDelegate <NSObject>

-(void)dinnerPlace:(DinnerPopupView *)view;
-(void)showRoot:(DinnerPopupView *)view;

@end
