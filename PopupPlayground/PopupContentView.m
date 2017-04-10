//
//  PopupContentView.m
//  PopupPlayground
//
//  Created by Egor on 4/8/17.
//  Copyright © 2017 egor. All rights reserved.
//

#import "PopupContentView.h"

static CGPoint initialLeftButtonCenter;
static CGPoint initialRightButtonCenter;

@implementation PopupContentView{
}

+(instancetype)sharedInstance{
    static PopupContentView *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[PopupContentView alloc] initWithXibFileNamed:@"PopupView"];
        
        initialLeftButtonCenter = CGPointMake(instance.leftButton.center.x,instance.leftButton.center.y - 30);
        initialRightButtonCenter = CGPointMake(instance.rightButton.center.x,instance.leftButton.center.y - 30);
    });
    
    return instance;
}

-(instancetype) initWithXibFileNamed:(NSString*) xibFile{
    if (!(self = [super initWithFrame:CGRectZero])) {
        return nil;
    }
    
    self = [[[NSBundle mainBundle] loadNibNamed:xibFile owner:self options:nil] firstObject];
    
    if (!self) {
        NSLog(@"An error occured while loading xib file. Please check if xib file is correct.");
        return nil;
    }
    
    [self.message setAdjustsFontSizeToFitWidth:true];
    
    return self;
}

-(void) setupButtons{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass: UIButton.class]) {
            UIButton *button = (UIButton*)view;
            [button.layer setCornerRadius:15.0f];
            // Left button
            if (button.restorationIdentifier.integerValue == 101) {
                [button setBackgroundColor:[UIColor colorWithRed:0.00 green:0.18 blue:0.42 alpha:1.0]];
            }
            //Right button
            else if (button.restorationIdentifier.integerValue == 102) {
                [button setBackgroundColor:[UIColor colorWithRed:0.25 green:0.82 blue:0.37 alpha:1.0]];
                [button setAttributedTitle:nil forState:UIControlStateNormal];
            }
        }
    }
}

-(void)setPopupStyle:(PopupViewStyle) popupStyle{
    
    //Default size of the view, although it's different for SpinLocked style
    CGRect frame = CGRectMake(0, 0, 300, 200);
    [self setFrame:frame];
    [self layoutIfNeeded];
    
    [self.leftButton setHidden:false];
    [self.rightButton setHidden:false];
    
    [self.leftButton setCenter:initialLeftButtonCenter];
    [self.rightButton setCenter:initialRightButtonCenter];
    
    [self setupButtons];
    
    // A tiny cleanup
    for (UIView *subview in self.subviews) {
        if ([subview.restorationIdentifier isEqualToString:@"timerLabel"]) {
            [subview removeFromSuperview];
        }
    }
    
    // Update view to match style
    if (popupStyle == PopupViewStyleDailyReward) {
        // One button
        [self.rightButton setHidden:true];
        [self.leftButton setCenter:CGPointMake(self.center.x, initialRightButtonCenter.y)];
        [UIView performWithoutAnimation:^{
            [self.leftButton setTitle:@"CLAIM" forState:UIControlStateNormal];
            [self.leftButton layoutIfNeeded];
        }];
        
        [self.title setText:@"Congratulations!"];
    }
    
    else if (popupStyle == PopupViewStyleCongrats) {
        
        [UIView performWithoutAnimation:^{
            [self.leftButton setTitle:@"SPIN AGAIN" forState:UIControlStateNormal];
            [self.rightButton setTitle:@"MORE COINS" forState:UIControlStateNormal];
            [self.leftButton layoutIfNeeded];
            [self.rightButton layoutIfNeeded];
        }];
        
        [self.title setText:@"Congratulations!"];
    }
    
    else if (popupStyle == PopupViewStyleSpinLocked) {
        
        CGRect frame = CGRectMake(0, 0, 300, 230);
        [self setFrame:frame];
        [self layoutIfNeeded];
        
        [self.leftButton setCenter:CGPointMake(self.center.x, initialRightButtonCenter.y - 5)];
        [UIView performWithoutAnimation:^{
            [self.leftButton setTitle:@"MORE COINS" forState:UIControlStateNormal];
            [self.leftButton layoutIfNeeded];
        }];
        
        [self.rightButton setCenter:CGPointMake(self.center.x, initialRightButtonCenter.y + 40)];
        [self.rightButton setBackgroundColor:[UIColor clearColor]];

        NSMutableAttributedString *rightButtonTitle = [[NSMutableAttributedString alloc] initWithString:@"Wait 30 Minutes"];
        [rightButtonTitle addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, rightButtonTitle.length)];
        [rightButtonTitle addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.67 green:0.67 blue:0.67 alpha:1.0] range:NSMakeRange(0, rightButtonTitle.length)];
        
        [UIView performWithoutAnimation:^{
            [self.rightButton setAttributedTitle:rightButtonTitle forState:UIControlStateNormal];
            [self.rightButton.titleLabel setAdjustsFontSizeToFitWidth:true];
            [self.rightButton layoutIfNeeded];
        }];
        
        [self.message setText:@"You can earn More Coins while Spin is Locked"];
        [self.title setText:@"Spin Locked"];
    }
    
    else if (popupStyle == PopupViewStyleSpinLockedTimer) {
        
        [self.rightButton setHidden:true];
        
        [self.leftButton setCenter:CGPointMake(self.center.x, initialLeftButtonCenter.y - 15)];
        UILabel *timerLabel = [[UILabel alloc] initWithFrame:self.leftButton.frame];
        
        [self.leftButton setHidden:true];
        [self addSubview:timerLabel];
        
        [timerLabel setText:@"--:--"];
        [timerLabel setRestorationIdentifier:@"timerLabel"];
        [timerLabel setTextAlignment:NSTextAlignmentCenter];
        [timerLabel setFont:[UIFont systemFontOfSize:30.0f]];
        [timerLabel setTextColor:[UIColor colorWithRed:0.00 green:0.80 blue:0.20 alpha:1.0]];
        
        [self.message setText:@"Your next tickets will be after"];
        [self.title setText:@"Spin Locked"];
    }
}

- (IBAction)buttonPushed:(id)sender {
    
    UIButton *button = sender;
    // Restoration ID's :
    // 101 - left button
    // 102 - right button
    
    NSInteger identifier = button.restorationIdentifier.integerValue;
    
    if ([self.delegate respondsToSelector:@selector(popupButtonPushedWithIdentifier:)]) {
        [self.delegate popupButtonPushedWithIdentifier:identifier];
    }
}

@end
