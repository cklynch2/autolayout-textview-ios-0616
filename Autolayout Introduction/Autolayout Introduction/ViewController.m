//
//  ViewController.m
//  Autolayout Introduction
//
//  Created by Flatiron School on 6/27/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) NSLayoutConstraint *bottomTextViewConstraint;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view removeConstraints:self.view.constraints];
    self.myTextView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.myTextView removeConstraints:self.myTextView.constraints];
    self.rightButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.rightButton removeConstraints:self.rightButton.constraints];
    self.leftButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.leftButton removeConstraints:self.leftButton.constraints];
    
    self.myTextView.backgroundColor = [UIColor redColor];
    [self.myTextView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:20.0].active = YES;
    [self.myTextView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:10.0].active = YES;
    [self.myTextView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor constant:-20.0].active = YES;
    self.bottomTextViewConstraint = [self.myTextView.bottomAnchor constraintEqualToAnchor:self.rightButton.topAnchor constant:-20.0];
    self.bottomTextViewConstraint.active = YES;
    
    [self.rightButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-10.0].active = YES;
    [self.rightButton.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-10.0].active = YES;
    
    [self.leftButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-10.0].active = YES;
    [self.leftButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:10.0].active = YES;
}

// NOTE: For all iPhones, the vertical size class is 1 in landscape orientation and 2 in portrait orientation. For all iPhones other than 6 Plus and 6s Plus, the horizontal size class is 1 in both landscape and portrait orientation. Whereas, for the 6 Plus and 6s Plus, horizontal size class is 2 in landscape and 1 in portrait orientation. (This means that you can't differentiate between Plus phones and others in portrait, only in landscape.) When the app loads, the horizontal size class is unspecified and associated with enum 0. This means that, in order to determine the orientation, you cannot compare previousTraitCollection to current with < >, because when the app loads previousTraitCollection will always be less than current.
-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    NSLog(@"Previous horizontal size class: %ld", (long)previousTraitCollection.horizontalSizeClass);
    NSLog(@"Previous vertical size class: %ld", (long)previousTraitCollection.verticalSizeClass);
    NSLog(@"Current horizontal size class: %ld", (long)self.traitCollection.horizontalSizeClass);
    NSLog(@"Current vertical size class %ld", (long)self.traitCollection.verticalSizeClass);
    
    // Set constraint with 30 points padding for 6 Plus and 6s Plus in landscape:
    if (self.traitCollection.horizontalSizeClass == 2) {
        self.bottomTextViewConstraint.constant = -30.0;
    }
    // Set constraint with 10 points padding for other phones in landscape:
    else if (self.traitCollection.verticalSizeClass == 1) {
        self.bottomTextViewConstraint.constant = -10.0;
    }
    // Set constraint with 20 points padding for other phones in portrait:
    else if (self.traitCollection.verticalSizeClass == 2) {
        self.bottomTextViewConstraint.constant = -20.0;
    }
}



/* Another approach from Haaris's lab review. The problem with this approach is that it will set the constraint constant as -20.0 in viewDidLoad above, regardless of whether the app is loaded in portrait or landscape orientation.
 -(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    // You are in portrait mode if the height is greater than the width.
    if (size.height > size.width) {
        self.bottomTextViewConstraint.constant = -20;
    // You are in landscape mode if the width is greather than the height.
    } else if (size.width > size.height) {
        self.bottomTextViewConstraint.constant = -10;
    }
 }
*/

@end
