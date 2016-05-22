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
#import "InMemoryCountriesStore.h"
#import "CountryListDataProvider.h"
#import "ImagesController.h"

typedef NS_ENUM(NSUInteger, CountryListDisplayMode) {
    CountryListDisplayModeAll = 0,
    CountryListDisplayModeRegion
};

@interface CountryListViewController()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) APIController *apiController;
@property (strong, nonatomic) NSNumberFormatter *numberFormatter;
@property (strong, nonatomic) InMemoryCountriesStore *inMemoryCountriesStore;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@property (nonatomic) CountryListDisplayMode displayMode;

@property (strong, nonatomic) CountryListDataProvider *dataProvider;

@property (strong, nonatomic) ImagesController *imagesController;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *infoButton;

- (IBAction)showInfo:(id)sender;

@end

@implementation CountryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imagesController = [ImagesController sharedInstance];
    
    self.dataProvider = [CountryListDataProvider new];
    
    self.displayMode = self.region ? CountryListDisplayModeRegion : CountryListDisplayModeAll;
    
    [self displayTitle];
    
    [self configureRefreshControl];
    
    if (self.displayMode != CountryListDisplayModeAll) {
        
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    self.inMemoryCountriesStore = [InMemoryCountriesStore sharedInstance];
    
    self.numberFormatter = [NSNumberFormatter new];
    self.numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;

    self.apiController = [APIController new];
    
    [self fetchCountries];
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.dataProvider.sectionHeaders;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.dataProvider.sectionHeaders count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.dataProvider.sectionHeaders[section];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataProvider.dataSourceDictionary[self.dataProvider.sectionHeaders[section]] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CountryTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"countryCell"];
    
    Country *currentCountry = self.dataProvider.dataSourceDictionary[self.dataProvider.sectionHeaders[indexPath.section]][indexPath.row];
    
    [cell configureCellForCountry:(currentCountry) withNumberFormatter:(self.numberFormatter)];
    
    cell.flagImageView.image = [UIImage imageNamed:@"placeholder-flag"];
    
    if (self.tableView.dragging == NO && self.tableView.decelerating == NO) {
        
        [self.imagesController fetchImageWithUrl:currentCountry.flagUrlString withCompletion:^(UIImage *image) {
           
            dispatch_async(dispatch_get_main_queue(), ^{
                
                cell.flagImageView.image = image;
            });
        }];
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


#pragma mark - Storyboard methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(CountryTableViewCell *)sender {
    
    if ([segue.identifier  isEqualToString: @"showDetail"]) {
        
        CountryDetailViewController *destinationViewController = segue.destinationViewController;
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        destinationViewController.country = self.dataProvider.dataSourceDictionary[self.dataProvider.sectionHeaders[indexPath.section]][indexPath.row];
    }
}


#pragma mark - Private methods 

-(void)displayTitle
{
    switch (self.displayMode) {
            
        case CountryListDisplayModeAll:
            self.navigationItem.title = NSLocalizedString(@"country_list.title", @"");
            break;
            
        case CountryListDisplayModeRegion:
            self.navigationItem.title = self.region;
            break;
            
        default:
            break;
    }
}

-(void)fetchCountries
{
    switch (self.displayMode) {
        case CountryListDisplayModeAll:
            [self fetchAllCountries];
            break;
            
        case CountryListDisplayModeRegion:
            [self fetchRegionCountries];
            break;
            
        default:
            break;
    }
}

-(void)fetchAllCountries
{
    [self.apiController fetchCountriesWithCompletionHandler:^(NSArray *countries, NSError *error) {
        
        if (!error && countries) {
            
            [self processFetchCountriesResponse:countries];
            
        } else {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.refreshControl endRefreshing];
            });
        }
    }];
}

-(void)fetchRegionCountries
{
    [self.apiController fetchCountriesFromRegion:self.region withCompletionHandler:^(NSArray *countries, NSError *error) {
        
        if (!error && countries) {
            
            [self processFetchCountriesResponse:countries];
            
        } else {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.refreshControl endRefreshing];
            });
        }
    }];
}

-(void)processFetchCountriesResponse:(NSArray *)countries
{
    [self.dataProvider prepareDataForCountries:countries];
    self.inMemoryCountriesStore.countries = self.dataProvider.sortedCountries;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    });
}

- (void)loadImagesForOnscreenRows
{
    
    NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
    
    for (NSIndexPath *indexPath in visiblePaths)
    {
        Country *country = self.dataProvider.dataSourceDictionary[self.dataProvider.sectionHeaders[indexPath.section]][indexPath.row];;
        
        [self.imagesController fetchImageWithUrl:country.flagUrlString withCompletion:^(UIImage *image) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                ((CountryTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath]).flagImageView.image = image;
            });
        }];
    }
}

- (IBAction)showInfo:(id)sender {
    
    NSString *message = @"Belén Molina del Campo \nMay 2016 \n\nThanks!";
    
    UIAlertController *infoAlertController = [UIAlertController alertControllerWithTitle:@"Viagogo Coding Test" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:nil];
    
    [infoAlertController addAction:dismissAction];
    
    [self presentViewController:infoAlertController animated:YES completion:nil];
}

- (void)configureRefreshControl
{
    self.refreshControl = [UIRefreshControl new];
    
    self.refreshControl.enabled = NO;
    [self.refreshControl addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView addSubview:self.refreshControl];
}

- (void)handleRefresh:(UIRefreshControl *)refreshControl
{
    [self fetchCountries];
}

@end
