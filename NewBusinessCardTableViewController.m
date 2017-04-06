//
//  NewBusinessCardTableViewController.m
//  MidtermProject
//
//  Created by Alex Rapier on 05/04/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "NewBusinessCardTableViewController.h"
#import "MyDataController.h"
#import "NewContactViewController.h"
#import "BusinessCard.h"
#import "ViewController.h"






@interface NewBusinessCardTableViewController () //<UITableViewDelegate, UITableViewDataSource>



@property (nonatomic, strong) NSArray <NSString *> *rawInfoStrings;
@property (nonatomic, strong) NSMutableArray <NSString *> *filteredStrings;

@property (nonatomic, strong) BusinessCard *businessCard;

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyTextField;
@property (weak, nonatomic) IBOutlet UITextField *websiteTextField;

@property (strong, nonatomic) Contact *contact;
@property (weak, nonatomic) MyDataController *myDataController;

@end

@implementation NewBusinessCardTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self setTextFieldPropertiesFromBusinessCard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}
*/
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


- (void)sortMultipleStringsFromRawContactInfo{
    
    [self setAndInitializeVCProperties];
    
    [self correctedForCommercialAtError];
    
    [self replaceVVWithW];
    
    [self replaceExclamationWithL];

    [self accentsRemoval];
    
    [self trimSpecialCharacters];
    
    [self removeOneAndTwoCharacterStringCounts];
    
    [self runFilteredStringsThroughSetterMethods];
    
    [self.businessCard setBusinessCardArray];
    
    return;
}

-(void) setTextFieldPropertiesFromBusinessCard{
    
    if (self.businessCard.firstNameArray.count > 0) {
        self.firstNameTextField.text = self.businessCard.firstNameArray[0];
    }
    if (self.businessCard.lastNameArray.count > 0) {
        self.lastNameTextField.text = self.businessCard.lastNameArray[0];
    }
    if (self.businessCard.phoneNumberArray.count > 0){
        self.phoneNumberTextField.text = self.businessCard.phoneNumberArray[0];
    }
    if (self.businessCard.emailArray.count > 0) {
        self.emailTextField.text = self.businessCard.emailArray[0];
    }
    if (self.businessCard.companyNameArray.count > 0) {
        self.companyTextField.text = self.businessCard.companyNameArray[0];
    }
    if (self.businessCard.websiteArray.count > 0) {
        self.websiteTextField.text = self.businessCard.websiteArray[0];
    }
}

-(void)setContactProperties{
    self.contact.firstName = self.firstNameTextField.text;
    self.contact.lastName = self.lastNameTextField.text;
    self.contact.phoneNumber = self.phoneNumberTextField.text;
    self.contact.email = self.emailTextField.text;
    self.contact.company = self.companyTextField.text;
    self.contact.website = self.websiteTextField.text;
    NSError *err;
    [self.myDataController.managedObjectContext save:&err];
    // TODO: check error
}



#pragma METHODS FOR SORTING RAW DATA INTO FILTERED STRINGS


-(void)setAndInitializeVCProperties{
    self.rawInfoStrings = [self.rawContactInformation componentsSeparatedByString:@"\n"];
    self.filteredStrings = [[NSMutableArray alloc] initWithArray:self.rawInfoStrings];
    self.businessCard = [[BusinessCard alloc] init];
    self.myDataController = [MyDataController sharedDataController];
    self.contact = [[Contact alloc] initWithContext:self.myDataController.managedObjectContext];
}



//REMOVES ANY COMPONENT THAT HAS TWO CHARACTERS OR LESS FROM EACH STRING
//ITERATES THROUGH EACH RAW STRING. BREAKS DOWN RAW STRING INTO COMPONENTS. REMOVES ANY COMPONENT THAT HAS TWO CHARACTERS OR LESS FROM EACH STRING
-(void)removeOneAndTwoCharacterStringCounts{
    
    NSArray *unprocessedStringsArray = [[NSArray alloc] initWithArray:self.filteredStrings];
    NSMutableArray *processedStringsArray = [[NSMutableArray alloc] init];
    
    for (NSString *string in unprocessedStringsArray) {
        
        NSArray <NSString *> *componentsOfARawString = [string componentsSeparatedByString:@" "];
        NSMutableArray <NSString *> *componentsOfAFilteredString = [[NSMutableArray alloc] init];
        
        for (NSString *componentOfString in componentsOfARawString) {
            if (componentOfString.length > 2){
                [componentsOfAFilteredString addObject:componentOfString];
            }
        }
        
        NSString *filteredString = nil;
        for (int i = 0; i < componentsOfAFilteredString.count; i++) {
            if (i == 0) {
                filteredString = [NSString stringWithFormat:@"%@",componentsOfAFilteredString[i]];
            }
            else {
                filteredString = [NSString stringWithFormat:@"%@ %@", filteredString, componentsOfAFilteredString[i]];
            }
        }
        
        if (filteredString.length !=0){
            [processedStringsArray addObject:filteredString];
        }
    }
    self.filteredStrings = nil;
    self.filteredStrings = [[NSMutableArray alloc] initWithArray:processedStringsArray];
}



//REMOVES ANY CHARACTERS THAT ARE NOT ALPHANUMERIC (EXCLUDING A FEW EXCEPTIONS
-(void)trimSpecialCharacters{
    
    NSMutableArray <NSString *> *filteredStringsArray = [[NSMutableArray alloc] init];
    
    NSCharacterSet *alphaCharacterSet = [NSCharacterSet alphanumericCharacterSet];
    NSMutableCharacterSet *whiteListCharacters = [NSMutableCharacterSet characterSetWithCharactersInString:@"@.-, "];
    
    [whiteListCharacters formUnionWithCharacterSet:alphaCharacterSet];
    NSCharacterSet *bannedCharacters = [whiteListCharacters invertedSet];
    
    for (NSString *string in self.filteredStrings) {
        NSString *trimmedString = [[string componentsSeparatedByCharactersInSet:bannedCharacters]componentsJoinedByString:@""];
        
        if (trimmedString.length > 0) {
            [filteredStringsArray addObject:trimmedString];
        }
    }
    
    self.filteredStrings = [[NSMutableArray alloc] initWithArray:filteredStringsArray];
}

-(void)replaceVVWithW {
    NSMutableArray <NSString *> *filterStringsArray = [[NSMutableArray alloc]init];
    for (NSString *string in self.filteredStrings) {
        NSString *replacedLowerCaseV = [string stringByReplacingOccurrencesOfString:@"vv" withString:@"w"];
        NSString *replacedBothVs = [replacedLowerCaseV stringByReplacingOccurrencesOfString:@"VV" withString:@"W"];
        [filterStringsArray addObject:replacedBothVs];
    }
    self.filteredStrings = [[NSMutableArray alloc]initWithArray:filterStringsArray];
}


-(void)replaceExclamationWithL{
    NSMutableArray <NSString *> *filteredStringsArray = [[NSMutableArray alloc]init];
    for (NSString *string in self.filteredStrings) {
        NSString *replaceExclamationPoint = [string stringByReplacingOccurrencesOfString:@"!" withString:@"i"];
        [filteredStringsArray addObject:replaceExclamationPoint];
    }
    self.filteredStrings = [[NSMutableArray alloc]initWithArray:filteredStringsArray];
}

-(void)accentsRemoval {
    NSMutableArray <NSString *> *filteredStringsArray = [[NSMutableArray alloc]init];
    for (NSString *string in self.filteredStrings) {
        NSString *replaceAccent = [string stringByReplacingOccurrencesOfString:@"í" withString:@"i"];
        [filteredStringsArray addObject:replaceAccent];
    }
    self.filteredStrings = [[NSMutableArray alloc]initWithArray:filteredStringsArray];
    
}


-(void)correctedForCommercialAtError{
    NSMutableArray *filteredStringsArray = [[NSMutableArray alloc]init];
    NSString *fixedCommericalAt = [[NSString alloc] init];
    
    NSArray *blackList = @[@"<g", @"g>", @"(g>", @"<g>", @"<g)", @"(g)"];
    
    for (NSString *string in self.filteredStrings) {
        for (int i = 0; i < blackList.count; i++) {
            fixedCommericalAt = [string stringByReplacingOccurrencesOfString:blackList[i] withString:@"@"];
            [filteredStringsArray addObject:fixedCommericalAt];
        }
    }
    self.filteredStrings = [[NSMutableArray alloc]initWithArray:filteredStringsArray];
}



//THIS METHOD RUNS EACH STRING (THAT HAS BEEN FILTERED FOR BUGS/ERRORS CAUSED BY BAD READS) THROUGH METHODS TO DETERMINE WHAT TEXTFIELD IT BELONGS TO
- (void)runFilteredStringsThroughSetterMethods{
    for (NSString *string in self.filteredStrings) {
        [self nameStringGetter:string];
        [self phoneStringGetter:string];
        [self emailStringGetter:string];
        [self companyStringGetter:string];
        [self websiteStringGetter:string];
    }
}





#pragma METHODS FOR SETTING PROPERTIES


-(void)nameStringGetter:(NSString *)currentString {
    
    if (![currentString containsString:@"@"]) {
        
        NSString *replaceComma = [currentString stringByReplacingOccurrencesOfString:@"," withString:@" "];
        NSArray *components = [replaceComma componentsSeparatedByString:@" "];
        
        NSArray *listOfNames = [[NSArray alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"names" ofType:@"plist"]];
        
        for (int i= 0; i < components.count; i++) {
            NSString *capitalizedComponent = [components[i] uppercaseString];
            for (int g = 0; g < listOfNames.count; g++) {
                if ([capitalizedComponent isEqualToString:listOfNames[g]]){
                    
                    [self.businessCard.firstNameArray addObject:[self capitaliseFirstCharacter:components[i]]];
                    [self.businessCard.lastNameArray addObject:[self capitaliseFirstCharacter:components[i+1]]];
                    return;
                }
            }
        }
    }
}



-(void)phoneStringGetter:(NSString *)currentString {
    
    //Loops through every item in the array.
    NSString *correctedForOError = [currentString stringByReplacingOccurrencesOfString:@"O" withString:@"0"];
    
    NSCharacterSet *charactersToRemove = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    
    NSString *remainingString = [[correctedForOError componentsSeparatedByCharactersInSet:charactersToRemove] componentsJoinedByString:@""];
    NSString *spacelessString = [remainingString stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *dashlessString = [spacelessString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSString *dotlessString = [dashlessString stringByReplacingOccurrencesOfString:@"." withString:@""];
    
    if (dotlessString.length >= 9) {
        //Checks if the length of the string is long enough to be a mobile number as well as checking if the string contains any numbers.
        [self.businessCard.phoneNumberArray addObject:spacelessString];
        return;
    }
    else {
        return;
    }
}


-(void)emailStringGetter:(NSString *)currentString {
    NSArray *componentsOfString = [currentString componentsSeparatedByString:@" "];
    for (NSString *component in componentsOfString) {
        if ([component containsString:@"@"] && [component containsString:@".c"]) {
            
            [self.businessCard.emailArray addObject:component];
            
            return;
        }
    }
}


-(void)companyStringGetter:(NSString *)currentString {
    if ([currentString containsString:@"@"] && [currentString containsString:@".c"]) {
        NSArray *componetsSeperatedByComericalAt = [currentString componentsSeparatedByString:@"@"];
        NSString *lastComponent = componetsSeperatedByComericalAt[componetsSeperatedByComericalAt.count-1];
        NSArray *componentsSeperatedByDotC = [lastComponent componentsSeparatedByString:@"."];
        NSString *firstComponent = componentsSeperatedByDotC[0];
        NSString *companyString = [self capitaliseFirstCharacter:firstComponent];
        [self.businessCard.companyNameArray addObject:companyString];
    }
}


-(void)websiteStringGetter:(NSString *)currentString {
    if ([currentString containsString:@".c"] && ![currentString containsString:@"@"]) {
        [self.businessCard.websiteArray addObject:currentString];
    }
}


#pragma Additional Methods


-(NSString *)capitaliseFirstCharacter:(NSString *)string{
    char firstChar = [string characterAtIndex:0];
    NSString *firtString = [NSString stringWithFormat:@"%c",firstChar];
    NSString *firstLetterCapitalised = [firtString capitalizedString];
    NSString *finalString = [string.lowercaseString stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:firstLetterCapitalised];
    return finalString;
}


#pragma Nav Bar Buttons

- (IBAction)retakePhoto:(UIBarButtonItem *)sender {
    //EXECUTE A SEGUE BACK TO THE CAMERA VIEW
}

- (IBAction)saveBusinessCard:(UIBarButtonItem *)sender {
    [self setContactProperties];
//    [self performSegueWithIdentifier:@"returnToListOfContacts" sender:sender];
    [self dismissViewControllerAnimated:YES completion:nil];
}
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    if ([segue.identifier isEqualToString:@"returnToListOfContacts"]){
//        //ViewController *destination = [segue destinationViewController];
//        NSError *err = nil;
//        [self.myDataController.managedObjectContext save:&err];
//        if (err){
//            NSLog(@"There is an error at the bottom of the NewBusinessContactViewController");
//        }
//    }
//}
//





@end
