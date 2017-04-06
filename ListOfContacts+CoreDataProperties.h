//
//  ListOfContacts+CoreDataProperties.h
//  MidtermProject
//
//  Created by Alex Rapier on 06/04/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "ListOfContacts+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ListOfContacts (CoreDataProperties)

+ (NSFetchRequest<ListOfContacts *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSSet<Contact *> *cardDeck;

@end

@interface ListOfContacts (CoreDataGeneratedAccessors)

- (void)addCardDeckObject:(Contact *)value;
- (void)removeCardDeckObject:(Contact *)value;
- (void)addCardDeck:(NSSet<Contact *> *)values;
- (void)removeCardDeck:(NSSet<Contact *> *)values;

@end

NS_ASSUME_NONNULL_END
