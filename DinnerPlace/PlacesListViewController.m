//
//  PlacesListViewController.m
//  DinnerPlace
//
//  Created by osvin admin on 7/17/13.
//  Copyright (c) 2013 osvin. All rights reserved.
//

#import "PlacesListViewController.h"
#import "WebViewController.h"
#import "Constant.h"
#import "PlaceDetailViewController.h"


#define PADDING 10.0f
#define titleFontSize 20
#define addressFontSize 14
#define webAddressFontSize 12

//AIzaSyDZs3QGSRgvNAK38qJ9WefY-QT-wX2Adzw

@interface PlacesListViewController () {
    
    NSMutableArray *array1;
}

@end

@implementation PlacesListViewController


#pragma mark -  TableView

#pragma mark tableView_delegate&dataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [array1 count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView_ cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSDictionary *dict;
    
    dict  = [array1 objectAtIndex:indexPath.row];

    static NSString *IDIENTIFER = @"IDIENTIFER";

    UITableViewCell *cell = [tableView_ dequeueReusableCellWithIdentifier:IDIENTIFER];

    if (cell ==nil) {

        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:IDIENTIFER];
        
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [cell.textLabel setFont:[UIFont fontWithName:@"arial" size:15]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        
        UILabel *labelCompany=[[UILabel alloc]init];
        labelCompany.backgroundColor=[UIColor clearColor];
        labelCompany.tag=100;
        labelCompany.numberOfLines=0;
        labelCompany.textAlignment = 0;
        labelCompany.lineBreakMode=NSLineBreakByWordWrapping;
        labelCompany.textColor=  [UIColor colorWithRed:0.7967 green:0.0049 blue:0.0828 alpha:1.0000];
        labelCompany.font=[UIFont boldSystemFontOfSize:titleFontSize];
        [cell.contentView addSubview:labelCompany];
        
        
        UILabel *labelAddress=[[UILabel alloc]init];
        labelAddress.backgroundColor=[UIColor clearColor];
        labelAddress.tag=101;
        labelAddress.lineBreakMode=NSLineBreakByWordWrapping;
        labelAddress.numberOfLines=0;
        labelAddress.textColor=[UIColor colorWithRed:0.0875 green:0.1597 blue:0.9491 alpha:1.0000];
        labelAddress.font=[UIFont fontWithName:@"Arial" size:addressFontSize];
        [cell.contentView addSubview:labelAddress];
        
        
        UILabel *labelWebsite=[[UILabel alloc]init];
        labelWebsite.backgroundColor=[UIColor clearColor];
        labelWebsite.tag=102;
        labelWebsite.lineBreakMode=NSLineBreakByWordWrapping;
        labelWebsite.numberOfLines=0;
        labelWebsite.textColor=[UIColor whiteColor];
        labelWebsite.font=[UIFont fontWithName:@"Arial" size:webAddressFontSize];
        [cell.contentView addSubview:labelWebsite];

        
    }
    
    NSString *title = [[array1 objectAtIndex:indexPath.row]objectForKey:@"CompanyName"];;
    NSString *address = [[array1 objectAtIndex:indexPath.row]objectForKey:@"Address"];;
    NSString *websire = [[array1 objectAtIndex:indexPath.row]objectForKey:@"Website"];;
    
    CGSize titleSize = [title sizeWithFont:[UIFont systemFontOfSize:titleFontSize] constrainedToSize:CGSizeMake(tableView_.frame.size.width - PADDING * 2, 1000.0f)];
    
    CGSize addressSize = [address sizeWithFont:[UIFont systemFontOfSize:addressFontSize] constrainedToSize:CGSizeMake(tableView_.frame.size.width - PADDING * 2, 1000.0f)];
    
    CGSize websiteSize = [websire sizeWithFont:[UIFont systemFontOfSize:webAddressFontSize] constrainedToSize:CGSizeMake(tableView_.frame.size.width - PADDING * 2, 1000.0f)];


    UILabel *labelCompany=(UILabel *)[cell viewWithTag:100];
    labelCompany.frame = CGRectMake(10, 0, 310, titleSize.height);
    labelCompany.text=[dict objectForKey:@"CompanyName"];
    labelCompany.textAlignment = 0;

    UILabel *labelAddress=(UILabel *)[cell viewWithTag:101];
    labelAddress.text=[NSString stringWithFormat:@" %@",[dict objectForKey:@"Address"]];
    labelAddress.frame = CGRectMake(10, titleSize.height, 310, addressSize.height);
    
    UILabel *labelWebsite=(UILabel *)[cell viewWithTag:102];
    labelWebsite.text=[dict objectForKey:@"Website"];
    labelWebsite.frame = CGRectMake(10,titleSize.height +addressSize.height, 310, websiteSize.height);

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *title = [[array1 objectAtIndex:indexPath.row]objectForKey:@"CompanyName"];;
    NSString *address = [[array1 objectAtIndex:indexPath.row]objectForKey:@"Address"];;
    NSString *websire = [[array1 objectAtIndex:indexPath.row]objectForKey:@"Website"];;

    CGSize titleSize = [title sizeWithFont:[UIFont systemFontOfSize:20.0f] constrainedToSize:CGSizeMake(tableView.frame.size.width - PADDING * 2, 1000.0f)];
    
    CGSize addressSize = [address sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(tableView.frame.size.width - PADDING * 2, 1000.0f)];
    
    CGSize websiteSize = [websire sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:CGSizeMake(tableView.frame.size.width - PADDING * 2, 1000.0f)];
    
    return titleSize.height + addressSize.height + websiteSize.height + PADDING * 1;

    return 44;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dict=[array1 objectAtIndex:indexPath.row];
    
    
    PlaceDetailViewController *placeDetailViewController = [[PlaceDetailViewController alloc]initWithDict:dict];
    [self.navigationController pushViewController:placeDetailViewController animated:YES];
    [placeDetailViewController release];

    
}

#pragma mark  - ViewLifeCycle.

#pragma mark Back.
-(void)back:(id)sender {

    [self.navigationController popViewControllerAnimated:YES];
}

-(id)initWitharray:(NSMutableArray *)arrayD{

    self = [super init];
    if (self) {
        // Custom initialization

        array1 = [arrayD retain];
    }
    return self;

}

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
    label.text = @"Places";
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

    int height = 0;

    //Table.....
    UITableView   *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, 320, self.view.frame.size.height-height-44) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self; //DataSource.....
    tableView.backgroundColor = [UIColor colorWithRed:0.2601 green:0.2530 blue:0.2532 alpha:0.4];//[UIColor clearColor];
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.separatorColor=[UIColor blackColor];//UIColor colorWithRed:0.2601 green:0.2530 blue:0.2532 alpha:1.0];
    [self.view insertSubview:tableView belowSubview:topView];
    [tableView reloadData];
	//Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
