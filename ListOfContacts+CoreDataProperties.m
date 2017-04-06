//
//  ListOfContacts+CoreDataProperties.m
//  MidtermProject
//
//  Created by David Guichon on 2017-04-05.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "ListOfContacts+CoreDataProperties.h"

@implementation ListOfContacts (CoreDataProperties)

+ (NSFetchRequest<ListOfContacts *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ListOfContacts"];
}

@dynamic cardDeck;

@end
