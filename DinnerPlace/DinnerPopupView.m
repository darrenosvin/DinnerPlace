//
//  DinnerPopupView.m
//  DinnerPlace
//  Created by osvin admin on 7/17/13.
//  Copyright (c) 2013 osvin. All rights reserved.

#import "DinnerPopupView.h"
#import "RouteViewController.h"
#import "MapView.h"

@implementation DinnerPopupView
@synthesize delegate;
@synthesize address2,address1;

-(void)showComments:(NSArray *)array {

    
    float labelMaxHeight = self.commentsView.frame.size.height/array.count;

    self.commentsView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];

    for (int i=0; i<array.count; i++) {

        NSDictionary *dict = [array objectAtIndex:i];

        NSLog(@"Dict = %@ ",dict);

        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(2,2+labelMaxHeight*i+(0.0*i), self.commentsView.frame.size.width-4, labelMaxHeight-4)];
        label.backgroundColor = [UIColor colorWithRed:0.5000 green:0.5000 blue:0.5000 alpha:0.4];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = 0;
        label.numberOfLines = 3;
        label.font = [UIFont fontWithName:@"arial" size:12];
        label.text = [dict objectForKey:@"CommentContent"];
        [self.commentsView addSubview:label];
        

    }


}

-(void)showAddress{

    
    float labelMaxHeight = self.addressView.frame.size.height/2;

    self.addressView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];

    for (int i=0; i<2; i++) {

        NSLog(@" = %@  = %@ ",self.address2,self.address1);


        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(2,2+labelMaxHeight*i+(0.0*i), self.addressView.frame.size.width-4, labelMaxHeight-4)];
        
        label.backgroundColor = [UIColor colorWithRed:0.5000 green:0.5000 blue:0.5000 alpha:0.4];;
        label.textColor = [UIColor whiteColor];
        label.textAlignment = 0;
        label.numberOfLines = 3;
        
        label.font = [UIFont fontWithName:@"arial" size:12];

        if (i == 0) {
            label.text = self.address1;
        }else{
            label.text = self.address2;

        }
        // label.text = [dict objectForKey:@"CommentContent"];
        [self.addressView addSubview:label];

    }

}

//@synthesize tag;


- (id)initWithFrame:(CGRect)frame
{
   
    self = [super initWithFrame:frame];
   
    
    
    if (self) {
        
        // Initialization code

        self.backgroundColor = [UIColor colorWithRed:0.2601 green:0.2530 blue:0.2532 alpha:0.4];
        
        float y;
        if (IS_IPHONE_5) {
            y = 5;
        }else{
            y = 5;
        }
                
        AsyncImageView *imageView=[[AsyncImageView alloc]initWithFrame:CGRectMake(5, y, 80, 80)];
        imageView.backgroundColor=[UIColor whiteColor];
         self.imageView= imageView;
        [self addSubview:self.imageView];
        [imageView release];
        
        if (IS_IPHONE_5) {
            y = 5;
        }else{
            y = 5;
        }
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(90, y, 155, 80)];
        label.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.1];//[UIColor colorWithRed:0.5000 green:0.5000 blue:0.5000 alpha:0.4];
        label.textAlignment=1;
        label.text=@"Profile";
        label.lineBreakMode=NSLineBreakByClipping;
        label.numberOfLines=5;
        label.font=[UIFont fontWithName:@"Arial" size:14];
        [label setTextColor:[UIColor whiteColor]];
        label.layer.shadowColor = [UIColor blackColor].CGColor;
        label.layer.shadowOffset = CGSizeMake(5.5, 5.0);
        label.layer.shadowOpacity = 1.0;
         self.title = label;
        [self addSubview:self.title];
        [label release];

        self.title.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickOnTitle:)];
        [self.title addGestureRecognizer:tapGesture];
        [tapGesture release];

        float yAddress = self.bounds.size.height - 130 - 45 - 105 -10;
        
        UIView *addressView=[[UILabel alloc]initWithFrame:CGRectMake(5, y+80+5, self.bounds.size.width-10, yAddress)];
        addressView.backgroundColor=[UIColor whiteColor];
        self.addressView = addressView;
        [self addSubview:self.addressView];
        [addressView release];

       
        y = addressView.frame.origin.y+yAddress+5;

        UIButton *btnRoute=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        btnRoute.frame=CGRectMake(self.frame.size.width/2 - 85.0/2.0,y+4, 85, 35);
        [btnRoute setBackgroundImage:[UIImage imageNamed:@"back-btn.png"] forState:UIControlStateNormal];
        btnRoute.backgroundColor=[UIColor clearColor];
        [btnRoute setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnRoute.titleLabel setFont:[UIFont fontWithName:@"arial" size:22]];
        [btnRoute setTitle:@"Route" forState:UIControlStateNormal];
        [btnRoute setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [btnRoute setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
        //move text 10 pixels down and right
        [btnRoute setTitleEdgeInsets:UIEdgeInsetsMake(0.5f,14.0f, 0.0f, 0.0f)];
        [btnRoute addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btnRoute.tag=200;
        self.btnRute = btnRoute;
        [self addSubview:self.btnRute];
        
        y = btnRoute.frame.origin.y+35+5;

        float height = self.frame.size.height - y -9;
        UIView *viewComment=[[UIView alloc]initWithFrame:CGRectMake(5, y, 240, height)];
        viewComment.backgroundColor=[UIColor whiteColor];
        self.commentsView = viewComment;
        [self addSubview:self.commentsView];
        [viewComment release];
        
      }
    
    return self;
}

#pragma mark - Action
-(void)clickOnTitle:(id)sender {

    [self.delegate dinnerPlace:self];
}

-(void)btnClicked:(id)sender {

    
    [self.delegate showRoot:self];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
