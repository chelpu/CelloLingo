//
//  OpeningViewController.m
//  BassRead
//
//  Created by Chelsea Pugh on 1/17/14.
//  Copyright (c) 2014 Chelsea Pugh. All rights reserved.
//

#import "OpeningViewController.h"
#import "StaffViewController.h"
#import "TechniqueQuizViewController.h"
#import "PlayNotesViewController.h"
#import "SoundCloudSearchViewController.h"
@interface OpeningViewController ()

@end

@implementation OpeningViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)proceedToListen:(id)sender {
    SoundCloudSearchViewController *controller = [[SoundCloudSearchViewController alloc] initWithNibName:@"SoundCloudSearchViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)proceedToRead:(id)sender {
    StaffViewController *controller = [[StaffViewController alloc] initWithNibName:@"StaffViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)proceedToTechnique:(id)sender {
    TechniqueQuizViewController *controller = [[TechniqueQuizViewController alloc] initWithNibName:@"TechniqueQuizViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)proceedToPlay:(id)sender {
    PlayNotesViewController *controller = [[PlayNotesViewController alloc] initWithNibName:@"PlayNotesViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}
@end
