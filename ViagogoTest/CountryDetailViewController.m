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

@interface CountryDetailViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSDictionary *dataDictionary;
@property (strong, nonatomic) NSArray *sectionsInOrder;

@end

@implementation CountryDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    CountryDataProvider *countryDataProvider = [CountryDataProvider new];
    self.dataDictionary = [countryDataProvider provideDataForCountry:self.country];
    
    self.sectionsInOrder = @[@"Names", @"Flag", @"Capital", @"Location", @"Size", @"Borders", @"Practical Info", @"Other Info"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [[self.dataDictionary allKeys] count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[self.dataDictionary[self.sectionsInOrder[section]] allKeys] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.sectionsInOrder[indexPath.section] isEqualToString:@"Flag"]) {
        
        return 250;
    }
    
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *currentSection = self.sectionsInOrder[indexPath.section];
    
    NSDictionary *currentItem = self.dataDictionary[currentSection];

    if ([currentSection isEqualToString:@"Names"]) {
        
        CountryDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleAndData"];
        
        switch (indexPath.row) {
            case 0:
                
                cell.titleLabel.text = @"Name:";
                cell.dataLabel.text = (NSString *)currentItem[@"Name"];
                
                break;
                
            case 1:
                
                cell.titleLabel.text = @"Native Spelling:";
                cell.dataLabel.text = (NSString *)currentItem[@"Native Spelling"];
                
                break;
                
            case 2:
                
                cell.titleLabel.text = @"Alternative Spellings:";
                cell.dataLabel.text = [(NSArray *)currentItem[@"Alternative Spellings"] componentsJoinedByString:@", "];
                
            default:
                break;
        }
        
        return cell;
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
        
        CountryDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleAndData"];
        
        switch (indexPath.row) {
            case 0:
                
                cell.titleLabel.text = @"Region:";
                cell.dataLabel.text = (NSString *)currentItem[@"Region"];
                
                break;
                
            case 1:
                
                cell.titleLabel.text = @"Subregion:";
                cell.dataLabel.text = (NSString *)currentItem[@"Subregion"];
                
                break;
                
            case 2:
                
                cell.titleLabel.text = @"Coordinates:";
                cell.dataLabel.text = [self makeStringFromCoordinatesDictionary:(NSDictionary *)currentItem[@"Coordinates"]];
                
            default:
                break;
        }
        
        return cell;
    }
    
    if ([currentSection isEqualToString:@"Size"]) {
        
        CountryDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleAndData"];
        
        switch (indexPath.row) {
                
            case 0:
                
                cell.titleLabel.text = @"Area:";
                cell.dataLabel.text = currentItem[@"Area"];
                
                break;
                
            case 1:
                
                cell.titleLabel.text = @"Population:";
                cell.dataLabel.text = currentItem[@"Population"];
                
            default:
                break;
        }
        
        return cell;
    }
    
    if ([currentSection isEqualToString:@"Borders"]) {
        
        CountryDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleAndData"];
        
        NSArray *keys = [currentItem allKeys];
        
        cell.titleLabel.text = @"";
        cell.dataLabel.text = currentItem[keys[indexPath.row]];
        
        return cell;
    }
    
    if ([currentSection isEqualToString:@"Practical Info"]) {
        
        CountryDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleAndData"];
        
        switch (indexPath.row) {
                
            case 0:
                
                cell.titleLabel.text = @"Demonym: ";
                cell.dataLabel.text = currentItem[@"Demonym"];
                
                break;
                
            case 1:
                
                cell.titleLabel.text = @"Timezones: ";
                cell.dataLabel.text = currentItem[@"Timezones"];
                
                break;
                
            case 2:
                
                cell.titleLabel.text = @"Languages: ";
                cell.dataLabel.text = currentItem[@"Languages"];
                
                break;
                
            case 3:
                
                cell.titleLabel.text = @"Currencies: ";
                cell.dataLabel.text = currentItem[@"Currencies"];
                
                break;
                
            case 4:
                
                cell.titleLabel.text = @"Calling codes: ";
                cell.dataLabel.text = currentItem[@"Calling Codes"];
                
                break;
                
            default:
                break;
        }
        
        return cell;
    }
    
    if ([currentSection isEqualToString:@"Other Info"]) {
        
        CountryDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleAndData"];

        switch (indexPath.row) {
                
            case 0:
                
                cell.titleLabel.text = @"Gini Index: ";
                cell.dataLabel.text = currentItem[@"Gini Index"];
                
                break;
                
            case 1:
                
                cell.titleLabel.text = @"Top Level Domain: ";
                cell.dataLabel.text = currentItem[@"Top Level Domain"];
                
                break;
                
            default:
                break;
        }
        
        return cell;
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

-(NSString *)makeStringFromCoordinatesDictionary:(NSDictionary *)coordinatesDictionary
{
    return [NSString stringWithFormat:@"%@°, %@°", coordinatesDictionary[@"latitude" ] , coordinatesDictionary[@"longitude"]];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionHeaderString = self.sectionsInOrder[section];
    
    return sectionHeaderString;
}

@end
