//
//  MovieDetailViewController.m
//  Rotten Tomatoes
//
//  Created by Syed, Afzal on 2/4/15.
//  Copyright (c) 2015 afzalsyed. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "SVProgressHUD.h"

@interface MovieDetailViewController ()<UIScrollViewDelegate,UITabBarControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tabBarController.tabBar.hidden = TRUE;

    
    self.scrollView.delegate = self;
    
    
    self.titleLabel.text = self.movie[@"title"];
    self.title = self.titleLabel.text;
    self.ratingLabel.text = [NSString stringWithFormat:@"%@, %@ min",self.movie[@"mpaa_rating"], self.movie[@"runtime"]];
    [self.ratingLabel sizeToFit];
    

    
    
//    NSLog(@"Run time is %i hrs, %i min", runTime/60, runTime%60);
    
    
    
    self.synopsisLabel.text = self.movie[@"synopsis"];
    [self.containerView setAlpha:0.85];
    
    self.synopsisLabel.frame = CGRectMake(7, 5 + self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height, self.containerView.frame.size.width-15, 0);
    
    [self.synopsisLabel sizeToFit];

    //create container view frame
    CGRect containerViewFrame = self.containerView.frame;
    //set height of container view frame
    containerViewFrame.size.height = self.synopsisLabel.frame.origin.y + (self.synopsisLabel.frame.size.height*1.2);
    
    //set the container view frame to the containerViewFrame
    self.containerView.frame = containerViewFrame;
    //set the content size of scroll view
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, self.containerView.frame.origin.y+self.containerView.frame.size.height)];
    self.containerView.frame = CGRectMake(0, self.view.frame.size.height *0.65 , self.containerView.frame.size.width, self.containerView.frame.size.height);



    [SVProgressHUD show];
    NSString *url = [self.movie valueForKeyPath:@"posters.thumbnail"];
    [self.movieDetailImageView setImageWithURL:[NSURL URLWithString:url]];
    url = [url stringByReplacingOccurrencesOfString:@"tmb" withString:@"ori"];
    [self.movieDetailImageView setImageWithURL:[NSURL URLWithString:url]];
    [SVProgressHUD dismiss];
    
    
                                 
}
//
////-(void)deposit:(NSDecimalNumber *)amount {
//- (NSString*) formatTimeString:(NSString *) runTime {
//    return @"Hello";
//    
//}

- (void)viewWillDisappear:(BOOL)animated {
    self.parentViewController.tabBarController.tabBar.hidden = FALSE;

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
