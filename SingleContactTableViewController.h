//
//  SingleContactTableViewController.h
//  MidtermProject
//
//  Created by Alex Rapier on 05/04/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "Contact+CoreDataProperties.h"


@interface SingleContactTableViewController : UITableViewController

@property (nonatomic, strong) NSString *rawContactInformation;
@property (nonatomic, strong) ViewController *mainVC;
@property (strong, nonatomic) Contact *contact;

- (void)sortMultipleStringsFromRawContactInfo;
-(void)setOutletProperties;

@end
