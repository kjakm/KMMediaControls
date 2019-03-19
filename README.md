KMMediaControls
===============

KMMediaControls is a simple way to add standard UI controls to an audio player.

To get started simply drag the KMMediaControls.m + .h files into your project and import it into your controller.
You also need to import UIView+Autolayout (included in the Utilities folder in the sample project).

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

![Screenshot](https://github.com/kjakm/KMMediaControls/blob/master/KMMediaControls/Screenshot/screenshot.png)

###License

The MIT License

Copyright 2019 Kieran McGrady

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
