//
//  ViewController.m
//  DMTallyLabelExample
//
//  Created by Daniel McCarthy on 1/1/15.
//  Copyright (c) 2015 Daniel McCarthy. All rights reserved.
//

#import "ViewController.h"
#import "DMTallyLabel.h"

@interface ViewController ()

@property (strong, nonatomic) DMTallyLabel *tallyLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTheView];
}

#pragma mark - Setup

- (void)setupTheView {
    CGRect frame = CGRectMake(0, 0, 300, 100);
    self.tallyLabel = [[DMTallyLabel alloc] initWithFrame:frame
                                       singularDescriptor:@"Point"
                                         pluralDescriptor:@"Points"
                                        countIsBiggerFont:YES];
    
    self.tallyLabel.center          = CGPointMake(self.view.center.x, 150);
    self.tallyLabel.font            = [UIFont boldSystemFontOfSize:50.0f];
    self.tallyLabel.textAlignment   = NSTextAlignmentCenter;
    
    /*to hide "outOfValue", simply set it to 0.*/
    /*shouldShowDescriptorText toggles whether to show the description text after the number:
        // YES example: "20 Points"
        // NO  example: "20"*/
    
    [self.tallyLabel startTallyingFromValue:0
                                    toValue:0
                                 outOfValue:0
                       shouldShowDescriptorText:YES
                               withDuration:0.0
                         andCompletionBlock:^(BOOL completed) {
                             //Do stuff when it's finished tallying
                         }];
    
    [self.view addSubview:self.tallyLabel];
}

#pragma mark - Button Methods

- (IBAction)tallyTo1:(id)sender {
    [self.tallyLabel startTallyingFromValue:0.0f
                                    toValue:1.0f
                                 outOfValue:0.0
                   shouldShowDescriptorText:YES
                               withDuration:0.2f
                         andCompletionBlock:^(BOOL completed) {
                             //Do stuff when tally is complete
                         }];
}

- (IBAction)tallyTo50:(id)sender {
    [self.tallyLabel startTallyingFromValue:0.0f
                                    toValue:50.0f
                                 outOfValue:0.0
                   shouldShowDescriptorText:YES
                               withDuration:0.7f
                         andCompletionBlock:^(BOOL completed) {
                             //Do stuff when tally is complete
                         }];
}

- (IBAction)tallyTo199:(id)sender {
    [self.tallyLabel startTallyingFromValue:0.0f
                                    toValue:199.0f
                                 outOfValue:200.0
                   shouldShowDescriptorText:YES
                               withDuration:0.7f
                         andCompletionBlock:^(BOOL completed) {
                             //Do stuff when tally is complete
                         }];
}

- (IBAction)tallyTo1984:(id)sender {
    [self.tallyLabel startTallyingFromValue:0.0f
                                    toValue:1984.0f
                                 outOfValue:0.0
                   shouldShowDescriptorText:YES
                               withDuration:0.7f
                         andCompletionBlock:^(BOOL completed) {
                             //Do stuff when tally is complete
                         }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
