//
//  Contact+CoreDataProperties.m
//  MidtermProject
//
//  Created by Alex Rapier on 06/04/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "Contact+CoreDataProperties.h"

@implementation Contact (CoreDataProperties)

+ (NSFetchRequest<Contact *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Contact"];
}

@dynamic company;
@dynamic email;
@dynamic firstName;
@dynamic lastName;
@dynamic phoneNumber;
@dynamic website;
@dynamic contactList;

@end
