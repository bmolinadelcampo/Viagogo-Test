//
//  CountryDataTableViewCell.m
//  ViagogoTest
//
//  Created by Belén Molina del Campo on 21/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "CountryDataTableViewCell.h"

@implementation CountryDataTableViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    [self prepareCell];
}

-(void)prepareForReuse {
    
    [self prepareCell];
}

-(void)prepareCell
{
    self.titleLabel.text = @"";
    self.dataLabel.text = @"";
}

@end
