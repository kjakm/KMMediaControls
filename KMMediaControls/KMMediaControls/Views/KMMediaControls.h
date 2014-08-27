//
//  KMMediaControls.h
//  KMMediaControls
//
//  Created by Kieran McGrady on 27/08/2014.
//  Copyright (c) 2014 Kieran McGrady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

typedef enum : NSUInteger {
    StopAudioReset,
    StopAudioPause,
} StopAudio;

@interface KMMediaControls : UIView <AVAudioPlayerDelegate>

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (strong, nonatomic) UILabel *currentTime;
@property (strong, nonatomic) UILabel *endTime;
@property (strong, nonatomic) UISlider *seekBar;
@property (strong, nonatomic) UIButton *playButon;
@property (strong, nonatomic) UIButton *stopButton;
@property (assign, nonatomic) StopAudio stopAudio;

- (id)initWithFrame:(CGRect)frame audioFileURL:(NSURL *)fileURL;

@end
