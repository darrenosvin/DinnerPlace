//
//  CreateNewPlaceViewController.m
//  DinnerPlace
//
//  Created by osvin admin on 7/17/13.
//  Copyright (c) 2013 osvin. All rights reserved.
//

#import "CreateNewPlaceViewController.h"

@interface CreateNewPlaceViewController ()
{
    UITextField *hideTextField;
    UITextField *webField,*companyField;
    UITextView *addField;
    
    UIView*mainView;
    UIButton *btnDone;

    NSArray *title,*placeHolder;

    id activeField;
}

@end

@implementation CreateNewPlaceViewController
@synthesize tableView;



-(void)sendButtonClicked:(id)sender
{

    NSString *companyName = companyField.text;
    NSString *website = webField.text;
    NSString *address = addField.text;

    if (companyName && ![companyName empty]) {


        
    }else{

        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"All Field is required" message:@"Enter company name" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return;
        
    }

    if (website && ![website empty]) {

       
    }else{

        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"All Field is required" message:@"Enter company website" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
         return;
    }

    if (address && ![address empty]) {

        
    }else{

        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"All Field is required" message:@"Enter company address" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
         return;
    }

    NSString *fbID = appDelegate().userProfile.userFBId;
    NSString *emailAddress = appDelegate().userProfile.userEmail;

    if (!emailAddress) {

        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Email address is not able to found in Facebook account." delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
         return;
    }

//http://clientdemo.osvin.biz/FindDinnerPlaceapi/FDinnerApi.svc/AddDinnerPlace?CompanyName=kamal%20place&Address=Palace&Website=http://www.palace.com&PlaceType=hotel&EmailAddress=sahilsweets@yahoo.com

    NSString *strURL = [NSString stringWithFormat:@"AddDinnerPlace?CompanyName=%@&Address=%@&Website=%@&PlaceType=%@&EmailAddress=%@",companyName,address,website,@"company",emailAddress];

    [OSRequest sendAsyncReque:YES url:strURL completionHandle:^(id data, NSError *error){


        if (error) {

            return ;
        }

        if (data) {

            
        }

    }];
    
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

#pragma mark ContentView


-(void)addCreateLabelOnView
{
    
    mainView=[[UIView alloc]initWithFrame:CGRectMake(0, 50, 320, 300)];
    mainView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:mainView];
    
    float y;

    if (IS_IPHONE_5) {
        y = 30;
    }else{
        y = 30;
    }
    
    UILabel *Labelcompany=[[UILabel alloc]init];
    Labelcompany.frame=CGRectMake(0, y, 320, 30);
    Labelcompany.backgroundColor=[UIColor clearColor];
    Labelcompany.textColor=[UIColor colorWithRed:0.5943 green:0.0000 blue:0.0487 alpha:1.0000];
    Labelcompany.font=[UIFont fontWithName:@"Arial" size:18];
    Labelcompany.text=@"Company Name :";
    Labelcompany.textAlignment=1;
    [mainView addSubview:Labelcompany];
    

    if (IS_IPHONE_5) {
        y = 100;
    }else{
        y = 100;
    }


  


    UILabel *LabelWebsite=[[UILabel alloc]init];
    LabelWebsite.frame=CGRectMake(0, y, 320, 30);
    LabelWebsite.backgroundColor=[UIColor clearColor];
    LabelWebsite.font=[UIFont fontWithName:@"Arial" size:18];
    LabelWebsite.textColor=[UIColor colorWithRed:0.5943 green:0.0000 blue:0.0487 alpha:1.0000];
    LabelWebsite.text=@"Website :";
    LabelWebsite.textAlignment=1;
    [mainView addSubview:LabelWebsite];

    if (IS_IPHONE_5) {
        y = 170;
    }else{
        y = 170;
    }
    
    UILabel *LabelAddress=[[UILabel alloc]init];
    LabelAddress.frame=CGRectMake(0, y, 320, 30);
    LabelAddress.backgroundColor=[UIColor clearColor];
    LabelAddress.textColor=[UIColor colorWithRed:0.5943 green:0.0000 blue:0.0487 alpha:1.0000];
    LabelAddress.font=[UIFont fontWithName:@"Arial" size:18];
    LabelAddress.text=@"Address :";
    LabelAddress.textAlignment=1;
    [mainView addSubview:LabelAddress];
       

    if (IS_IPHONE_5) {
        y = 60;
    }else{
        y = 60;
    }

    companyField = [[UITextField alloc]init];
    companyField.frame=CGRectMake(40, y, 240, 44);
    companyField.placeholder = @"";
    companyField.borderStyle = UITextBorderStyleRoundedRect;
    companyField.backgroundColor = [UIColor whiteColor];
    companyField.keyboardType=UIKeyboardTypeDefault;
    companyField.returnKeyType = UIReturnKeyNext;
    companyField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    companyField.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    companyField.tag = 101;
    companyField.textAlignment=NSTextAlignmentCenter;
    companyField.delegate = self;
    companyField.text = @"";
    [mainView addSubview:companyField];

    if (IS_IPHONE_5) {
        y = 130;
    }else{
        y = 130;
    }

    webField = [[UITextField alloc]init];
    webField.frame=CGRectMake(40, y, 240, 44);
    webField.placeholder = @"";
    webField.borderStyle = UITextBorderStyleRoundedRect;
    webField.backgroundColor = [UIColor whiteColor];
    webField.keyboardType=UIKeyboardTypeDefault;
    webField.returnKeyType = UIReturnKeyDone;
    webField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    webField.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    webField.tag = 103;
    webField.textAlignment=NSTextAlignmentCenter;
    webField.delegate = self;
    webField.text = @"";
    [mainView addSubview:webField];

    

    if (IS_IPHONE_5) {
        y = 200;
    }else{
        y = 200;
    }

    
    
    addField = [[UITextField alloc]init];
    addField.frame=CGRectMake(40, y, 240, 44);
    addField.backgroundColor = [UIColor whiteColor];
    addField.keyboardType=UIKeyboardTypeDefault;
    addField.returnKeyType = UIReturnKeyNext;
    addField.tag = 102;
    addField.textAlignment=NSTextAlignmentCenter;
    addField.delegate = self;
    addField.text = @"";
    [mainView addSubview:addField];
    
    
    if (IS_IPHONE_5) {
        y = 250;
    }else{
        y = 250;
    }




}

-(void)doneClicked
{
    [activeField resignFirstResponder];

}

#pragma mark TableViewDelegate/DataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{


    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView_ cellForRowAtIndexPath:(NSIndexPath *)indexPath{

     NSString *Idintifer  = [NSString stringWithFormat:@"tableViewIDINtifer%i%i",indexPath.row,indexPath.section];

    UITableViewCell *cell = [tableView_ dequeueReusableCellWithIdentifier:Idintifer];

    if (cell == nil) {

        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Idintifer];

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

            textField.keyboardType = UIKeyboardTypeDefault;

            addField = textField;

            [cell.contentView addSubview:addField];



        }else  if (indexPath.row == 1) {

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
            textField.returnKeyType = UIReturnKeyDone;
            textField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
            textField.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
            textField.tag = 101;
            textField.textAlignment=NSTextAlignmentCenter;
            textField.delegate = self;
            textField.placeholder = [placeHolder objectAtIndex:indexPath.row];
            textField.text = @"";
                textField.keyboardType = UIKeyboardTypeURL;
            textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
            webField = textField;
            [cell.contentView addSubview:webField];
            
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
            textField.returnKeyType = UIReturnKeyDone;
            textField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
            textField.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
            textField.tag = 101;
            textField.textAlignment=NSTextAlignmentCenter;
            textField.delegate = self;
            textField.placeholder = [placeHolder objectAtIndex:indexPath.row];
            textField.text = @"";
            textField.keyboardType = UIKeyboardTypeDefault;

            companyField = textField;
            [cell.contentView addSubview:companyField];

        }

        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
      
    }

    

    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 3) {
        
        return 85;
    }else if (indexPath.row == 2 )
    {
        return 105;

    }else
        return 65;
}

-(void)keyboardWillShow:(NSNotificationCenter *)notificationCenter{

    btnDone.enabled = YES;

    float height;

    if (IS_IPHONE_5) {
        height = 288;
    }else{
        height = 200;
    }

    [UIView animateWithDuration:0.5 animations:^{

        tableView.frame = CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y, tableView.frame.size.width, height);

    }completion:^(BOOL finshied){

        
    }];

}

-(void)keyboardWillHide:(NSNotificationCenter *)notificationCenter{

    activeField = nil;
    btnDone.enabled = NO;


    [UIView animateWithDuration:0.5 animations:^{

        tableView.frame = CGRectMake(0, 44, 320,self.view.bounds.size.height);

    }completion:^(BOOL finshied){
        
        
    }];


}

#pragma mark TextFieldDelegate
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView {

    activeField = textView;

    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    return YES;
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {


    UITableViewCell *cell = (UITableViewCell *)[[textField superview]superview];
    NSIndexPath *path = [tableView indexPathForCell:cell];
    NSLog(@"%ld",(long)path.row);

    activeField = textField;

     [tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return YES;
}


#pragma mark ViewLifeCycle.

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    if (activeField) {
        [activeField resignFirstResponder];
    }
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) {
        // Custom initialization
    }

    return self;
    
}

-(void)viewDidDisappear:(BOOL)animated{

    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];


}

-(void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    activeField = nil;

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mainBackGround.png"]];
    
    title = [@[@"Company Name :",@"Website :",@"Address :",@""]retain];
    placeHolder = [@[@"company name",@"url",@"address",@""]retain];;


    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [topView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"navBar.png"]]];
    [self.view addSubview:topView];

    topView.layer.shadowColor = [[UIColor blackColor] CGColor];
    topView.layer.shadowOffset = CGSizeMake(1.0f, 5.0f);
    topView.layer.shadowRadius = 3.0f;
    topView.layer.shadowOpacity = 0.9f;

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(70, 0, 320-70-65, 40)];
    label.text = @"Create New Place";
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
    //rect = btn.frame;
    btnDone = btn;
    [self.view addSubview:btnDone];
    btnDone.enabled = NO;

    tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, 320,self.view.bounds.size.height) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView setBackgroundColor:[UIColor clearColor]];
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view insertSubview:tableView belowSubview:topView];

   // [self addCreateLabelOnView];

   
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
