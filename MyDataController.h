//
//  MyDataController.h
//  MidtermProject
//
//  Created by David Guichon on 2017-04-05.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Contact+CoreDataClass.h"

@interface MyDataController : NSObject

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


+ (id)sharedDataController;

- (void)setManagedObjectContext;
-(NSArray<Contact *> *)fetchContacts;
- (void)saveContext;

@end
