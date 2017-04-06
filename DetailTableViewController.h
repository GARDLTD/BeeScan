//
//  DetailTableViewController.h
//  MidtermProject
//
//  Created by David Guichon on 2017-04-06.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact+CoreDataProperties.h"

@interface DetailTableViewController : UITableViewController

@property (weak, nonatomic) Contact *contact;

- (void)configureDetailViewProperties:(Contact *)contact;

@end
