//
//  Popup.h
//  PopupPlayground
//
//  Created by Egor on 4/8/17.
//  Copyright © 2017 egor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <KLCPopup.h>

#import "PopupContentView.h"


@interface Popup : KLCPopup

-(instancetype) init UNAVAILABLE_ATTRIBUTE;
+(instancetype) sharedInstance;

-(void) initializeContentView;

-(void) setTitle:(NSString*) title;
-(void) setMessage:(NSString*) message;
-(void) setMessage:(NSString*) message withIconNamed:(NSString *) iconName;

@end
