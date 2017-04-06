//
//  ContactListTableViewCell.m
//  MidtermProject
//
//  Created by David Guichon on 2017-04-06.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "ContactListTableViewCell.h"
#import "Contact+CoreDataProperties.h"

@implementation ContactListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureCell:(Contact *)contact{
    //SET THE CELL PROPERTIES
    //FIRST NAME, LAST NAME, COMPANY NAME
}

@end
