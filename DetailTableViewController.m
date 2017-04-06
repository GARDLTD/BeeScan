//
//  DetailTableViewController.m
//  MidtermProject
//
//  Created by David Guichon on 2017-04-06.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "DetailTableViewController.h"
#import "MyDataController.h"

@interface DetailTableViewController ()

@property (weak, nonatomic) MyDataController *myDatacontroller;

@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;
@property (strong, nonatomic) IBOutlet UITextField *firstNameDetailLabel;
@property (strong, nonatomic) IBOutlet UITextField *lastNameDetailLabel;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumberDetailLabel;
@property (strong, nonatomic) IBOutlet UITextField *emailDetailLabel;
@property (strong, nonatomic) IBOutlet UITextField *companyDetailLabel;
@property (strong, nonatomic) IBOutlet UITextField *websiteDetailLabel;


@end

@implementation DetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureDetailViewProperties:self.contact];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureDetailViewProperties:(Contact *)contact{
    //SET ALL THE PROPERTIES
    self.myDatacontroller = [MyDataController sharedDataController];
//    self.contact = contact;
    self.firstNameDetailLabel.text = self.contact.firstName;
    self.lastNameDetailLabel.text = self.contact.lastName;
    self.phoneNumberDetailLabel.text = self.contact.phoneNumber;
    self.emailDetailLabel.text = self.contact.email;
    self.companyDetailLabel.text = self.contact.company;
    self.websiteDetailLabel.text = self.contact.website;
    
    [self.tableView reloadData];
}

-(void)savePropertiesToContactInfo{
    self.contact.firstName = self.firstNameDetailLabel.text;
    self.contact.lastName = self.lastNameDetailLabel.text;
    self.contact.phoneNumber = self.phoneNumberDetailLabel.text;
    self.contact.email = self.emailDetailLabel.text;
    self.contact.company = self.companyDetailLabel.text;
    self.contact.website = self.websiteDetailLabel.text;
}

- (IBAction)saveContactInformation:(id)sender {
    [self savePropertiesToContactInfo];
    [self.myDatacontroller saveContext];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
