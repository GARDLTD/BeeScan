//
//  MyDataController.h
//  MidtermProject
//
//  Created by David Guichon on 2017-04-05.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ListOfContacts+CoreDataClass.h"

@interface MyDataController : NSObject

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) ListOfContacts *listOfContacts;

+ (id)sharedDataController;

- (void)saveContext;

@end
