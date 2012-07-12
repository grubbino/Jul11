//
//  View.m
//  Jul11
//
//  Created by Michael Grubb on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "View.h"

@implementation View

- (void) valueChanged: (id) sender {
    slider.backgroundColor = [UIColor blackColor];
	label.text = [NSString stringWithFormat: @"Volume"];
    sliderVal=slider.value;
    NSLog(@"%f",sliderVal);
    [[UIApplication sharedApplication].delegate performSelector:@selector(volumeChanged)];
}

- (id) initWithFrame: (CGRect) frame
{
	self = [super initWithFrame: frame];
	if (self) {
		// Initialization code
		self.backgroundColor = [UIColor blackColor];
		//Do not specify a size for the switch.
		//Let the switch assume its own natural size.
		mySwitch = [[UISwitch alloc] initWithFrame: CGRectZero];
		if (mySwitch == nil) {
			return nil;
		}
        
		//Call the valueChanged: method of the application delegate
		//when the value of the switch is changed.
		
		[mySwitch addTarget: [UIApplication sharedApplication].delegate
                     action: @selector(valueChanged:)
           forControlEvents: UIControlEventValueChanged
         ];
		
		//Center the switch in the SwitchView.
		CGRect b = self.bounds;
        
		mySwitch.center = CGPointMake(
                                      b.origin.x + b.size.width / 2,
                                      b.origin.y + b.size.height / 4
                                      );
        
		mySwitch.on = NO;	//the default
		[self addSubview: mySwitch];
        float minimumValue = 0;	//freezing point of water in Fahrenheit
		float maximumValue = 1;
        
		CGSize s = CGSizeMake(200, 16);
		CGRect f = CGRectMake(
                              b.origin.x + (b.size.width - s.width) / 2,
                              b.origin.y + (b.size.height - s.height) / 2,
                              s.width,
                              s.height
                              );
        
		slider = [[UISlider alloc] initWithFrame: f];
		slider.minimumValue = minimumValue;
		slider.maximumValue = maximumValue;
		slider.value = (minimumValue + maximumValue) / 2;
		slider.continuous = YES;	//default is YES
		slider.backgroundColor = [UIColor blackColor];
		[slider addTarget:self
                   action: @selector(valueChanged:)
         forControlEvents: UIControlEventValueChanged
         ];
		[self addSubview: slider];
        
		//Put the label above the slider
		//with a 10-pixel margin between them.
		UIFont *font = [UIFont fontWithName: @"Courier" size: 26];
		s = [@"Volume" sizeWithFont: font];
		f = CGRectMake(
                       b.origin.x + (b.size.width - s.width) / 2,
                       b.origin.y + (b.size.height - slider.frame.size.height) / 2 - s.height - 10,
                       s.width,
                       s.height
                       );
        
		label = [[UILabel alloc] initWithFrame: f];
		label.textAlignment = UITextAlignmentCenter;
		label.font = font;
        label.textColor=[UIColor whiteColor];
        label.backgroundColor=[UIColor blackColor];
		[self valueChanged: slider];
		[self addSubview: label];
	}
	return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void) drawRect: (CGRect) rect
 {
 // Drawing code
 }
 */

@end
