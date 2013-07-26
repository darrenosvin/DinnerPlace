//
//  OSAnnotationView.m
//  DinnerPlace
//
//  Created by Shivangi on 19/07/13.
//  Copyright (c) 2013 osvin. All rights reserved.
//

#import "OSAnnotationView.h"

@implementation OSAnnotationView

@synthesize callback;

-(void)nothingYaar{
    
    NSLog(@"nothingYR");
    
    self.callback(self,nil);
    
}

-(void)tapOnanotaion{
    
    NSLog(@"tapOnanotaion..");
    self.callback(self,nil);

}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setSelected:YES animated:YES];

          }
    
    return self;
}

-(id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
        
    self =  [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    //super.animatesDrop = YES;
    self.frame = CGRectMake(0, 0, 50, 50);
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"ball-red.png"] forState:UIControlStateNormal];
    btn.frame =CGRectMake(0, 0, 20, 20);
    [btn addTarget:self action:@selector(nothingYaar) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnanotaion)];
    tapGesture.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapGesture];
    [self addSubview:btn];
    [btn setCenter:self.center];
    
    self.backgroundColor = [UIColor clearColor];

    return self;
    
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
