//
//  KMMediaControls.m
//  KMMediaControls
//
//  Created by Kieran McGrady on 27/08/2014.
//  Copyright (c) 2014 Kieran McGrady. All rights reserved.
//

#import "KMMediaControls.h"

@implementation KMMediaControls

- (id)initWithFrame:(CGRect)frame audioFileURL:(NSURL *)fileURL autoplay:(BOOL)autoplay
{
    self = [super initWithFrame:frame];
    self.autoplay = autoplay;
    self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    
    // Setup audioPlayer
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
    [_audioPlayer prepareToPlay];

    // Setup buttons
    _playButon = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width/2-37.5, 0, 75, 75)];
    [_playButon addTarget:self action:@selector(playAudio:) forControlEvents:UIControlEventTouchUpInside];
    [_playButon setImage:[UIImage imageNamed:@"PlayButton"] forState:UIControlStateNormal];
    [self addSubview:_playButon];
    
    _stopButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width/2-37.5, 0, 75, 75)];
    [_stopButton addTarget:self action:@selector(stopAudio:) forControlEvents:UIControlEventTouchUpInside];
    [_stopButton setImage:[UIImage imageNamed:@"StopButton"] forState:UIControlStateNormal];
    [self.stopButton setHidden:YES];
    [self addSubview:_stopButton];

    // Setup seekbar
    _seekBar = [[UISlider alloc] initWithFrame:CGRectMake(45, self.frame.size.height-50, self.frame.size.width-90, 30)];
    [self addSubview:_seekBar];
    
    // Setup labels
    _currentTime = [[UILabel alloc] initWithFrame:CGRectMake(5, self.frame.size.height-45, 50, 20)];
    _currentTime.text = @"00.00";
    _currentTime.textAlignment = NSTextAlignmentLeft;
    _currentTime.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    [self addSubview:_currentTime];
    
    _endTime = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-55, self.frame.size.height-45, 50, 20)];
    _endTime.text = @"00.00";
    _endTime.textAlignment = NSTextAlignmentRight;
    _endTime.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    [self addSubview:_endTime];

    if (self.autoplay == YES) {
        self.playButon.hidden = YES;
        self.stopButton.hidden = NO;
        [self.audioPlayer play];
    }
    
    return self;
}

- (void)playAudio:(id)sender
{
    if (![self.audioPlayer isPlaying]) {
        self.playButon.hidden = YES;
        self.stopButton.hidden = NO;
        [self.audioPlayer play];
    }
}

- (void)stopAudio:(id)sender
{
    if ([self.audioPlayer isPlaying]) {
        if (self.stopAudio != StopAudioReset && self.stopAudio != StopAudioPause) {
            //If enum hasn't been set default to StopAudioPause
            [self.audioPlayer pause];
        } else if (self.stopAudio == StopAudioReset) {
            [self.audioPlayer setCurrentTime:0.0];
            [self.audioPlayer stop];
        } else if (self.stopAudio == StopAudioPause) {
            [self.audioPlayer pause];
        }
        
        self.stopButton.hidden = YES;
        self.playButon.hidden = NO;
    }
}

@end
