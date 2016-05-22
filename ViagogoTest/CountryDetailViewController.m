//
//  CountryDetailViewController.m
//  ViagogoTest
//
//  Created by Belén Molina del Campo on 21/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "CountryDetailViewController.h"
#import "CountryDataProvider.h"
#import "CountryDataTableViewCell.h"
#import "FlagTableViewCell.h"
#import "InMemoryCountriesStore.h"
#import "CountryListViewController.h"

@interface CountryDetailViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSDictionary *dataDictionary;
@property (strong, nonatomic) InMemoryCountriesStore *inMemoryCountriesStore;
@property (strong, nonatomic) CountryDataProvider *countryDataProvider;

@end

@implementation CountryDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.inMemoryCountriesStore = [InMemoryCountriesStore sharedInstance];
    
    self.countryDataProvider = [CountryDataProvider new];
    self.dataDictionary = [self.countryDataProvider provideDataForCountry:self.country];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [[self.dataDictionary allKeys] count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[self.dataDictionary[self.countryDataProvider.sections[section]] allKeys] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.countryDataProvider.sections[indexPath.section] isEqualToString:@"Flag"]) {
        
        return 250;
    }
    
    return 44;
}

-(CountryDataTableViewCell *)createCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath forCurrentSubsections:(NSArray *)subsectionsArray
{
    CountryDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleAndData"];
    
    NSString *currentSection =self.countryDataProvider.sections[indexPath.section];
    NSDictionary *currentItem = self.dataDictionary[currentSection];

    cell.titleLabel.text = subsectionsArray[indexPath.row];
    cell.dataLabel.text = currentItem[subsectionsArray[indexPath.row]];
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *currentSection =self.countryDataProvider.sections[indexPath.section];
    
    NSDictionary *currentItem = self.dataDictionary[currentSection];

    if ([currentSection isEqualToString:@"Names"]) {
        
        return [self createCellInTableView:tableView atIndexPath:indexPath forCurrentSubsections:self.countryDataProvider.subsectionsInNamesSection];
    }
    
    if ([currentSection isEqualToString:@"Flag"]) {
        
        FlagTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"flagImage"];
        cell.flagImageView.image = currentItem[@"Flag"];
        
        return  cell;
    }
    
    if ([currentSection isEqualToString:@"Capital"]) {
        
        CountryDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleAndData"];
        
        cell.titleLabel.text = @"Capital:";
        cell.dataLabel.text = currentItem[@"Capital"];
        
        return cell;
    }
    
    if ([currentSection isEqualToString:@"Location"]) {
        
        return [self createCellInTableView:tableView atIndexPath:indexPath forCurrentSubsections:self.countryDataProvider.subsectionsInLocationSection];
    }
    
    if ([currentSection isEqualToString:@"Size"]) {
        
        return [self createCellInTableView:tableView atIndexPath:indexPath forCurrentSubsections:self.countryDataProvider.subsectionsInSizeSection];
    }
    
    if ([currentSection isEqualToString:@"Borders"]) {
        
        CountryDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleAndData"];
        
        NSArray *keys = [currentItem allKeys];
        
        cell.titleLabel.text = @"";
        cell.dataLabel.text = currentItem[keys[indexPath.row]];
        
        return cell;
    }
    
    if ([currentSection isEqualToString:@"Practical Info"]) {
        
        return [self createCellInTableView:tableView atIndexPath:indexPath forCurrentSubsections:self.countryDataProvider.subsectionsInPracticalInfoSection];
    }
    
    if ([currentSection isEqualToString:@"Other Info"]) {
    
        return [self createCellInTableView:tableView atIndexPath:indexPath forCurrentSubsections:self.countryDataProvider.subsectionsInOtherInfoSection];
    }
    
    return [UITableViewCell new];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionHeaderString = self.countryDataProvider.sections[section];
    
    return sectionHeaderString;
}

#pragma mark - UITableViewDelegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.countryDataProvider.sections[indexPath.section] isEqualToString:@"Borders"]) {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        CountryDetailViewController *destinationViewController = [storyboard instantiateViewControllerWithIdentifier:@"CountryDetailViewController"];
        
        NSArray *keys = [self.dataDictionary[self.countryDataProvider.sections[indexPath.section]] allKeys];
        
        destinationViewController.country = [self.inMemoryCountriesStore countryForCode:keys[indexPath.row]];
        
        [self.navigationController pushViewController:destinationViewController animated:YES];
        
        return;
    }
    
    if ([self.countryDataProvider.sections[indexPath.section] isEqualToString:@"Location"] && [self.countryDataProvider.subsectionsInLocationSection indexOfObject:@"Region"] == indexPath.row) {
        
        [self performSegueWithIdentifier:@"showRegion" sender:self];
        
        return;
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showRegion"]) {
        
        CountryListViewController *destinationViewController = segue.destinationViewController;
        destinationViewController.region = self.dataDictionary[@"Location"][@"Region"];
        
        return;
    }
}

@end
