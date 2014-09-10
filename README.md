KMMediaControls
===============

KMMediaControls is a simple way to add standard UI controls to an audio player.

To get started simply drag the KMMediaControls.m + .h files into your project and import it into your controller.
You also need to import UIView+Autolayout (included in the Utilities folder in the sampel project).

- In your controller create an instand of KMMediaControls, pass it the URL of the file you want it to play (via AVAudioPlayer)
, and add it to your view.
- You will instantly get a view with play/pause buttons, a seek bar, and two labels showing the current playback time and the total time of the file.
- There are a few options you can set including autoplay and the behaviour when the stop button is pressed (pause or stop and resent audio file to beginning). 

Check out the included sample project to see exactly how it works. 

### Setup Code
```objc
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"audio" ofType:@"mp3"];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    KMMediaControls *mediaControls = [[KMMediaControls alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-120, self.view.frame.size.width, 120)
                                                               audioFileURL:fileURL
                                                                   autoplay:NO];
    mediaControls.stopAudio = StopAudioReset;
    [self.view addSubview:mediaControls];
```
### Screenshot

![Screenshot](https://github.com/KieranMcGrady/KMMediaControls/blob/master/KMMediaControls/Screenshot/screenshot.png)
