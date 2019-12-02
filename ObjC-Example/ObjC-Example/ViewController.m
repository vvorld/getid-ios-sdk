//
//  ViewController.m
//  ObjC-Example
//
//  Created by Mikhail Akopov on 02.12.2019.
//  Copyright © 2019 GetID. All rights reserved.
//

#import "ViewController.h"
@import GetID;

@interface ViewController () <GetIDViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];

    NSString *apiKey = @"YOUR_API_KEY";
    NSString *url = @"YOUR_URL";
    [GIDFactory makeGetIDViewControllerWithApiKey:apiKey url:url then:^(GetIDViewController *viewController, NSError *error) {
        if (viewController == nil) {
            return;
        }
        viewController.delegate = self;
        [self presentViewController:viewController animated:YES completion:nil];
    }];
}

- (void)getIDDidCancelled:(GetIDViewController * _Nonnull)viewController {}
- (void)getIDDidCompleteUploadingData:(GetIDViewController * _Nonnull)viewController { }
- (void)getIDDidGetConsent:(GetIDViewController * _Nonnull)viewController { }
- (void)getIDDidUploadData:(GetIDViewController * _Nonnull)viewController {}
- (void)getID:(GetIDViewController * _Nonnull)viewController didCaptureDocument:(NSArray<UIImage *> * _Nonnull)images {}
- (void)getID:(GetIDViewController * _Nonnull)viewController didChooseDocumentType:(enum DocumentType)documentType issuingCountry:(GIDCountry * _Nonnull)country {}
- (void)getID:(GetIDViewController * _Nonnull)viewController didComplete:(NSString * _Nonnull)applicationId {}
- (void)getID:(GetIDViewController * _Nonnull)viewController didSubmitForm:(NSArray<GIDFormField *> * _Nonnull)fields {}
- (void)getID:(GetIDViewController * _Nonnull)viewController didTakeSelfie:(UIImage * _Nonnull)image {}
- (void)getID:(GetIDViewController * _Nonnull)viewController didVerifyLiveness:(NSArray<UIImage *> * _Nonnull)images {}

@end
