//
//  ViewController.m
//  ViagogoTest
//
//  Created by Belén Molina del Campo on 19/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "CountryListViewController.h"
#import "NetworkManager.h"
#import "Country.h"
#import "CountryTableViewCell.h"

@interface CountryListViewController()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NetworkManager *networkManager;
@property (strong, nonatomic) NSArray *countries;
@property (strong, nonatomic) NSNumberFormatter *numberFormatter;

@end

@implementation CountryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.numberFormatter = [NSNumberFormatter new];
    self.numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;

    
    self.networkManager = [NetworkManager new];
    [self.networkManager fetchCountriesWithCompletionHandler:^(NSArray *countries, NSError *error) {
        
        self.countries = [countries sortedArrayUsingComparator:^NSComparisonResult(Country *a, Country *b) {

            NSString *firstName = a.name;
            NSString *secondName = b.name;
            
            return [firstName compare: secondName];
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
        });
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
    
    return cell;
}

@end
