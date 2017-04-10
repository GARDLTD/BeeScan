
//
//  BusinessCard.m
//  MidtermProject
//
//  Created by Alex Rapier on 04/04/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "BusinessCard.h"

@implementation BusinessCard

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _firstNameArray = [[NSMutableArray alloc] init];
        _lastNameArray = [[NSMutableArray alloc] init];
        _emailArray = [[NSMutableArray alloc] init];
        _phoneNumberArray = [[NSMutableArray alloc] init];
        _websiteArray = [[NSMutableArray alloc] init];
        _companyNameArray = [[NSMutableArray alloc] init];
        _contactInfoDictionary = [[NSMutableDictionary alloc] init];
        _contactInfoArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)setBusinessCardDictionary{
    [self.contactInfoDictionary setValue:self.firstNameArray forKey:@"First Name:"];
    [self.contactInfoDictionary setValue:self.lastNameArray forKey:@"Last Name:"];
    [self.contactInfoDictionary setValue:self.phoneNumberArray forKey:@"Phone Number:"];
    [self.contactInfoDictionary setValue:self.emailArray forKey:@"Email:"];
    [self.contactInfoDictionary setValue:self.companyNameArray forKey:@"Company:"];
    [self.contactInfoDictionary setValue:self.websiteArray forKey:@"Website:"];
}


-(void)setBusinessCardArray{
    [self.contactInfoArray addObject:self.firstNameArray];
    [self.contactInfoArray addObject:self.lastNameArray];
    [self.contactInfoArray addObject:self.phoneNumberArray];
    [self.contactInfoArray addObject:self.emailArray];
    [self.contactInfoArray addObject:self.companyNameArray];
    [self.contactInfoArray addObject:self.websiteArray];
}



@end
