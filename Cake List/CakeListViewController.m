//
//  CakeListViewController.m
//  Cake List
//
//  Created by Stewart Hart on 19/05/2015.
//  Copyright (c) 2015 Stewart Hart. All rights reserved.
//

#import "CakeListViewController.h"
#import "CakeCell.h"
#import <Cake_List-Swift.h>

@interface CakeListViewController()
@property (strong, nonatomic) NSArray<Cake *> *cakes;
@end

@implementation CakeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData:nil];
}

- (void)setCakesWith:(NSArray<Cake *> *)cakes {
    if (cakes != nil) {
        self.cakes = cakes;
    }
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cakes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    
    CakeCell *cell = (CakeCell*)[tableView dequeueReusableCellWithIdentifier:@"CakeCell" forIndexPath:indexPath];
    [cell setupCell:self.cakes[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)getData:(void (^)(BOOL success, NSError *error))completionHandler {
    
    Bakery *bakery = [Bakery new];
    [bakery getCakesWithCompleteion:^(NSArray<Cake *> *cakes, NSError *error) {
        if (error != nil) {
            
            if (completionHandler != nil) {
                completionHandler(FALSE, error);
            }
            
            // Deal with error
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Oops, seems we couldn't load the cakes!\n" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
            [alert addAction:[UIAlertAction actionWithTitle:@"Retry" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self getData:nil];
            }]];
            [self.navigationController presentViewController:alert animated:TRUE completion:nil];
                                        
        } else {
            if (cakes != nil) {
                self.cakes = cakes;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
                
                if (completionHandler != nil) {
                    completionHandler(TRUE, nil);
                }
            }
        }
    }];
}

@end
