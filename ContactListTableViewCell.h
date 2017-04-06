//
//  ContactListTableViewCell.h
//  MidtermProject
//
//  Created by David Guichon on 2017-04-06.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact+CoreDataProperties.h"

@interface ContactListTableViewCell : UITableViewCell

-(void)configureCell:(Contact *)contact;

@end

