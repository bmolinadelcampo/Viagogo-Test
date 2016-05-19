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

@interface CountryListViewController()

@property (strong, nonatomic) NetworkManager *networkManager;

@end

@implementation CountryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.networkManager = [NetworkManager new];
    [self.networkManager fetchCountriesWithCompletionHandler:^(NSArray *countries, NSError *error) {
        
        NSLog(@"Completed");
        
        for (Country *country in countries) {
            NSLog(@"%@", country.name);
        }
        
        NSLog(@"%lul", (unsigned long)countries.count);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [UITableViewCell new];
}

@end
