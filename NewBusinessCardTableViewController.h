//
//  NewBusinessCardTableViewController.h
//  MidtermProject
//
//  Created by Alex Rapier on 05/04/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NewBusinessCardTableViewController : UITableViewController

@property (nonatomic, strong) NSString *rawContactInformation;

- (void)sortMultipleStringsFromRawContactInfo;

@end
