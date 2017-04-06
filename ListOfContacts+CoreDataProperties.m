//
//  ListOfContacts+CoreDataProperties.m
//  MidtermProject
//
//  Created by Alex Rapier on 06/04/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "ListOfContacts+CoreDataProperties.h"

@implementation ListOfContacts (CoreDataProperties)

+ (NSFetchRequest<ListOfContacts *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ListOfContacts"];
}

@dynamic cardDeck;

@end
