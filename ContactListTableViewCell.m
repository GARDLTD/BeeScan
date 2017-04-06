//
//  ContactListTableViewCell.m
//  MidtermProject
//
//  Created by David Guichon on 2017-04-06.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "ContactListTableViewCell.h"

@interface ContactListTableViewCell ()

@property (strong, nonatomic) IBOutlet UILabel *firstAndLastNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *companyNameLabel;


@end


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
    self.firstAndLastNameLabel.text = [NSString stringWithFormat:@"%@ %@", contact.firstName, contact.lastName];
    self.companyNameLabel.text = [NSString stringWithFormat:@"%@", contact.company];
}

@end
