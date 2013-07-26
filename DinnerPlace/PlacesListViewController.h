//
//  PlacesListViewController.h
//  DinnerPlace
//
//  Created by osvin admin on 7/17/13.
//  Copyright (c) 2013 osvin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlacesListViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>


-(id)initWitharray:(NSMutableArray *)arrayD;

@end
