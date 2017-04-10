//
//  Popup.m
//  PopupPlayground
//
//  Created by Egor on 4/8/17.
//  Copyright © 2017 egor. All rights reserved.
//

#import "Popup.h"

@implementation Popup


-(instancetype) initPrivate{
       if (!(self = [super init])) {
        return nil;
    }
    self.backgroundView.backgroundColor = [UIColor colorWithRed:0.00f green:0.18f blue:0.48f alpha:.4f];
//    self.shouldDismissOnBackgroundTouch = false;
    
    [self initializeContentView];
    
    return self;
}

+(instancetype)sharedInstance{
    static Popup *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[Popup alloc] initPrivate];
    });
    return instance;
}

-(void)initializeContentView{
    PopupContentView *contentView = [PopupContentView sharedInstance];
    [self setupContentView:contentView];
    [self setContentView:contentView];
}

-(void) setupContentView:(UIView*) contentView{
    [contentView.layer setCornerRadius:15.0f];
    
}

-(void)setTitle:(NSString*) title{
    PopupContentView *contentView = (PopupContentView*)self.contentView;
    contentView.title.text = title;
}

-(void)setMessage:(NSString *)message{
    PopupContentView *contentView = (PopupContentView*)self.contentView;
    contentView.message.text = message;
}

-(void) setMessage:(NSString *)message withIconNamed:(NSString*) iconName{
    PopupContentView *contentView = (PopupContentView*)self.contentView;

    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    
    attachment.image = [UIImage imageNamed:iconName];
    attachment.bounds = CGRectMake(10, -7, 30, 30);
    NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
    
    NSMutableAttributedString *myString= [[NSMutableAttributedString alloc] initWithString:message];
    // Just add some space betweet text and icon
    [myString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" "]];
    [myString appendAttributedString:attachmentString];
    
    contentView.message.attributedText = myString;
}

-(void)didFinishDismissing{
    // Cleanup
    [self.contentView removeFromSuperview];
    self.contentView = nil;
}
@end
