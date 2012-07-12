//
//  Jul11AppDelegate.h
//  Jul11
//
//  Created by Michael Grubb on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>
@class View;

@interface Jul11AppDelegate: UIResponder <UIApplicationDelegate, AVAudioPlayerDelegate> {
	AVAudioPlayer *player;
	View *view;
	UIWindow *_window;
}

- (void) valueChanged: (id) sender;
- (void) volumeChanged;

@property (strong, nonatomic) UIWindow *window;
@end

