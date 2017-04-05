//
//  BusinessCard.h
//  MidtermProject
//
//  Created by Alex Rapier on 04/04/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusinessCard : NSObject

@property (nonatomic) NSMutableDictionary *contactInfoDictionary;
@property (nonatomic) NSMutableArray *contactInfoArray;

@property (nonatomic) NSMutableArray *companyNameArray;
@property (nonatomic) NSMutableArray *emailArray;
@property (nonatomic) NSMutableArray *phoneNumberArray;
@property (nonatomic) NSMutableArray *websiteArray;
@property (nonatomic) NSMutableArray *firstNameArray;
@property (nonatomic) NSMutableArray *lastNameArray;

-(void)setBusinessCardDictionary;
-(void)setBusinessCardArray;


@end
