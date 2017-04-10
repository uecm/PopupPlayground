//
//  PopupContentView.h
//  PopupPlayground
//
//  Created by Egor on 4/8/17.
//  Copyright © 2017 egor. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopupContentDelegate <NSObject>

@required
-(void) popupButtonPushedWithIdentifier:(NSInteger)identifier;

@end


typedef NS_ENUM(NSInteger, PopupViewStyle){
    PopupViewStyleCongrats = 0,
    PopupViewStyleDailyReward,
    PopupViewStyleSpinLocked,
    PopupViewStyleSpinLockedTimer
};

@interface PopupContentView : UIView

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *message;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@property (strong, nonatomic) id<PopupContentDelegate> delegate;
@property (assign, nonatomic) PopupViewStyle popupStyle;



-(instancetype) init UNAVAILABLE_ATTRIBUTE;
+(instancetype) sharedInstance;
//-(instancetype) initWithXibFileNamed:(NSString*) xibFile;

@end
