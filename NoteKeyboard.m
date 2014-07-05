//
//  NoteKeyboard.m
//  BassRead
//
//  Created by Chelsea Pugh on 1/18/14.
//  Copyright (c) 2014 Chelsea Pugh. All rights reserved.
//
#import "AppDelegate.h"
#import "NoteKeyboard.h"
#import "UIView+FindFirstResponder.h"
@interface NoteKeyboard ()
{
    CGRect originalFrame;
    CGRect offsetFrame;
    
}

@end

@implementation NoteKeyboard

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (void)show
{
}

- (void)hide
{
   
}

+ (instancetype) keyboard {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"NoteKeyboard" owner:self options:nil];
    return views[0];
}

-(IBAction)didPressKey:(id)sender {
    UIButton *button = (UIButton *)sender;
    UIWindow *winner = [[UIApplication sharedApplication] keyWindow];
    UIView *firstResponder = [winner findViewThatIsFirstResponder];
    if([firstResponder isKindOfClass:[UITextField class]]) {
        NSString *text = button.titleLabel.text;
        UITextField *curTF = (UITextField *)firstResponder;
        if([curTF.delegate textField:curTF shouldChangeCharactersInRange:NSMakeRange(0, curTF.text.length) replacementString:text]){
            UITextField *tf = (UITextField *)firstResponder;
            tf.text = text;
 
        }
        
    }
}

@end
