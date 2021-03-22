//
//  ViewController.m
//  ObjC-Example
//
//  Created by Mikhail Akopov on 02.12.2019.
//  Copyright © 2019 GetID. All rights reserved.
//

#import "ViewController.h"
#import "ObjC-Example-Swift.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"Verify me" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(verifyMe:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:button];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [[button.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor] setActive:YES];
    [[button.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor] setActive:YES];
}

- (void)verifyMe:(UIButton *)sender {
    GetIDSwiftWrapper *wrapper = [GetIDSwiftWrapper new];
    [wrapper startVerificationFlow];
}
@end
