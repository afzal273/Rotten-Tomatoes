//
//  MoviesViewController.m
//  Rotten Tomatoes
//
//  Created by Syed, Afzal on 2/3/15.
//  Copyright (c) 2015 afzalsyed. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "MovieDetailViewController.h"
#import "SVProgressHUD.h"

@interface MoviesViewController () <UITableViewDelegate, UITableViewDataSource, UITabBarControllerDelegate, UISearchBarDelegate, UISearchDisplayDelegate>
 

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *movies;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) NSString *urlToFetch;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSMutableArray *filteredMovies;

@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // i'm going to provide data for you
    // also delegate all events to me

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.searchBar.placeholder = @"Search";
    self.searchBar.delegate = self;
    self.searchBar.showsCancelButton = YES;
    
    
    if ([self.Type  isEqual: @"BoxOffice"]) {
        self.navigationItem.title = @"Top Movies";
    } else if ([self.Type isEqual:@"DVD"]){
        self.navigationItem.title = @"Top DVD Rentals";
    }
    
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];

    self.tableView.rowHeight = 100;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    [SVProgressHUD show];
    [self updateMovies];
    [SVProgressHUD dismiss];
    


}




-(void) updateMovies {
    
    
    //nsurl gives a canonical representation of the url
    
    if ([self.Type  isEqual: @"BoxOffice"]) {
        self.urlToFetch = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=xz3h3qgqtz7azg5gmsdcucjf";
    } else if ([self.Type isEqual:@"DVD"]){
        self.urlToFetch = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/new_releases.json?apikey=xz3h3qgqtz7azg5gmsdcucjf";
    }
    
    NSURL *url = [NSURL URLWithString:self.urlToFetch];
    
    // adds to the url caching policy, query parameters, custom headers, authentication
    // signatures
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // nsdata is a blob of binary data
    

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data == nil) {
            [self handleNetworkError];
            return;
        }
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        //NSLog(@"response: %@", responseDictionary);
        // accessing values from a key-value store
        self.movies = responseDictionary[@"movies"];
        //once the datasource is changed you need to tell the tableview to reload data
        self.networkErrorView.hidden = true;
        [self.tableView reloadData];
       
    }];
    
}


-(void) onRefresh{
    [self updateMovies];
    [self.refreshControl endRefreshing];
    
}

-(void)handleNetworkError{
    self.networkErrorView.frame = CGRectMake(0, 60, 320, 70);
    self.networkErrorView.hidden = FALSE;
    [self.view addSubview:self.networkErrorView];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.filteredMovies.count > 0){
        return self.filteredMovies.count;
    } else {
    return self.movies.count;
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    
    NSDictionary *movie;
    // index path is composed of row and section
    if (self.filteredMovies.count > 0) {
        movie = self.filteredMovies[indexPath.row];
    } else {
        movie = self.movies[indexPath.row];
    }
    cell.titleLabel.text = movie[@"title"];
    //cell.textLabel.lineBreakMode.
    cell.synopsisLabel.text = movie[@"synopsis"];
    
    // getting values from a nested dictionary
    NSString *url = [movie valueForKeyPath:@"posters.thumbnail"];
   // url = [url stringByReplacingOccurrencesOfString:@"tmb" withString:@"ori"];
    //NSLog(@"%@",url);
    [cell.posterView setImageWithURL:[NSURL URLWithString:url]];
    
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];    
    MovieDetailViewController *vc = [[MovieDetailViewController alloc]init];
    
    if (self.filteredMovies.count > 0){
            vc.movie = self.filteredMovies[indexPath.row];
    } else {
            vc.movie = self.movies[indexPath.row];
    }
    
    
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]init];
    barButton.title = @"Back";
    self.navigationItem.backBarButtonItem = barButton;

    [self.navigationController pushViewController:vc animated:YES];
    
    // we know which movie we are at from the indexpath
    
    

}




#pragma  mark Search Methods

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    //NSLog(@"in search: %@", searchBar.text);
    NSString *searchBarText = searchBar.text;
//    NSPredicate *searchSearch = [NSPredicate predicateWithFormat:@"self CONTAINS[cd] %@", searchBarText];
//    NSArray *searchResults = [self.movies filteredArrayUsingPredicate:searchSearch];
//   NSLog(@"%@",searchResults);
//    [self.movies[0]
    
    
    /*
    NSArray *searchResults = [self.movies filteredArrayUsingPredicate:searchSearch];
    NSLog(@"count is %i", searchResults.count);
    if (searchResults.count > 0){
        NSLog(@"%@", searchResults[0]);
        
    }
     
     */
    
//    NSDictionary *movie;// = [[NSDictionary alloc]init];
    self.filteredMovies  = [[NSMutableArray alloc] init];
    
    
    for ( NSDictionary *movie in self.movies) {
        //NSLog(@"%@", movie[@"title"]);
        if ([[movie[@"title"] lowercaseString] containsString:[searchBarText lowercaseString]]) {
            NSLog(@"%@", movie[@"title"]);
            //[testArray addObject:movie];
            [self.filteredMovies addObject:movie];
            //NSLog(@"size of the array is %ld]", self.filteredMovies.count);
            
        }
    }
    NSLog(@"size of the array is %ld", self.filteredMovies.count);
    [self.tableView reloadData];
    

    
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    searchBar.text = nil;
    [self.filteredMovies removeAllObjects];
    [self.tableView reloadData];
    //searchBar.hidden = YES;
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
