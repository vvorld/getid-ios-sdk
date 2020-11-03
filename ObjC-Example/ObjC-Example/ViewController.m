//
//  ViewController.m
//  ObjC-Example
//
//  Created by Mikhail Akopov on 02.12.2019.
//  Copyright © 2019 GetID. All rights reserved.
//

#import "ViewController.h"
@import GetID;

@interface ViewController () <GetIDCompletionDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];

    NSString *apiKey = @"SDK_KEY";
    NSString *url = @"API_URL";
    [GIDFactory makeGetIDViewControllerWithApiKey:apiKey url:url then:^(GetIDViewController *viewController, NSError *error) {
        if (viewController == nil) {
            return;
        }
        viewController.delegate = self;
        [self presentViewController:viewController animated:YES completion:nil];
    }];
}

- (void)getIDDidComplete:(GetIDViewController * _Nonnull)viewController applicationID:(NSString * _Nonnull)applicationID {}
- (void)getIDDidCancel:(GetIDViewController * _Nonnull)viewController {}
- (void)getIDDidFail:(GetIDViewController * _Nonnull)viewController error:(NSError * _Nonnull)error {}
@end
