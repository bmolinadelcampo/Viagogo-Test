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
#import "ImagesController.h"

@interface CountryDetailViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) InMemoryCountriesStore *inMemoryCountriesStore;
@property (strong, nonatomic) CountryDataProvider *countryDataProvider;
@property (strong, nonatomic) ImagesController *imagesController;

@end

@implementation CountryDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = self.country.name;
    
    self.imagesController = [ImagesController sharedInstance];
    
    self.inMemoryCountriesStore = [InMemoryCountriesStore sharedInstance];
    
    self.countryDataProvider = [CountryDataProvider new];
    
    [self.countryDataProvider provideDataForCountry:self.country];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    [self.imagesController flush];
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.countryDataProvider.sections count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionHeaderString = self.countryDataProvider.sections[section];
    
    NSString *keyToLocalizedString = [NSString stringWithFormat:@"detail.section.%@", sectionHeaderString];
    
    return NSLocalizedString(keyToLocalizedString, @"");
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[self.countryDataProvider.countryDataDictionary[self.countryDataProvider.sections[section]] allKeys] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.countryDataProvider.sections[indexPath.section] isEqualToString:kFlagSectionKey]) {
        
        return 250;
    }
    
    NSString *currentSection =self.countryDataProvider.sections[indexPath.section];
    NSDictionary *currentItem = self.countryDataProvider.countryDataDictionary[currentSection];

    NSArray *subsectionsArray = [self.countryDataProvider subsectionsForSection:indexPath];
    
    if (subsectionsArray) {
        
        CGRect rect = [currentItem[subsectionsArray[indexPath.row]]
                       boundingRectWithSize:CGSizeMake(self.view.bounds.size.width - 100 , CGFLOAT_MAX)
                       options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                       attributes: @{NSFontAttributeName: [UIFont systemFontOfSize:15]}
                       context:nil];
        
        return MAX(rect.size.height + 20, 44);
        
    }
    
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *currentSection =self.countryDataProvider.sections[indexPath.section];
    
    NSDictionary *currentItem = self.countryDataProvider.countryDataDictionary[currentSection];

    if ([currentSection isEqualToString:kNamesSectionKey]) {
        
        return [self createCellInTableView:tableView atIndexPath:indexPath forCurrentSubsections:self.countryDataProvider.subsectionsInNamesSection];
    }
    
    if ([currentSection isEqualToString:kFlagSectionKey]) {
        
        FlagTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"flagImage"];
        
        cell.flagImageView.image = [UIImage imageNamed:@"placeholder-flag"];
        
        [self.imagesController fetchImageWithUrl:currentItem[kFlagSubsectionKey] withCompletion:^(UIImage *image) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.flagImageView.image = image;
            });
        }];
        
        return  cell;
    }
    
    if ([currentSection isEqualToString:kCapitalSectionKey]) {
        
        CountryDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleAndData"];
        
        cell.titleLabel.text = @"";
        cell.dataLabel.text = currentItem[kCapitalSubsectionKey];
        
        return cell;
    }
    
    if ([currentSection isEqualToString:kLocationSectionKey]) {
        
        return [self createCellInTableView:tableView atIndexPath:indexPath forCurrentSubsections:self.countryDataProvider.subsectionsInLocationSection];
    }
    
    if ([currentSection isEqualToString:kSizeSectionKey]) {
        
        return [self createCellInTableView:tableView atIndexPath:indexPath forCurrentSubsections:self.countryDataProvider.subsectionsInSizeSection];
    }
    
    if ([currentSection isEqualToString:kBordersSectionKey]) {
        
        CountryDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleAndData"];
        
        NSArray *keys = [currentItem allKeys];
        
        cell.titleLabel.text = @"";
        cell.dataLabel.text = currentItem[keys[indexPath.row]];
        
        return cell;
    }
    
    if ([currentSection isEqualToString:kPracticalInfoSectionKey]) {
        
        return [self createCellInTableView:tableView atIndexPath:indexPath forCurrentSubsections:self.countryDataProvider.subsectionsInPracticalInfoSection];
    }
    
    if ([currentSection isEqualToString:kOtherInfoSectionKey]) {
    
        return [self createCellInTableView:tableView atIndexPath:indexPath forCurrentSubsections:self.countryDataProvider.subsectionsInOtherInfoSection];
    }
    
    return [UITableViewCell new];
}


#pragma mark - Private methods

-(CountryDataTableViewCell *)createCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath forCurrentSubsections:(NSArray *)subsectionsArray
{
    CountryDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleAndData"];
    
    NSString *currentSection =self.countryDataProvider.sections[indexPath.section];
    NSDictionary *currentItem = self.countryDataProvider.countryDataDictionary[currentSection];
    
    NSString *keyToLocalizedString = [NSString stringWithFormat:@"detail.subsection.%@", subsectionsArray[indexPath.row]];
    
    cell.titleLabel.text = NSLocalizedString(keyToLocalizedString, @"");
    
    cell.dataLabel.text = currentItem[subsectionsArray[indexPath.row]];
    
    return cell;
}


#pragma mark - UITableViewDelegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.countryDataProvider.sections[indexPath.section] isEqualToString:kBordersSectionKey]) {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        CountryDetailViewController *destinationViewController = [storyboard instantiateViewControllerWithIdentifier:@"CountryDetailViewController"];
        
        NSArray *keys = [self.countryDataProvider.countryDataDictionary[self.countryDataProvider.sections[indexPath.section]] allKeys];
        
        destinationViewController.country = [self.inMemoryCountriesStore countryForCode:keys[indexPath.row]];
        
        [self.navigationController pushViewController:destinationViewController animated:YES];
        
        return;
    }
    
    if ([self.countryDataProvider.sections[indexPath.section] isEqualToString:kLocationSectionKey] && [self.countryDataProvider.subsectionsInLocationSection indexOfObject:kRegionSubsectionKey] == indexPath.row) {
        
        [self performSegueWithIdentifier:@"showRegion" sender:self];
        
        return;
    }
}


#pragma mark - Storyboard methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showRegion"]) {
        
        CountryListViewController *destinationViewController = segue.destinationViewController;
        destinationViewController.region = self.countryDataProvider.countryDataDictionary[kLocationSectionKey][kRegionSubsectionKey];
        
        return;
    }
}

@end
