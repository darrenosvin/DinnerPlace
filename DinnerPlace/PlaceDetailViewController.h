//
//  PlaceDetailViewController.h
//  DinnerPlace
//
//  Created by osvin admin on 7/22/13.
//  Copyright (c) 2013 osvin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceDetailViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UITextViewDelegate>

@property (nonatomic, retain) UITableView    *tableView;
@property (nonatomic, retain) NSMutableArray *arrayComments;
@property (nonatomic, retain) NSDictionary   *place;

- (id)initWithDict:(NSDictionary *)dict;

@end
