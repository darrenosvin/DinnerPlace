//
//  CreateNewPlaceView.m
//  DinnerPlace
//
//  Created by osvin admin on 7/22/13.
//  Copyright (c) 2013 osvin. All rights reserved.
//

#import "CreateNewPlaceView.h"

@interface CreateNewPlaceView ()
{
    NSArray *title,*placeHolder;

}
@end

@implementation CreateNewPlaceView

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    self.tableView.frame = CGRectMake(0, 100, 320, self.view.bounds.size.height-100);
}

- (void)viewDidLoad
{
    [super viewDidLoad];


    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mainBackGround.png"]];

    title = [@[@"Company Name :",@"Website :",@"Address :",@""]retain];
    placeHolder = [@[@"company name",@"url",@"address",@""]retain];;

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    label.text = @"Create New Place";
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextAlignment:1];
    [label setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"navBar.png"]]];
    [label setTextColor:[UIColor orangeColor]];
    [label setFont:[UIFont boldSystemFontOfSize:17]];
    [self.view.superview insertSubview:label aboveSubview:self.tableView];

    //    //236x80
    //    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    btn.frame = CGRectMake(5,8,60,30);
    //    [btn setImage:[UIImage imageNamed:@"backbtn.png"] forState:UIControlStateNormal];
    //    [btn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    //    //  rect = btn.frame;
    //    [self.view addSubview:btn];

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

    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(320-61,8,56,30);
    [btn setBackgroundImage:[UIImage imageNamed:@"back-btn.png"] forState:UIControlStateNormal];
    [btn setTitle:@"Done" forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont fontWithName:@"arial" size:17]];
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
    //move text 10 pixels down and right
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(1.5f, 9.0f, 0.0f, 0.0f)];
    [btn addTarget:self action:@selector(doneClicked) forControlEvents:UIControlEventTouchUpInside];
    //  rect = btn.frame;
    [self.view addSubview:btn];
    


    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...

    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

    if (cell == nil) {

    if (indexPath.row == 3) {

        UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [sendBtn setBackgroundImage:[UIImage imageNamed:@"LoginButton.png"] forState:UIControlStateNormal];
        [sendBtn setTitle:@"Send Request" forState:UIControlStateNormal];
        sendBtn.frame=CGRectMake(320/2-236/2, 0, 236, 80); //120,40
        [sendBtn addTarget:self action:@selector(sendButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:sendBtn];
        [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sendBtn.titleLabel setFont:[UIFont fontWithName:@"arial" size:18]];

    }else if (indexPath.row == 2)  {

        UILabel *Labelcompany=[[UILabel alloc]init];
        Labelcompany.frame=CGRectMake(20, 0,  320-40, 20);
        Labelcompany.backgroundColor=[UIColor clearColor];
        Labelcompany.textColor = [UIColor colorWithRed:0.5943 green:0.0000 blue:0.0487 alpha:1.0000];
        Labelcompany.font = [UIFont fontWithName:@"Arial" size:18];
        Labelcompany.font = [UIFont boldSystemFontOfSize:18];

        //            Labelcompany.layer.shadowPath = [UIBezierPath bezierPathWithRect:Labelcompany.bounds].CGPath;
        //            Labelcompany.layer.shadowColor = [UIColor blackColor].CGColor;
        //            Labelcompany.layer.shadowOffset = CGSizeMake(1.0, 2.0);
        //            Labelcompany.layer.shadowOpacity = 0.8;

        Labelcompany.text = [title objectAtIndex:indexPath.row];
        Labelcompany.textAlignment=0;
        [cell.contentView addSubview:Labelcompany];


        UITextView *textField = [[UITextView alloc]init];
        textField.frame=CGRectMake(20, 20, 320-40, 75);
        textField.backgroundColor = [UIColor whiteColor];
        textField.keyboardType=UIKeyboardTypeDefault;
        textField.returnKeyType = UIReturnKeyNext;
        textField.tag = 101;
        textField.textInputView.contentMode = UIViewContentModeCenter;
        //textField.textAlignment=NSTextAlignmentCenter;
        textField.delegate = self;
        textField.text = @"";
        [cell.contentView addSubview:textField];


    }else{

        UILabel *Labelcompany=[[UILabel alloc]init];
        Labelcompany.frame=CGRectMake(20, 0,  320-40, 20);
        Labelcompany.backgroundColor=[UIColor clearColor];
        Labelcompany.textColor = [UIColor colorWithRed:0.5943 green:0.0000 blue:0.0487 alpha:1.0000];
        Labelcompany.font = [UIFont fontWithName:@"Arial" size:18];
        Labelcompany.font = [UIFont boldSystemFontOfSize:18];

        Labelcompany.text = [title objectAtIndex:indexPath.row];
        Labelcompany.textAlignment=0;
        [cell.contentView addSubview:Labelcompany];

        UITextField *textField = [[UITextField alloc]init];
        textField.frame=CGRectMake(20, 20, 320-40, 40);
        textField.placeholder = @"";
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.backgroundColor = [UIColor whiteColor];
        textField.keyboardType=UIKeyboardTypeDefault;
        textField.returnKeyType = UIReturnKeyNext;
        textField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        textField.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
        textField.tag = 101;
        textField.textAlignment=NSTextAlignmentCenter;
        textField.delegate = self;
        textField.placeholder = [placeHolder objectAtIndex:indexPath.row];
        textField.text = @"";
        [cell.contentView addSubview:textField];

    }

    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;


    }
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
