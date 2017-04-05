//
//  ViewController.m
//  BlinkOCR-sample
//
//  Created by Jura on 02/03/15.
//  Copyright (c) 2015 MicroBlink. All rights reserved.
//

#import "ViewController.h"

#import <MicroBlink/MicroBlink.h>

// Set This As The Scan SEtting
//PPRecognitionModeDefault,


#import "NewBusinessCardTableViewController.h"
#import <MicroBlink/PPOcrResultOverlaySubview.h>
#import <MicroBlink/PPModernOcrResultOverlaySubview.h>

@interface ViewController () <PPScanningDelegate>

@property (nonatomic, strong) NSString* rawOcrParserId;
@property (nonatomic, strong) UIButton* photoButton;
@property (nonatomic, strong) UIViewController<PPScanningViewController> *scanningVC;
@property (nonatomic, strong) NSString *rawContactInfo;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rawOcrParserId = @"Raw ocr";
}

/**
 * Method allocates and initializes the Scanning coordinator object.
 * Coordinator is initialized with settings for scanning
 *
 *  @param error Error object, if scanning isn't supported
 *
 *  @return initialized coordinator
 */
- (PPCameraCoordinator *)coordinatorWithError:(NSError**)error {
    
    /** 0. Check if scanning is supported */
    
    if ([PPCameraCoordinator isScanningUnsupportedForCameraType:PPCameraTypeBack error:error]) {
        return nil;
    }
    
    
    /** 1. Initialize the Scanning settings */
    
    // Initialize the scanner settings object. This initialize settings with all default values.
    PPSettings *settings = [[PPSettings alloc] init];
    
    
    /** 2. Setup the license key */
    
    // Visit www.microblink.com to get the license key for your app
    settings.licenseSettings.licenseKey = @"O4IMYLDI-QDNTXNOY-4VO75YBA-6RCBTTBK-YU65RZKR-ZZFTANHN-SJ2WFY4D-6UUG3FHB";
    
    
    /**
     * 3. Set up what is being scanned. See detailed guides for specific use cases.
     * Here's an example for initializing raw OCR scanning.
     */
    
    // To specify we want to perform OCR recognition, initialize the OCR recognizer settings
    PPBlinkOcrRecognizerSettings *ocrRecognizerSettings = [[PPBlinkOcrRecognizerSettings alloc] init];
    
    
    // We want raw OCR parsing
    [ocrRecognizerSettings addOcrParser:[[PPRawOcrParserFactory alloc] init] name:self.rawOcrParserId];
    

    // Add the recognizer setting to a list of used recognizer
    [settings.scanSettings addRecognizerSettings:ocrRecognizerSettings];
    
    
    /** 4. Initialize the Scanning Coordinator object */
    PPCameraCoordinator *coordinator = [[PPCameraCoordinator alloc] initWithSettings:settings delegate:nil];
    
    return coordinator;
}

- (IBAction)didTapScan:(id)sender {
    
    /** Instantiate the scanning coordinator */
    NSError *error;
    PPCameraCoordinator *coordinator = [self coordinatorWithError:&error];
    
    /** If scanning isn't supported, present an error */
    if (coordinator == nil) {
        NSString *messageString = [error localizedDescription];
        [[[UIAlertView alloc] initWithTitle:@"Warning"
                                    message:messageString
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
        
        return;
    }
    
    /** Allocate and present the scanning view controller */
   self.scanningVC = [PPViewControllerFactory cameraViewControllerWithDelegate:self coordinator:coordinator error:nil];
    
//SET THE BUTTON
    float buttonXPosition = self.view.frame.size.width / 2;
    float buttonYPosition = self.view.frame.size.height - 50;
    
    self.photoButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonXPosition, buttonYPosition, 50, 50)];
    [self.photoButton addTarget:self action:@selector(didTapPhotoButton) forControlEvents:1 <<  6];
    self.photoButton.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.photoButton];
    
    /** You can use other presentation methods as well */
    //[self presentViewController:scanningViewController animated:YES completion:nil];
    
    [self addChildViewController:self.scanningVC];
    
    self.scanningVC.view.frame = CGRectInset(self.view.frame, 0, 50);
    [self.view addSubview:self.scanningVC.view];
    
    
    
}


-(IBAction)didTapPhotoButton{
    [self performSegueWithIdentifier:@"createNewContact" sender:nil];


    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"createNewContact"]) {
        [self.scanningVC pauseScanning];
        NewBusinessCardTableViewController *newBusinessCardVC = [segue destinationViewController];
        [newBusinessCardVC setRawContactInformation:self.rawContactInfo];
        [newBusinessCardVC sortMultipleStringsFromRawContactInfo];

    }
}

#pragma mark - PPScanDelegate

- (void)scanningViewControllerUnauthorizedCamera:(UIViewController<PPScanningViewController> *)scanningViewController {
    // Add any logic which handles UI when app user doesn't allow usage of the phone's camera
}

- (void)scanningViewController:(UIViewController<PPScanningViewController> *)scanningViewController
                  didFindError:(NSError *)error {
    // Can be ignored. See description of the method
}

- (void)scanningViewControllerDidClose:(UIViewController<PPScanningViewController> *)scanningViewController {
    
    // As scanning view controller is presented full screen and modally, dismiss it
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)scanningViewController:(UIViewController<PPScanningViewController> *)scanningViewController
              didOutputResults:(NSArray *)results {
    
    // Here you process scanning results. Scanning results are given in the array of PPRecognizerResult objects.
    
    // first, pause scanning until we process all the results
    [self.scanningVC pauseScanning];
    
    // Collect data from the result
    for (PPRecognizerResult* result in results) {
        
        if ([result isKindOfClass:[PPBlinkOcrRecognizerResult class]]) {
            PPBlinkOcrRecognizerResult* ocrRecognizerResult = (PPBlinkOcrRecognizerResult*)result;
            
            NSLog(@"OCR results are:");
            NSLog(@"Raw ocr: %@", [ocrRecognizerResult parsedResultForName:self.rawOcrParserId]);
            self.rawContactInfo = [NSString stringWithFormat:@"%@", [ocrRecognizerResult parsedResultForName:self.rawOcrParserId]];
            
            
            PPOcrLayout* ocrLayout = [ocrRecognizerResult ocrLayout];
            NSLog(@"Dimensions of ocrLayout are %@", NSStringFromCGRect([ocrLayout box]));
        }
    };
    
    // resume scanning while preserving inter[[[[[[['nal recognizer state
    [self.scanningVC resumeScanningAndResetState:NO];
}

// dismiss the scanning view controller when user presses OK.
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
