//
//  PlayNotesViewController.h
//  BassRead
//
//  Created by Chelsea Pugh on 3/2/14.
//  Copyright (c) 2014 Chelsea Pugh. All rights reserved.
//
#import "SCListener.h"
#import "ViewController.h"
#include "StaffViewController.h"

@interface PlayNotesViewController : StaffViewController
@property (strong, nonatomic) NSMutableArray *notesArray;
@property (strong, nonatomic) NSArray *notes;
@property (strong, nonatomic) NSMutableArray *staffNoteImageViews;
@property (strong, nonatomic) NSMutableArray *notesPlayed;
@property (strong, nonatomic) NSMutableArray *noteCorrect;

@property NSInteger count;

- (IBAction)pressedTry:(id)sender;
- (int) freqToMIDI: (float) frequency;
- (NSString*) midiToString: (int) midiNote;
- (void)getNote;
@property (strong, nonatomic) IBOutlet UILabel *notePlayedLabel;
@end
