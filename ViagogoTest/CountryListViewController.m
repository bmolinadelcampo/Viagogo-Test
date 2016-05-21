//
//  ViewController.m
//  ViagogoTest
//
//  Created by Belén Molina del Campo on 19/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "CountryListViewController.h"
#import "APIController.h"
#import "Country.h"
#import "CountryTableViewCell.h"
#import "CountryDetailViewController.h"

@interface CountryListViewController()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) APIController *apiController;
@property (strong, nonatomic) NSArray *countries;
@property (strong, nonatomic) NSNumberFormatter *numberFormatter;

@end

@implementation CountryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.numberFormatter = [NSNumberFormatter new];
    self.numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;

    self.apiController = [APIController new];
    
    [self.apiController fetchCountriesWithCompletionHandler:^(NSArray *countries, NSError *error) {
        
        if (!error && countries) {
            self.countries = [countries sortedArrayUsingComparator:^NSComparisonResult(Country *a, Country *b) {
                
                NSString *firstName = a.name;
                NSString *secondName = b.name;
                
                return [firstName compare: secondName];
            }];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.tableView reloadData];
            });
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.countries count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CountryTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"countryCell"];
    
    Country *currentCountry = self.countries[indexPath.row];
    
    [cell configureCellForCountry:(currentCountry) withNumberFormatter:(self.numberFormatter)];
    
    if (!currentCountry.flagImage)
    {
        if (self.tableView.dragging == NO && self.tableView.decelerating == NO)
        {
            [self.apiController downloadImageFor:currentCountry completionHandler:^(UIImage *flagImage, NSError *error) {
                
                if (flagImage) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        cell.flagImageView.image = flagImage;
                    });
                }
                
            }]; 
        }
        
        cell.flagImageView.image = [UIImage imageNamed:@"placeholder-flag"];

        
    } else {
        
        cell.flagImageView.image = currentCountry.flagImage;
    }
    
    return cell;
}


#pragma mark - UIScrollViewDelegate methods

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate)
    {
        [self loadImagesForOnscreenRows];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self loadImagesForOnscreenRows];
}


#pragma mark - Private methods 

- (void)loadImagesForOnscreenRows
{
    
    NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
    
    for (NSIndexPath *indexPath in visiblePaths)
    {
        Country *country = (self.countries)[indexPath.row];
        
        if (!country.flagImage)
        {
            [self.apiController downloadImageFor:country completionHandler:^(UIImage *flagImage, NSError *error)
             {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    ((CountryTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath]).flagImageView.image = flagImage;
                });
            }];
        }
    }
}

#pragma mark - Storyboard methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(CountryTableViewCell *)sender {
    
    if ([segue.identifier  isEqualToString: @"showDetail"]) {
        
        CountryDetailViewController *destinationViewController = segue.destinationViewController;
        destinationViewController.country = self.countries[[self.tableView indexPathForCell:sender].row];
    }
}

@end
