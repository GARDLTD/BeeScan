//
//  Contact+CoreDataProperties.m
//  BeeScan
//
//  Created by David Guichon on 2017-04-10.
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

@end
