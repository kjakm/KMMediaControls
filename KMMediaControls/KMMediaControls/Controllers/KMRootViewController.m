//
//  KMRootViewController.m
//  KMMediaControls
//
//  Created by Kieran McGrady on 27/08/2014.
//  Copyright (c) 2014 Kieran McGrady. All rights reserved.
//

#import "KMRootViewController.h"
#import "KMMediaControls.h"

@interface KMRootViewController ()

@end

@implementation KMRootViewController

- (void)viewDidLoad
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"audio" ofType:@"mp3"];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    KMMediaControls *mediaControls = [[KMMediaControls alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-120, self.view.frame.size.width, 120)
                                                               audioFileURL:fileURL
                                                                   autoplay:NO];
    mediaControls.stopAudio = StopAudioReset;
    [self.view addSubview:mediaControls];
}

@end
