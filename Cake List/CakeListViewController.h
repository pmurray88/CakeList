//
//  CakeListViewController.h
//  Cake List
//
//  Created by Stewart Hart on 19/05/2015.
//  Copyright (c) 2015 Stewart Hart. All rights reserved.
//

#import <UIKit/UIKit.h>

//#ifdef TESTS
//#import "Cake_List-Swift.h"
//#endif

@interface CakeListViewController : UITableViewController

// TODO : - Work out why using the Swift Cake Class here will not compile when running the Test target
//#ifdef TESTS
//- (void)setCakesWith:(NSArray<Cake *> *)cakes;
//#endif

- (void)getData:(void (^)(BOOL success, NSError *error))completionHandler;

@end

