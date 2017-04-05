//
//  NewContactViewController.m
//  MidtermProject
//
//  Created by David Guichon on 2017-04-02.
//  Copyright © 2017 MicroBlink. All rights reserved.
//


//REMOVED TABLEVIEW CELL CUSTOM CLASS AND ALL RELATED METHODS

#import "NewContactViewController.h"
#import "BusinessCard.h"
//#import "CustomTableViewCell.h"


@interface NewContactViewController () //<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray <NSString *> *rawInfoStrings;
@property (nonatomic, strong) NSMutableArray <NSString *> *filteredStrings;

@property (nonatomic, strong) BusinessCard *businessCard;


@property (strong, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *companyTextField;
@property (strong, nonatomic) IBOutlet UITextField *websiteTextField;

@end


@implementation NewContactViewController

//- (void)sortMultipleStringsFromRawContactInfo{
//    
//    [self setAndInitializeVCProperties];
//    
//    [self correctedForCommercialAtError];
//    
//    [self replaceVVWithW];
//    
//    [self replaceExclamationWithL];
//    
//    [self trimSpecialCharacters];
//
//    [self removeOneAndTwoCharacterStringCounts];
//    
//    [self runFilteredStringsThroughSetterMethods];
//    
//    [self.businessCard setBusinessCardArray];
//    
//    [self setTextFieldPropertiesFromBusinessCard];
//    
//    return;
//}

-(void) setTextFieldPropertiesFromBusinessCard{
    
    self.firstNameTextField.text = self.businessCard.firstNameArray[0];
    self.lastNameTextField.text = self.businessCard.lastNameArray[0];
    self.phoneNumberTextField.text = self.businessCard.phoneNumberArray[0];
    self.emailTextField.text = self.businessCard.emailArray[0];
    self.companyTextField.text = self.businessCard.companyNameArray[0];
    self.websiteTextField.text = self.businessCard.websiteArray[0];
}





#pragma METHODS FOR SORTING RAW DATA INTO FILTERED STRINGS


-(void)setAndInitializeVCProperties{
    self.rawInfoStrings = [self.rawContactInformation componentsSeparatedByString:@"\n"];
    self.filteredStrings = [[NSMutableArray alloc] initWithArray:self.rawInfoStrings];
    self.businessCard = [[BusinessCard alloc] init];
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
    NSMutableCharacterSet *whiteListCharacters = [NSMutableCharacterSet characterSetWithCharactersInString:@"@.- "];
    
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
        
        NSArray *components = [currentString componentsSeparatedByString:@" "];
        
        NSArray *listOfNames = [[NSArray alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"names" ofType:@"plist"]];
        
        for (int i= 0; i < components.count; i++) {
            NSString *capitalizedComponent = [components[i] uppercaseString];
            for (int g = 0; g < listOfNames.count; g++) {
                if ([capitalizedComponent isEqualToString:listOfNames[g]]){
                    
                    [self.businessCard.firstNameArray addObject:[self capitaliseFirstCharacter:components[i]]];
                    [self.businessCard.lastNameArray addObject:[self capitaliseFirstCharacter:components[i]]];
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
    if ([currentString containsString:@".c"] && [currentString containsString:@"www."]) {
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






@end
