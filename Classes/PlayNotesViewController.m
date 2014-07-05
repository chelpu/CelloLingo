//
//  PlayNotesViewController.m
//  BassRead
//
//  Created by Chelsea Pugh on 3/2/14.
//  Copyright (c) 2014 Chelsea Pugh. All rights reserved.
//
#import "Note.h"
#import "PlayNotesViewController.h"

@interface PlayNotesViewController () {
    NSTimer *_timer;
    IBOutlet UIButton *_beginButton;
}

@end

@implementation PlayNotesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.noteCorrect = [[NSMutableArray alloc] init];
        self.staffNoteImageViews = [[NSMutableArray alloc] init];
        self.notesPlayed = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.notePlayedLabel setHidden:YES];
    [_beginButton setTitle:@"BEGIN" forState:UIControlStateNormal];
    self.count = 0;
    for(int i = 0; i < 8; i++) {
        [self.noteCorrect addObject:@"NO"];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    self.count = 0;
    [_timer invalidate];
    [[SCListener sharedListener] stop];
    for(UIImageView *iv in self.staffNoteImageViews) {
        [iv setHidden:YES];
    }
    [self.staffNoteImageViews removeAllObjects];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) setUpTextFields {
    
}

- (void)createRandomNotes {
    for (int i = 0; i < 8; i++) {
        NSInteger curNoteVal = arc4random_uniform(8);
        Note *curNote = [[Note alloc] initWithValue:curNoteVal xPosition:i];
        curNote.noteView.frame = CGRectMake(120 + i*80.0, 366 - curNoteVal*14.0, 27, 27);
        [self.notesArray addObject:curNote];
        
    }
}


- (IBAction)pressedTry:(id)sender {
    
    if([_beginButton.titleLabel.text isEqualToString:@"BEGIN"]) {
        [self.notePlayedLabel setHidden:NO];
        [_beginButton setTitle:@"NEW PATTERN" forState:UIControlStateNormal];
        if(![_timer isValid]) {
            UIImageView *noteImage = self.staffNoteImageViews[self.count];
            noteImage.image = [UIImage imageNamed:@"wholeNoteRed.png"];
            _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(getNote) userInfo:nil repeats:YES];
        }
    } else {
        [self.notePlayedLabel setHidden:YES];
        [_beginButton setTitle:@"BEGIN" forState:UIControlStateNormal];
        [self pressedDone];
    }
}

- (void)getFreq {
    float freq = [[SCListener sharedListener] frequency];
    NSLog(@"freq: %f", freq);
    int hey = [self freqToMIDI:freq];
    NSString *str = [self midiToString:hey];
    self.notePlayedLabel.text = str;
    if(self.count < 8) {
        Note *n = self.notesArray[self.count];
        int value = n.value;
        if([str isEqualToString:self.notes[value]]) {
            self.noteCorrect[self.count ] = @"YES";
            UIImageView *noteImage = self.staffNoteImageViews[self.count ];
            noteImage.image = [UIImage imageNamed:@"wholeNoteGreen.png"];
        }
        [self.notesPlayed addObject:[NSNumber numberWithInt:value]];
        self.count++;
    } else {
        self.count = 0;
        
        // Generate correct note sequence on staff in red
        for(int i = 0; i < self.notesPlayed.count; i++) {
            //NSLog(@"note val played: %@", self.notesPlayed[i]);
        }
        [_timer invalidate];
        [[SCListener sharedListener] pause];
        
    }
}

- (void)getNote {
    if(self.count == 0) {
        [[SCListener sharedListener] listen];
        [self performSelector:@selector(getFreq) withObject:nil afterDelay:1.0];
    }
    else if(self.count < self.staffNoteImageViews.count) {
        UIImageView *noteImage = self.staffNoteImageViews[self.count];
        noteImage.image = [UIImage imageNamed:@"wholeNoteRed.png"];
        [[SCListener sharedListener] listen];
        [self performSelector:@selector(getFreq) withObject:nil afterDelay:1.0];
    }
}

- (void)pressedDone {
    self.count = 0;
    [_timer invalidate];
    [[SCListener sharedListener] stop];
    for(UIImageView *iv in self.staffNoteImageViews) {
        [iv setHidden:YES];
    }
    [self.staffNoteImageViews removeAllObjects];
    [self viewDidLoad];
}

- (int) freqToMIDI: (float) frequency {
    if (frequency > 0) {
        int midiNote = (12*(log10(frequency/220)/log10(2)) + 57) + 0.5;
        return midiNote;
    } else {
        return 0;
    }
    
}

- (NSString*) midiToString: (int) midiNote {
        NSArray *noteStrings = [[NSArray alloc] initWithObjects:@"C", @"C#", @"D", @"D#", @"E", @"F", @"F#", @"G", @"G#", @"A", @"A#", @"B", nil];
        return [noteStrings objectAtIndex:midiNote%12];
}
@end
