//
//  SoundCloudSearchViewController.m
//  CelloLingo
//
//  Created by Chelsea Pugh on 3/4/14.
//  Copyright (c) 2014 Chelsea Pugh. All rights reserved.
//
#import <libextobjc/EXTScope.h>
#import "Track.h"
#import <FrameAccessor/FrameAccessor.h>
#import "TrackCell.h"
#import "SoundCloudSearchViewController.h"
#import "SCUI.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/UIImageView+AFNetworking.h>
@interface SoundCloudSearchViewController ()
@property (strong, nonatomic) AVAudioPlayer *player;


@end

@implementation SoundCloudSearchViewController {
    BOOL _isPlaying;
    NSMutableArray *_playing;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _isPlaying = NO;
        _playing = [[NSMutableArray alloc] init];
        self.tracks = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.tableView.separatorColor = [UIColor clearColor];
    UINib *nib = [UINib nibWithNibName:@"TrackCellView" bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"TrackCellView"];
    self.player = [[AVAudioPlayer alloc] init];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.color = [UIColor colorWithRed:1.0 green:102.0/255.0 blue:0.0 alpha:0.5];
    NSDictionary *parameters = @{@"client_id": @"c76d3fe9bb6cfee88bb0d1598219eee4", @"q" : @"cello", @"order" : @"created_at"};
    [manager GET:@"https://api.soundcloud.com/tracks.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [hud hide:YES];
        for(NSDictionary *dict in responseObject) {
            if([dict objectForKey:@"stream_url"]) {
                [self.tracks addObject:dict];
                [_playing addObject:[NSNumber numberWithBool:NO]];

            }
        }
        self.tableView.separatorColor = [UIColor grayColor];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tracks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictionary = [self.tracks objectAtIndex:indexPath.row];
    __block TrackCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"TrackCellView"];

    
    NSString *title = [dictionary objectForKey:@"title"];
    cell.songTitleLabel.text = title;
    NSDictionary *user = [dictionary objectForKey:@"user"];
    cell.artistLabel.text = [user objectForKey:@"username"];
    NSString *imagePath = [dictionary objectForKey:@"artwork_url"];
    if([imagePath isKindOfClass:[NSString class]]) {
        NSURL *imageURL = [NSURL URLWithString:imagePath];
        NSURLRequest *request = [NSURLRequest requestWithURL:imageURL];
        @weakify(cell);
        [cell.albumArtworkImage setImageWithURLRequest:request
                                      placeholderImage:[UIImage imageNamed:@"cloud.png"]
                                               success:nil
                                               failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                          NSString *newPath = [dictionary objectForKey:@"avatar_url"];
                                          if([newPath isKindOfClass:[NSString class]]) {
                                              @strongify(cell);
                                              NSURL *newURL = [NSURL URLWithString:imagePath];
                                              [cell.albumArtworkImage setImageWithURL:newURL
                                                                     placeholderImage:[UIImage imageNamed:@"cloud.png"]];
                                          }
                                      }];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TrackCell *cell = (TrackCell *)[tableView cellForRowAtIndexPath:indexPath];
    NSNumber *p = [_playing objectAtIndex:indexPath.row];
    BOOL isPlaying = [p boolValue];
    NSLog(@"AM I PLAYING: %i", isPlaying);
    if(isPlaying == YES) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [_playing replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:NO]];
        [self.player pause];
        
    } else {
        [_playing replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:YES]];
        NSDictionary *track = [self.tracks objectAtIndex:indexPath.row];
        NSString *streamURL = [track objectForKey:@"stream_url"];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.color = [UIColor colorWithRed:1.0 green:102.0/255.0 blue:0.0 alpha:0.5];

        [SCRequest performMethod:SCRequestMethodGET
                      onResource:[NSURL URLWithString:streamURL]
                 usingParameters:@{@"client_id": @"c76d3fe9bb6cfee88bb0d1598219eee4", @"order": @"created_at"}
                     withAccount:nil
          sendingProgressHandler:nil
                 responseHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                     NSError *playerError;
                     [hud hide:YES];
                     self.player = [[AVAudioPlayer alloc] initWithData:data error:&playerError];
                     self.player.delegate = self;
                     
                     [self.player play];
                 }];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 210.0f;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
