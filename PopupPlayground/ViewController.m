//
//  ViewController.m
//  PopupPlayground
//
//  Created by Egor on 4/8/17.
//  Copyright © 2017 egor. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    Popup *popup;
    __weak IBOutlet UIButton *showPopupButton;
    __weak IBOutlet UISegmentedControl *styleControl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [showPopupButton.layer setBorderWidth:1.0f];
    [showPopupButton.layer setCornerRadius:15.0f];
    [showPopupButton.layer setBorderColor:[showPopupButton.titleLabel.textColor CGColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showPopupPressed:(id)sender {
    popup = [Popup sharedInstance];
    if (popup.contentView == nil) {
        [popup initializeContentView];
    }
    PopupContentView *contentView = (PopupContentView*)popup.contentView;
    [contentView setDelegate:self];
    [contentView setPopupStyle:styleControl.selectedSegmentIndex];
    
    if (styleControl.selectedSegmentIndex == 0 || styleControl.selectedSegmentIndex == 1) {
        [popup setTitle:@"Congratulations"];
        [popup setMessage:@"789" withIconNamed:@"coins_2"];
    }
    [popup show];
}

-(void)popupButtonPushedWithIdentifier:(NSInteger)identifier{
    [popup dismiss:true];

    switch (identifier) {
        case 101:
            NSLog(@"Left button pressed");
            break;
        case 102:
            NSLog(@"Right button pressed");
            break;
        default:
            NSLog(@"Unknown button pressed");
            break;
    }
}

@end
