//
//  KMMediaControls.m
//  KMMediaControls
//
//  Created by Kieran McGrady on 27/08/2014.
//  Copyright (c) 2014 Kieran McGrady. All rights reserved.
//

#import "KMMediaControls.h"
#import "UIView+AutoLayout.h"

@implementation KMMediaControls

- (id)initWithFrame:(CGRect)frame audioFileURL:(NSURL *)fileURL autoplay:(BOOL)autoplay
{
    self = [super initWithFrame:frame];
    self.autoplay = autoplay;
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.25];
    
    // Setup audioPlayer
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
    [_audioPlayer prepareToPlay];

    // Setup buttons
    _playButton = [UIButton new];
    _playButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_playButton addTarget:self action:@selector(playAudio:) forControlEvents:UIControlEventTouchUpInside];
    [_playButton setImage:[UIImage imageNamed:@"PlayButton"] forState:UIControlStateNormal];
    [self addSubview:_playButton];
    
    _stopButton = [UIButton new];
    _stopButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_stopButton addTarget:self action:@selector(stopAudio:) forControlEvents:UIControlEventTouchUpInside];
    [_stopButton setImage:[UIImage imageNamed:@"StopButton"] forState:UIControlStateNormal];
    [self.stopButton setHidden:YES];
    [self addSubview:_stopButton];

    // Setup seekbar
    _seekBar = [UISlider new];
    _seekBar.translatesAutoresizingMaskIntoConstraints = NO;
    [_seekBar addTarget:self action:@selector(updateSlider:) forControlEvents:UIControlEventValueChanged];
    _seekBar.minimumValue = 0.0;
    _seekBar.maximumValue = _audioPlayer.duration;
    _seekBar.value = 0.0;
    [self addSubview:_seekBar];
    
    // Setup labels
    _currentTime = [UILabel new];
    _currentTime.translatesAutoresizingMaskIntoConstraints = NO;
    _currentTime.text = @"0:00";
    _currentTime.textColor = [UIColor whiteColor];
    _currentTime.textAlignment = NSTextAlignmentLeft;
    _currentTime.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    [self addSubview:_currentTime];
    
    _endTime = [UILabel new];
    _endTime.translatesAutoresizingMaskIntoConstraints = NO;
    _endTime.text = @"0:00";
    _endTime.textColor = [UIColor whiteColor];
    _endTime.textAlignment = NSTextAlignmentRight;
    _endTime.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    [self addSubview:_endTime];

    /*
     *  Setup views using autolayout. Pin labels and status bar to the bottom of the view and
     *  pin the play and stop buttons to the top of the view.
     */
    
    [self.currentTime pinAttribute:NSLayoutAttributeCenterY toAttribute:NSLayoutAttributeCenterY ofItem:self.seekBar];
    [self.currentTime pinToSuperviewEdges:JRTViewPinLeftEdge inset:10];
    [self.currentTime constrainToWidth:40];

    [self.endTime pinAttribute:NSLayoutAttributeCenterY toAttribute:NSLayoutAttributeCenterY ofItem:self.seekBar];
    [self.endTime pinToSuperviewEdges:JRTViewPinRightEdge inset:10];
    [self.endTime constrainToWidth:40];

    [self.seekBar pinToSuperviewEdges:JRTViewPinBottomEdge inset:10];
    [self.seekBar constrainToWidth:self.frame.size.width-100];
    [self.seekBar pinAttribute:NSLayoutAttributeCenterX toAttribute:NSLayoutAttributeCenterX ofItem:self];

    [self.playButton pinAttribute:NSLayoutAttributeCenterX toAttribute:NSLayoutAttributeCenterX ofItem:self];
    [self.playButton pinToSuperviewEdges:JRTViewPinTopEdge inset:5];
    [self.playButton constrainToWidth:75.0];
    [self.playButton constrainToHeight:75.0];
    
    [self.stopButton pinAttribute:NSLayoutAttributeCenterX toAttribute:NSLayoutAttributeCenterX ofItem:self];
    [self.stopButton pinToSuperviewEdges:JRTViewPinTopEdge inset:5];
    [self.stopButton constrainToWidth:75.0];
    [self.stopButton constrainToHeight:75.0];

    //Autoplay
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
    
    // If seconds is under 10 put a zero before the second value
    NSString *secStr = [NSString stringWithFormat:@"%d", sec];
    if (secStr.length == 1) {
        secStr = [NSString stringWithFormat:@"0%d", sec];
    }
    
    NSString *secStr1 = [NSString stringWithFormat:@"%d", sec1];
    if (secStr1.length == 1) {
        secStr1 = [NSString stringWithFormat:@"0%d", sec1];
    }

    self.currentTime.text = [NSString stringWithFormat:@"%d:%@", min, secStr];
    self.endTime.text = [NSString stringWithFormat:@"%d:%@", min1, secStr1];
    
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
    
    // If seconds is under 10 put a zero before the second value
    NSString *secStr = [NSString stringWithFormat:@"%d", sec];
    if (secStr.length == 1) {
        secStr = [NSString stringWithFormat:@"0%d", sec];
    }
    
    NSString *secStr1 = [NSString stringWithFormat:@"%d", sec1];
    if (secStr1.length == 1) {
        secStr1 = [NSString stringWithFormat:@"0%d", sec1];
    }

    self.currentTime.text = [NSString stringWithFormat:@"%d:%@", min, secStr];
    self.endTime.text = [NSString stringWithFormat:@"%d:%@", min1, secStr1];
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
            self.stopAudio = StopAudioPause;
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
