//
//  SoundCloudSearchViewController.h
//  CelloLingo
//
//  Created by Chelsea Pugh on 3/4/14.
//  Copyright (c) 2014 Chelsea Pugh. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import "ViewController.h"

@interface SoundCloudSearchViewController : ViewController <AVAudioPlayerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *tracks;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
