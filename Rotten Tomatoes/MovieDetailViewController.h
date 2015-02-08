//
//  MovieDetailViewController.h
//  Rotten Tomatoes
//
//  Created by Syed, Afzal on 2/4/15.
//  Copyright (c) 2015 afzalsyed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDetailViewController : UIViewController <UIScrollViewDelegate>
@property (nonatomic, weak) NSDictionary *movie;
@property (weak, nonatomic) IBOutlet UIImageView *movieDetailImageView;
@property (weak, nonatomic) IBOutlet UIImageView *movieDetailScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end
