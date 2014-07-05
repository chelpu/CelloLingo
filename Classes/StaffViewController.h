//
//  StaffViewController.h
//  BassRead
//
//  Created by Chelsea Pugh on 12/19/13.
//  Copyright (c) 2013 Chelsea Pugh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StaffViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) NSMutableArray *notesArray;
@property (strong, nonatomic) NSArray *notes;
@property (strong, nonatomic) NSMutableArray *noteValImageViews;
@property (strong, nonatomic) NSMutableArray *staffNoteImageViews;

@property (strong, nonatomic) IBOutlet UIImageView *staffImageView;
- (IBAction)checkNotes:(id)sender;

@end
