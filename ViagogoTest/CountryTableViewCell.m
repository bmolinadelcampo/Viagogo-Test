//
//  CountryTableViewCell.m
//  ViagogoTest
//
//  Created by Belén Molina del Campo on 19/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "CountryTableViewCell.h"

@interface CountryTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *flagImageView;
@property (weak, nonatomic) IBOutlet UILabel *countryNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *capitalLabel;
@property (weak, nonatomic) IBOutlet UILabel *populationLabel;

@end

@implementation CountryTableViewCell

- (void)awakeFromNib {

    [super awakeFromNib];
    
    [self prepareCell];
    
}

-(void)prepareForReuse {
    
    [super prepareForReuse];
    [self prepareCell];
}

-(void)configureCellForCountry: (Country *)country withNumberFormatter:(NSNumberFormatter *)numberFormatter
{
    self.countryNameLabel.text = country.name;
    
    self.capitalLabel.text = country.capital;
    
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    
    self.populationLabel.text = [numberFormatter stringFromNumber:country.population];
    
}

-(void)prepareCell
{
    self.countryNameLabel.text = @"";
    self.capitalLabel.text = @"";
    self.populationLabel.text = @"";
}


@end
