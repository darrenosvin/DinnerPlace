//
//  CreateNewPlaceViewController.h
//  DinnerPlace
//
//  Created by osvin admin on 7/17/13.
//  Copyright (c) 2013 osvin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateNewPlaceViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@end
