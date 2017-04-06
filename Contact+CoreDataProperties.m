//
//  Contact+CoreDataProperties.m
//  MidtermProject
//
//  Created by David Guichon on 2017-04-05.
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
