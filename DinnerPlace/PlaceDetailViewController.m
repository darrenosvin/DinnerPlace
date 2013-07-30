//
//  PlaceDetailViewController.m
//  DinnerPlace
//
//  Created by osvin admin on 7/22/13.
//  Copyright (c) 2013 osvin. All rights reserved.
//

#import "PlaceDetailViewController.h"
#import "RateView.h"
#import "OSAlertView.h"
#import "RNBlurModalView.h"
#import "WebViewController.h"
#import "MapViewController.h"

static inline NSRegularExpression * NameRegularExpression() {
    static NSRegularExpression *_nameRegularExpression = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _nameRegularExpression = [[NSRegularExpression alloc] initWithPattern:@"^\\w+" options:NSRegularExpressionCaseInsensitive error:nil];
    });

    return _nameRegularExpression;
}


#define PADDING 10.0f

@interface PlaceDetailViewController ()<RateViewDelegate> {

    float      selectedRating;
    UITextView *textView;
    UILabel *labelCounter;
    UIButton *btnSaveRating;
    RNBlurModalView *blurModal;
    NSDictionary *dictData;
}
@end

@implementation PlaceDetailViewController
@synthesize place;
@synthesize arrayComments;

#pragma mark Comment Section

#pragma mark - Tabel
//Comment Section
-(void)celllForCommentSection:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {


    NSDictionary *dict = [arrayComments objectAtIndex:indexPath.row];

    cell.textLabel.text = [dict objectForKey:@"Username"];

    cell.detailTextLabel.text = [dict objectForKey:@"CommentContent"];
    cell.detailTextLabel.numberOfLines = 0;
    cell.detailTextLabel.textAlignment = 0;
    cell.detailTextLabel.font = [UIFont fontWithName:@"arial" size:14];
    cell.detailTextLabel.lineBreakMode = NSLineBreakByCharWrapping;
    
}


#pragma mark TableView_Delegatre&Datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 1) {

        return arrayComments.count;

    }else {
        
        return 5;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView_ cellForRowAtIndexPath:(NSIndexPath *)indexPath {


    NSString *IDIENTIFER = [NSString stringWithFormat:@"IDIENTIFER%i%i",indexPath.row,indexPath.section];

    UITableViewCell *cell = [tableView_ dequeueReusableCellWithIdentifier:IDIENTIFER];

    if (cell ==nil) {

        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:IDIENTIFER];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    cell.textLabel.backgroundColor = [UIColor clearColor];
    [cell.textLabel setTextAlignment:1];
    [cell.textLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [cell.textLabel setTextColor:[UIColor whiteColor]];

    [cell.detailTextLabel  setFont:[UIFont fontWithName:@"arial" size:16]];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.textColor = [UIColor colorWithRed:0.9227 green:0.9227 blue:0.9227 alpha:1.0000];
    [cell.detailTextLabel setTextAlignment:1];

    if (indexPath.section == 0 ){ //Section 0

         if ( indexPath.row == 0) { //Title.....

             //CompanyName
             NSString *CompanyName = [place objectForKey:@"CompanyName"];
             if (CompanyName && ![CompanyName empty]) 
                 cell.textLabel.text = CompanyName;
             else
                 cell.textLabel.text = @"_";

             //PlaceType
             NSString *PlaceType = [place objectForKey:@"PlaceType"];
             if (PlaceType && ![PlaceType empty])
                 cell.detailTextLabel.text = PlaceType;
             else
                 cell.detailTextLabel.text = @"_";
       
         }else if (indexPath.row == 1) { //Address...

            cell.textLabel.text = @"Address:";
             
             NSString *Address = [place objectForKey:@"Address"];

             if (Address && ![Address empty]) {
                 cell.detailTextLabel.text = Address;
             }else
                 cell.detailTextLabel.text = @"_";

             if (!Address || [Address empty]) {
                 cell.accessoryType = UITableViewCellAccessoryNone;

             }else{
                 
                 cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;

             }


        }else if ( indexPath.row == 2) { //Rating....

           cell.textLabel.text = @"Rating :";

            UIButton  *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(320-55, 4, 50, 30);
            [btn setBackgroundImage:[UIImage imageNamed:@"back-btn.png"] forState:UIControlStateNormal];
            [btn setTitle:@"Rate" forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont fontWithName:@"arial" size:17]];
            [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            [btn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(1.5f, 9.0f, 0.0f, 0.0f)];
            [btn addTarget:self action:@selector(rateThisPlace) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btn];

            NSString *Rating = [place objectForKey:@"Rating"];

            if (Rating && ![Rating empty]) {
                cell.detailTextLabel.text = Rating;
            }else
                cell.detailTextLabel.text = @"_";


        RateView *rateView = [[RateView alloc]initWithFrame:CGRectMake(320-130, 23, 120, 30)];
        rateView.backgroundColor   = [UIColor clearColor];
        rateView.notSelectedImage  =  [UIImage imageNamed:@"kermit_empty.png"];
        rateView.halfSelectedImage = [UIImage imageNamed:@"kermit_half.png"];
        rateView.fullSelectedImage = [UIImage imageNamed:@"kermit_full.png"];

        if (Rating && ![Rating empty])
            rateView.rating = [Rating floatValue];
            
        rateView.editable = NO;
        rateView.maxRating = 5;
        rateView.delegate = nil;
        [cell.contentView addSubview:rateView];

        cell.accessoryType = UITableViewCellAccessoryNone;
            
    }else if ( indexPath.row == 3) { //Price....

        cell.textLabel.text = @"Price :"; 
        NSString *Price = [place objectForKey:@"Price"];

        if (Price && ![Price empty]) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"$%@",Price];
        }else
            cell.detailTextLabel.text = @"$_";

        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }else if ( indexPath.row == 4) { //Website

        cell.textLabel.text = @"Website :";

        NSString *webSite = [place objectForKey:@"Website"];
        if (webSite && ![webSite empty]) {
            cell.detailTextLabel.text = webSite;
        }else
            cell.detailTextLabel.text = @"";

        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        
    }else if (indexPath.row == 5) { //Phone number

        cell.textLabel.text = @"Phone :"; //
        NSString *phnNumber = [place objectForKey:@"PhoneNumber"];

        if (phnNumber && ![phnNumber empty]) {
            cell.detailTextLabel.text = phnNumber;
        }else
            cell.detailTextLabel.text = @"";
        cell.accessoryType = UITableViewCellAccessoryNone;
    }


        
    }else if (indexPath.section == 1) { // Section 1 
         //Comments
        [self celllForCommentSection:cell indexPath:indexPath];
        
    }

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {

        return 50;
    }else{

        NSString *Username =   [[arrayComments objectAtIndex:indexPath.row]objectForKey:@"Username"];;
        NSString *CommentContent = [[arrayComments objectAtIndex:indexPath.row]objectForKey:@"CommentContent"];;

        CGSize titleSize = [Username sizeWithFont:[UIFont systemFontOfSize:20.0f] constrainedToSize:CGSizeMake(tableView.frame.size.width - PADDING * 1, 1000.0f)];

        CGSize addressSize = [CommentContent sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(tableView.frame.size.width - PADDING * 1, 1000.0f)];


        float totalHeight = titleSize.height + addressSize.height + PADDING * 1;
             
        return totalHeight;
        
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section == 0)
    {
        static NSString *IDENTIFER =@"IDENTIFER_Section0";

    UIView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:IDENTIFER];

    if (view == nil) {

        view = [[UIView alloc]init];
        view.backgroundColor = [UIColor clearColor];

    }

    return view;

    }
    else {
        
        static NSString *IDENTIFER =@"IDENTIFER_Header";

        UIView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:IDENTIFER];

        if (view == nil) {
            
            view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
            view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navBar.png"]];

            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 310, 30)];
            label.text = @"Comments";
            [label setTextAlignment:0];
            [label setBackgroundColor:[UIColor clearColor]];
            [label setTextColor:[UIColor whiteColor]];
            [label setFont:[UIFont fontWithName:@"arial" size:20]];
            [view addSubview:label];

            UIButton  *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(320-61,3,56,30);
            [btn setBackgroundImage:[UIImage imageNamed:@"back-btn.png"] forState:UIControlStateNormal];
            [btn setTitle:@"Post" forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont fontWithName:@"arial" size:17]];
            [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            [btn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(1.5f, 9.0f, 0.0f, 0.0f)];
            [btn addTarget:self action:@selector(showCommentAlertView) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:btn];

            if (!appDelegate().fbLogin) {
                btn.hidden = YES;

            }
        }
           return view;

        }

      
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) 
        return 0;
    else
        return 30;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0) {

        if (indexPath.row == 1) { //Address

            MapViewController *mapViewController = [[MapViewController alloc]initWithDict:place];
            [self.navigationController pushViewController:mapViewController animated:YES];
            [mapViewController release];
            
        }else if (indexPath.row == 4){ //WebSite...

            NSString *strURL = [place objectForKey:@"Website"];

            if (!strURL || [strURL empty] || [strURL isKindOfClass:[NSNull class]]) {

                return;
            }
            
            strURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

            WebViewController *webViewController = [[WebViewController alloc]initWithURL:strURL];
            [self.navigationController pushViewController:webViewController animated:YES];
            [webViewController release];
            
        }
        
    }
    
}


#pragma mark - Rating

#pragma mark RateDelegate....

- (void)rateView:(RateView *)rateView ratingDidChange:(float)rating {

    if (rating > 0.0)
        btnSaveRating.enabled = YES;
    else
        btnSaveRating.enabled = NO;

    selectedRating = rating;
}


-(void)btnSaveClicked {

    //Hide Popup.
    [blurModal hide];

    //http://clientdemo.osvin.biz/FindDinnerPlaceapi//FDinnerApi.svc/PostRating?PlaceID=1&facebookID=22&Rating=5

    if (selectedRating == -1.0) {

        return;
    }

    NSString *placeId = [place objectForKey:@"PlaceID"];
    NSString *fbId    =   appDelegate().userProfile.userFBId;
    NSString *rating  = [NSString stringWithFormat:@"%i",(int)selectedRating];

    NSString *strURL = [NSString stringWithFormat:@"PostRating?PlaceID=%@&facebookID=%@&Rating=%@",placeId,fbId,rating];

    [OSRequest sendAsyncReque:YES url:strURL completionHandle:^(id data, NSError *error){

        if (error) {

            return;
        }

        if (data) {

            NSDictionary *dict = [data objectForKey:@"PostRatingResult"];
            NSString     *ResponseCode = [[dict objectForKey:@"ResponseCode"]stringValue];

            if ([ResponseCode isEqualToString:@"0"]) {

                OSAlertView *alert = [[[OSAlertView alloc] initWithTitle:@"Rating"
                                                                 message:@"you had already rate this place."
                                                                delegate:nil
                                                       cancelButtonTitle:@"Dismiss"
                                                       otherButtonTitles:nil] autorelease];

                [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
            }
            
        }
        
    }];
    
}


-(void)rateThisPlace {

    RateView *rateView = [[RateView alloc]initWithFrame:CGRectMake(10, 40, 120, 30)];
    rateView.backgroundColor   = [UIColor clearColor];
    rateView.notSelectedImage  =  [UIImage imageNamed:@"kermit_empty.png"];
    rateView.halfSelectedImage = [UIImage imageNamed:@"kermit_half.png"];
    rateView.fullSelectedImage = [UIImage imageNamed:@"kermit_full.png"];
    rateView.rating    = 0;
    rateView.editable  = YES;
    rateView.maxRating = 5;
    rateView.delegate  = self;

    btnSaveRating = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSaveRating.frame = CGRectMake(160-61,5,56,30);
    [btnSaveRating setBackgroundImage:[UIImage imageNamed:@"back-btn.png"] forState:UIControlStateNormal];
    [btnSaveRating setTitle:@"Save" forState:UIControlStateNormal];
    [btnSaveRating.titleLabel setFont:[UIFont fontWithName:@"arial" size:17]];
    [btnSaveRating setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btnSaveRating setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
    //move text 10 pixels down and right
    [btnSaveRating setTitleEdgeInsets:UIEdgeInsetsMake(1.5f, 9.0f, 0.0f, 0.0f)];
    [btnSaveRating addTarget:self action:@selector(btnSaveClicked) forControlEvents:UIControlEventTouchUpInside];
    btnSaveRating.enabled = NO;

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 100, 50)];
    label.text = @"     Rate\n This Place";
    [label setTextAlignment:0];
    [label setNumberOfLines:2];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor whiteColor]];
    [label setFont:[UIFont fontWithName:@"arial" size:16]];

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(320-130, 21, 160, 70)];
    view.backgroundColor = [UIColor colorWithRed:0.4307 green:0.4307 blue:0.4307 alpha:1.0000];//[UIColor colorWithPatternImage:[UIImage imageNamed:@"mainBackGround.png"]];
    view.layer.cornerRadius = 8.0;
    view.layer.borderColor = [UIColor whiteColor].CGColor;
    view.layer.borderWidth = 2.0;
    [view addSubview:rateView];
    [view addSubview:btnSaveRating];
    [view addSubview:label];

      blurModal = [[RNBlurModalView alloc]initWithViewController:self view:view];
     [blurModal show];
    
}

#pragma mark - Comments

#pragma mark TextViewDelegate....
-(BOOL)textView:(UITextView *)textView_ shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{

    NSUInteger newLength = [textView_.text length] + [text length] - range.length;

      if (newLength <= 250)
        labelCounter.text = [NSString stringWithFormat:@"%i",250-newLength];

    if (newLength >= 250) {
        labelCounter.textColor = [UIColor redColor];

    }else{
        labelCounter.textColor = [UIColor whiteColor];
    }

    return (newLength > 250) ? NO : YES;

}

#pragma mark AlertView_Delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 0) {

        [self postNewComment];
    }else if (buttonIndex == 1){
        
    }
    
}

-(void)showCommentAlertView {

    OSAlertView *alert = [[[OSAlertView alloc] initWithTitle:nil
                                                     message:@"\n\n\n\n\n"
                                                    delegate:self
                                           cancelButtonTitle:@"Post Comment"
                                           otherButtonTitles:@"Cancel", nil] autorelease];

    CGRect rect2 = {12, 5, 260, 17};
    
    UILabel *label = [[UILabel alloc]initWithFrame:rect2];
    [label setText:@"Comment"];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont boldSystemFontOfSize:20]];
    label.textAlignment =1;
    [label setTextColor:[UIColor whiteColor]];
    [alert addSubview:label];

     labelCounter = [[UILabel alloc]initWithFrame:rect2];
    [labelCounter setText:@"250"];
    [labelCounter setBackgroundColor:[UIColor clearColor]];
    [labelCounter setFont:[UIFont boldSystemFontOfSize:20]];
    labelCounter.textAlignment =2;
    [labelCounter setTextColor:[UIColor whiteColor]];
    [alert addSubview:labelCounter];


    CGRect rect3 = {12, 34, 260, 85};

     textView = [[UITextView alloc] initWithFrame:rect3];
     textView.backgroundColor = [UIColor whiteColor];
     textView.keyboardType=UIKeyboardTypeDefault;
    [textView becomeFirstResponder];
    textView.delegate = self;
    [textView setContentMode:UIViewContentModeCenter];
    [textView setContentInset:UIEdgeInsetsMake(3, 0, 3, 0)];
    [alert addSubview:textView];
    [OSAlertView setBackgroundColor:[UIColor blackColor] withStrokeColor:[UIColor whiteColor]];
    [alert show];
    
}

-(void)postNewComment {
    
//http://clientdemo.osvin.biz/FindDinnerPlaceapi//FDinnerApi.svc/PostComment?PlaceID=1&facebookID=22&commenttext=this%20is%20wonderfull%20place%20for%20dinner

    NSString *placeID = [place objectForKey:@"PlaceID"];
    NSString *fbID = appDelegate().userProfile.userFBId;
    NSString *text = textView.text;

    if (!text || [text empty]) {

        return;
    }

    NSString *strURL = [NSString stringWithFormat:@"PostComment?PlaceID=%@&facebookID=%@&commenttext=%@",placeID,fbID,text];

    [OSRequest sendAsyncReque:YES url:strURL completionHandle:^(id data , NSError *error){

        if (error) {

            OSAlertView *alert = [[[OSAlertView alloc] initWithTitle:@"Error"
                                                             message:@"Response data is null."
                                                            delegate:nil
                                                   cancelButtonTitle:@"Dismiss"
                                                   otherButtonTitles:nil] autorelease];
            [OSAlertView setBackgroundColor:[UIColor blackColor] withStrokeColor:[UIColor blackColor]];

            [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:NO];
            return;
            
        }
        
        if (data) {

            NSString *firstName = appDelegate().userProfile.firstName_;
            
            NSDictionary *dict = @{@"Username":firstName,@"CommentContent":text};
            [arrayComments addObject:dict];

            [OSAlertView setBackgroundColor:[UIColor blackColor] withStrokeColor:[UIColor blackColor]];
            [self  performSelectorOnMainThread:@selector(reloadTableWithAnimation) withObject:nil waitUntilDone:YES];

        }
        
    }];
    
}

-(void)reloadTableWithAnimation {

    [self.tableView beginUpdates];
   
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:arrayComments.count-1 inSection:1]] withRowAnimation:UITableViewRowAnimationAutomatic];

     [self.tableView endUpdates];

     [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:arrayComments.count-1 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];

}
#pragma mark -     Data

/***************************************************** Get Full details ****************************************************/

-(void)getFullDetails {

    NSString *getPlaceDetail = [NSString stringWithFormat:@"GetDinnerPlaceDetail?PlaceID=%@",[dictData objectForKey:@"PlaceID"]];

    [OSRequest sendAsyncReque:YES url:getPlaceDetail completionHandle:^(id data , NSError *error){

        if (data) {

            NSArray *array = [data objectForKey:@"GetDinnerPlaceDetailResult"];

            if (array.count) {

                place = [[array objectAtIndex:0]retain];

                dispatch_async(dispatch_get_main_queue(), ^{

                    [self.tableView  reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
                });


            }else{

            }

        }

    }];


}
/***************************************************** Get Comments ****************************************************/

-(void)getComments{

    NSString *strURL = [NSString stringWithFormat:@"GetComments?PlaceID=%@",[dictData objectForKey:@"PlaceID"]];

    [OSRequest sendAsyncReque:YES url:strURL completionHandle:^(id data , NSError *error){

        if (data) {

            NSArray *array = (NSArray *)[data objectForKey:@"GetCommentsResult"] ;

            arrayComments = [[NSMutableArray alloc]initWithArray:array];

            dispatch_async(dispatch_get_main_queue(), ^{

                [self.tableView  reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, 1)] withRowAnimation:UITableViewRowAnimationAutomatic];
            });
        }
        
    }];
    
}



#pragma Mark -  ViewLifeCycle....

//BackButtionAction.
-(void)backBtnClicked{

    [self.navigationController popViewControllerAnimated:YES];
}

- (id)initWithDict:(NSDictionary *)dict {
    
    self = [super init];

    if (self) {
        
        // Custom initialization
        dictData = [dict retain];
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

- (void)viewDidLoad
{
    [super viewDidLoad];

    selectedRating = -1.0;

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mainBackGround.png"]];

    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [topView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"navBar.png"]]];
    [self.view addSubview:topView];

    topView.layer.shadowColor = [[UIColor blackColor] CGColor];
    topView.layer.shadowOffset = CGSizeMake(1.0f, 5.0f);
    topView.layer.shadowRadius = 3.0f;
    topView.layer.shadowOpacity = 0.9f;

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(70, 0, 320-70-65, 40)];
    label.text = @"Place Details";
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
    [btn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    //  rect = btn.frame;
    [self.view addSubview:btn];

    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, 320, self.view.bounds.size.height-44) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor colorWithRed:0.2601 green:0.2530 blue:0.2532 alpha:0.4];//[UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView = tableView;
    [self.view insertSubview:self.tableView belowSubview:topView];

   
   
    [self getFullDetails];
    [self getComments];
	// Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
