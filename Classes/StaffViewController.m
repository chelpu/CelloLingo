//
//  StaffViewController.m
//  BassRead
//
//  Created by Chelsea Pugh on 12/19/13.
//  Copyright (c) 2013 Chelsea Pugh. All rights reserved.
//



#import "StaffViewController.h"
#import "Note.h"
#import "NoteKeyboard.h"
#import "FrameAccessor.h"
#import "AppDelegate.h"
#import "UIView+FindFirstResponder.h"
@interface StaffViewController(){

    NSMutableArray *_noteTextFields;
    bool noteCheck[8];
    NoteKeyboard *_nk;
}

@end

@implementation StaffViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _noteTextFields = [[NSMutableArray alloc] init];
        self.noteValImageViews = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _nk = [NoteKeyboard keyboard];
    for (int i = 0;  i < 8; i++) {
        noteCheck[i] = 0;
    }
    [self setUpTextFields];
    self.notes = @[@"G", @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"A"];
    self.staffImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bassStaff.gif"]];
    self.notesArray = [[NSMutableArray alloc] init];
    [self createRandomNotes];
    for(int i = 0; i < self.notesArray.count; i++){
        Note *cur = [self.notesArray objectAtIndex:i];
        [self.staffNoteImageViews addObject:cur.noteView];
        [self.view addSubview:cur.noteView];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    BOOL right = [string isEqualToString:@">"];
    BOOL left = [string isEqualToString:@"<"];
    if(right || left) {
        UIWindow *winner = [[UIApplication sharedApplication] keyWindow];
        UIView *firstResponder = [winner findViewThatIsFirstResponder];
        NSInteger indexOfCur = [_noteTextFields indexOfObject:firstResponder];
        NSInteger newIndex = (indexOfCur + right - left) % 8;
        if(newIndex < 0) {
            newIndex = 7;
        }
        NSLog(@"INDEX: %i, ", newIndex);
        [_noteTextFields[newIndex] becomeFirstResponder];
//        if(newIndex >= 0 && newIndex < _noteTextFields.count) {
//            [_noteTextFields[indexOfCur + right - left] becomeFirstResponder];
//        }
        return NO;
    }
    return YES;
}

- (void) setUpTextFields {
    for (int i = 0; i < 8; i++) {
        UITextField *newField = [[UITextField alloc] initWithFrame:CGRectMake(115.0f + i*80.0, 339.0f, 50.0f, 30.0f)];
        newField.inputView = _nk;
        [newField setFont:[UIFont fontWithName:@"Roboto" size:25.0f]];
        newField.borderStyle = UITextBorderStyleRoundedRect;
        
        newField.delegate = self;
        if(_noteTextFields.count < 8){
            [_noteTextFields addObject:newField];
        } else {
            _noteTextFields[i] = newField;
        }
        [self.view addSubview:newField];
        newField.textAlignment = NSTextAlignmentCenter;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)createRandomNotes {
    for (int i = 0; i < 8; i++) {
        NSInteger curNoteVal = arc4random_uniform(8);
        Note *curNote = [[Note alloc] initWithValue:curNoteVal xPosition:i];
        curNote.noteView.frame = CGRectMake(120 + i*80.0, 266 - curNoteVal*14.0, 27, 27);
        [self.notesArray addObject:curNote];

    }
}

- (IBAction)checkNotes:(id)sender {
    BOOL correct = YES;
    
    // check if each note is correct
    for (int i = 0; i < _noteTextFields.count; i++){
        Note *cur = self.notesArray[i];
        UITextField *curField = _noteTextFields[i];
        if ([self checkNoteWithValue:cur.value text:curField.text]) {
            noteCheck[i] = 1;
        } else {
            noteCheck[i] = 0;
            correct = NO;
        }
    }
    
    if (correct){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Great Job!"
                                                        message:@"You got all the notes right."
                                                       delegate:Nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
        for (int i = 0; i < self.notesArray.count; i++) {
            Note *cur = self.notesArray[i];
            [cur.noteView removeFromSuperview];
        }
        for (int i = 0; i < self.noteValImageViews.count; i++) {
            UIImageView *iv = self.noteValImageViews[i];
            [iv removeFromSuperview];
        }
        for (int i = 0; i < 8; i++) {
            UIImageView *newImageView = [[UIImageView alloc] initWithFrame:CGRectMake(127.0f + i*80.0, 380.0f, 26.0f, 26.0f)];
            newImageView.image = [UIImage new];
            self.noteValImageViews[i] = newImageView;
            [self.view addSubview:newImageView];
        }
        
        [self.noteValImageViews removeAllObjects];
        [self.notesArray removeAllObjects];
        [self clearTextFields];
        [self viewDidLoad];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Try Again"
                                                        message:@"Some of the notes were guessed incorrectly."
                                                       delegate:Nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        //[alert show];
        for (int i = 0; i < self.noteValImageViews.count; i++) {
            UIImageView *iv = self.noteValImageViews[i];
            [iv removeFromSuperview];
        }
        for (int i = 0; i < 8; i++) {
            UIImageView *newImageView = [[UIImageView alloc] initWithFrame:CGRectMake(127.0f + i*80.0, 380.0f, 26.0f, 26.0f)];
            if (self.noteValImageViews.count > i) {
                UIImageView *iv = self.noteValImageViews[i];
                [iv removeFromSuperview];
            }
            if(noteCheck[i]){
                newImageView.image = [UIImage imageNamed:@"check.png"];
            } else {
                newImageView.image = [UIImage imageNamed:@"x.png"];
            }
            [self.noteValImageViews addObject:newImageView];
            [self.view addSubview:newImageView];
        }
    }
    
}

- (BOOL)checkNoteWithValue:(NSInteger)value text:(NSString *)text{
    if ([text isEqualToString:self.notes[value]]) {
        return YES;
    }
    return NO;
}

- (void)clearTextFields
{
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField *)view;
            textField.text = nil;
        }
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
}

@end
