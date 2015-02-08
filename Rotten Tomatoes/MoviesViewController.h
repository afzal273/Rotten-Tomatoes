//
//  MoviesViewController.h
//  Rotten Tomatoes
//
//  Created by Syed, Afzal on 2/3/15.
//  Copyright (c) 2015 afzalsyed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoviesViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *errorView;
@property (weak, nonatomic) IBOutlet UIView *networkErrorView;
@property(weak,nonatomic) NSString *Type;


@end
