//
//  Contact+CoreDataProperties.h
//  MidtermProject
//
//  Created by David Guichon on 2017-04-05.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "Contact+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Contact (CoreDataProperties)

+ (NSFetchRequest<Contact *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *company;
@property (nullable, nonatomic, copy) NSString *email;
@property (nullable, nonatomic, copy) NSString *firstName;
@property (nullable, nonatomic, copy) NSString *lastName;
@property (nullable, nonatomic, copy) NSString *phoneNumber;
@property (nullable, nonatomic, copy) NSString *website;
@property (nullable, nonatomic, retain) ListOfContacts *contactList;

@end

NS_ASSUME_NONNULL_END
