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
    int _numNotes;
    int _numVals;
}

@end

@implementation StaffViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _noteTextFields = [[NSMutableArray alloc] init];
        _numNotes = 8;
        _numVals = 8;
        self.staffYValue = 266;
        self.noteValImageViews = [[NSMutableArray alloc] init];
        self.staffImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bassStaff.gif"]];
        self.notesArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _nk = [NoteKeyboard keyboard];
    for (int i = 0;  i < _numNotes; i++) {
        noteCheck[i] = 0;
    }
    [self setUpTextFields];
    self.notes = @[@"G", @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"A"];
    [self createRandomNotes];
    for(int i = 0; i < self.notesArray.count; i++) {
        Note *cur = [self.notesArray objectAtIndex:i];
        [self.staffNoteImageViews addObject:cur.noteView];
        [self.view addSubview:cur.noteView];
    }
}

- (void) setUpTextFields {
    for (int i = 0; i < _numNotes; i++) {
        UITextField *newField = [[UITextField alloc] initWithFrame:CGRectMake(115.0f + i*80.0, 339.0f, 50.0f, 30.0f)];
        newField.inputView = _nk;
        [newField setFont:[UIFont fontWithName:@"Roboto" size:25.0f]];
        newField.borderStyle = UITextBorderStyleRoundedRect;
        
        newField.delegate = self;
        if(_noteTextFields.count < _numNotes){
            [_noteTextFields addObject:newField];
        } else {
            _noteTextFields[i] = newField;
        }
        [self.view addSubview:newField];
        newField.textAlignment = NSTextAlignmentCenter;
    }
}

- (void)createRandomNotes {
    for (int i = 0; i < _numNotes; i++) {
        NSInteger curNoteVal = arc4random_uniform(_numVals);
        Note *curNote = [[Note alloc] initWithValue:curNoteVal xPosition:i];
        curNote.noteView.frame = CGRectMake(120 + i*80.0, self.staffYValue - curNoteVal*14.0, 27, 27);
        [self.notesArray addObject:curNote];

    }
}

- (IBAction)checkNotes:(id)sender {
    BOOL correct = YES;
    
    // Check if each note is correct
    for (int i = 0; i < _noteTextFields.count; i++){
        Note *cur = self.notesArray[i];
        UITextField *curField = _noteTextFields[i];
        if ([self checkNoteWithValue:cur.value text:curField.text]) {
            noteCheck[i] = true;
        } else {
            noteCheck[i] = false;
            correct = NO;
        }
    }
    
    for (int i = 0; i < self.noteValImageViews.count; i++) {
        UIImageView *iv = self.noteValImageViews[i];
        [iv removeFromSuperview];
    }
    
    for (int n = 0; n < _numNotes; ++n) {
        UIImageView *newImageView = [[UIImageView alloc] initWithFrame:CGRectMake(127.0f + n*80.0, 380.0f, 26.0f, 26.0f)];
        if(correct) {
            newImageView.image = [UIImage new];
            self.noteValImageViews[n] = newImageView;
        } else {
            if(noteCheck[n]){
                newImageView.image = [UIImage imageNamed:@"check.png"];
            } else {
                newImageView.image = [UIImage imageNamed:@"x.png"];
            }
            [self.noteValImageViews addObject:newImageView];
        }
        [self.view addSubview:newImageView];
    }
    
    if (correct){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Great Job!"
                                                        message:@"You got all the notes right."
                                                       delegate:Nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        for (int i = 0; i < self.notesArray.count; i++) {
            Note *cur = self.notesArray[i];
            [cur.noteView removeFromSuperview];
        }
        
        [self.noteValImageViews removeAllObjects];
        [self.notesArray removeAllObjects];
        [self clearTextFields];
        [self viewDidLoad];
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

#pragma mark - TextField Delegate Methods

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    BOOL right = [string isEqualToString:@">"];
    BOOL left = [string isEqualToString:@"<"];
    if(right || left) {
        UIWindow *winner = [[UIApplication sharedApplication] keyWindow];
        UIView *firstResponder = [winner findViewThatIsFirstResponder];
        NSInteger indexOfCur = [_noteTextFields indexOfObject:firstResponder];
        NSInteger newIndex = (indexOfCur + right - left) % _numNotes;
        if(newIndex < 0) {
            newIndex = _numNotes - 1;
        }
        [_noteTextFields[newIndex] becomeFirstResponder];
        return NO;
    }
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
}

@end
