//
//  CountryTableViewCell.h
//  ViagogoTest
//
//  Created by Belén Molina del Campo on 19/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Country.h"

@interface CountryTableViewCell : UITableViewCell

-(void)configureCellForCountry: (Country *)country withNumberFormatter:(NSNumberFormatter *)numberFormatter;


@end
