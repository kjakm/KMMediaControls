//
//  KMRootViewController.m
//  KMMediaControls
//
//  Created by Kieran McGrady on 27/08/2014.
//  Copyright (c) 2014 Kieran McGrady. All rights reserved.
//

#import "KMRootViewController.h"

@interface KMRootViewController ()

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

@end

@implementation KMRootViewController

- (void)viewDidLoad
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"audio" ofType:@"mp3"];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
    [_audioPlayer prepareToPlay];
}

@end
