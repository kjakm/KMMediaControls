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
    _playButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width/2-37.5, 0, 75, 75)];
    [_playButton addTarget:self action:@selector(playAudio:) forControlEvents:UIControlEventTouchUpInside];
    [_playButton setImage:[UIImage imageNamed:@"PlayButton"] forState:UIControlStateNormal];
    [self addSubview:_playButton];
    
    _stopButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width/2-37.5, 0, 75, 75)];
    [_stopButton addTarget:self action:@selector(stopAudio:) forControlEvents:UIControlEventTouchUpInside];
    [_stopButton setImage:[UIImage imageNamed:@"StopButton"] forState:UIControlStateNormal];
    [self.stopButton setHidden:YES];
    [self addSubview:_stopButton];

    // Setup seekbar
    _seekBar = [[UISlider alloc] initWithFrame:CGRectMake(45, self.frame.size.height-50, self.frame.size.width-90, 30)];
    [_seekBar addTarget:self action:@selector(updateSlider:) forControlEvents:UIControlEventValueChanged];
    _seekBar.minimumValue = 0.0;
    _seekBar.maximumValue = _audioPlayer.duration;
    _seekBar.value = 0.0;
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
        self.playButton.hidden = YES;
        self.stopButton.hidden = NO;
        [self.audioPlayer play];
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
    }
    
    return self;
}

- (void)updateTime:(NSTimer *)timer
{
    NSTimeInterval timePassed = self.audioPlayer.currentTime;
    int min= timePassed/60;
    int sec= lroundf(timePassed) % 60;
    NSTimeInterval totalTime = self.audioPlayer.duration;
    int min1= totalTime/60;
    int sec1= lroundf(totalTime) % 60;
    
    self.currentTime.text = [NSString stringWithFormat:@"%d:%d", min, sec];
    self.endTime.text = [NSString stringWithFormat:@"%d:%d", min1, sec1];
    
    self.seekBar.value = self.audioPlayer.currentTime;
    if (self.audioPlayer.currentTime == self.audioPlayer.duration) {
        self.playButton.hidden = NO;
        self.stopButton.hidden = YES;
        [timer invalidate];
    }
}

- (void)updateSlider:(id)sender
{
    self.audioPlayer.currentTime = self.seekBar.value;
    
    NSTimeInterval timePassed = self.audioPlayer.currentTime;
    int min= timePassed/60;
    int sec= lroundf(timePassed) % 60;
    NSTimeInterval totalTime = self.audioPlayer.duration;
    int min1= totalTime/60;
    int sec1= lroundf(totalTime) % 60;
    
    self.currentTime.text = [NSString stringWithFormat:@"%d:%d", min, sec];
    self.endTime.text = [NSString stringWithFormat:@"%d:%d", min1, sec1];
}

- (void)playAudio:(id)sender
{
    if (![self.audioPlayer isPlaying]) {
        self.playButton.hidden = YES;
        self.stopButton.hidden = NO;
        [self.audioPlayer play];
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
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
        self.playButton.hidden = NO;
    }
}

@end
