//
//  Jul11AppDelegate.m
//  Jul11
//
//  Created by Michael Grubb on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Jul11AppDelegate.h"
#import "View.h"

@implementation Jul11AppDelegate
@synthesize window = _window;

- (BOOL) application: (UIApplication *) application didFinishLaunchingWithOptions: (NSDictionary *) launchOptions
{
	// Override point for customization after application launch.
	NSBundle *bundle = [NSBundle mainBundle];
	NSLog(@"bundle.bundelPath == \"%@\"", bundle.bundlePath);
    
	NSString *filename = [bundle pathForResource: @"subteranneanhomesickalien" ofType: @"mp3"];
	NSLog(@"filename == \"%@\"", filename);
    
	NSURL *url = [NSURL fileURLWithPath: filename isDirectory: NO];
	NSLog(@"url == \"%@\"", url);
    
	NSError *error = nil;
	player = [[AVAudioPlayer alloc] initWithContentsOfURL: url error: &error];
    
	if (player == nil) {
		NSLog(@"could not initialize player:  %@", error);
		return YES;
	}
	player.volume = .5;		//the default
	player.numberOfLoops = -1;	//negative for infinite loop
	player.delegate = self;
	//mono or stereo
	NSLog(@"player.numberOfChannels == %u", player.numberOfChannels);
    
	if (![player prepareToPlay]) {
		NSLog(@"prepareToPlay failed");
		return YES;
	}
    
	UIScreen *screen = [UIScreen mainScreen];
	view = [[View alloc] initWithFrame: screen.applicationFrame];
	self.window = [[UIWindow alloc] initWithFrame: screen.bounds];
	//self.window.backgroundColor = [UIColor whiteColor];
    
	[self.window addSubview: view];
	[self.window makeKeyAndVisible];
	return YES;
}

//currentTime seems to be correct only while the player is playing.

- (void) valueChanged: (id) sender {
	UISwitch *s = sender;
	if (s.isOn) {
		//The UISwitch has just been turned on.
        extern CGFloat sliderVal;
        player.volume=sliderVal;
		if (![player play]) {
			NSLog(@"[player play] failed.");
		}
		NSLog(@"Playing at %g of %g seconds.", player.currentTime, player.duration);
	} else {
		//The UISwitch has just been turned off.
		NSLog(@"Paused at %g of %g seconds.", player.currentTime, player.duration);
		[player pause];
        
		if (![player prepareToPlay]) {
			NSLog(@"prepareToPlay failed");
		}
        
	}
}

- (void) volumeChanged {
    extern CGFloat sliderVal;
    player.volume=sliderVal;
}

- (void) applicationWillResignActive: (UIApplication *) application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void) applicationDidEnterBackground: (UIApplication *) application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void) applicationWillEnterForeground: (UIApplication *) application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void) applicationDidBecomeActive: (UIApplication *) application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void) applicationWillTerminate: (UIApplication *) application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
