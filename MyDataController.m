//
//  MyDataController.m
//  MidtermProject
//
//  Created by David Guichon on 2017-04-05.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "MyDataController.h"


@interface MyDataController ()

@property (strong, nonatomic) NSPersistentContainer *persistentContainer;

@end



@implementation MyDataController

- (id)init
{
    self = [super init];
    if (!self) return nil;

    self.persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Model"];
    [self.persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *description, NSError *error) {
        if (error != nil) {
            NSLog(@"Failed to load Core Data stack: %@", error);
            abort();
        }
    }];

    return self;
}

+ (id)sharedDataController{
    static MyDataController *myDataController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        myDataController = [[self alloc] init];
    });
    return myDataController;
}

- (void)setManagedObjectContext{
    self.managedObjectContext = self.persistentContainer.viewContext;
}

- (void)saveContext{
    NSError *error;
    [self.managedObjectContext save:&error];
    if (error) {
        NSLog(@"There Was An Error In the My Data Controller");
    }
}


@end
