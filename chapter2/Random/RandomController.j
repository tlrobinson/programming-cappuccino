/*
 * RandomController.j
 * Random
 *
 * Created by You on July 16, 2012.
 * Copyright 2012, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>
@import <Foundation/CPDate.j>

@implementation RandomController : CPObject
{
    IBOutlet CPTextField textField;
}

- (IBAction)generate:(id)sender
{
    // Generate a number between 1 and 100 inclusive
    var generated = ((Math.random() * Number.MAX_VALUE) % 100) + 1;

    console.log("generated = %d", generated);

    // Ask the text field to change what it is displaying
    [textField setIntValue:generated];
}

- (IBAction)seed:(id)sender
{
    // Seed the random number generator with the time
    console.log("Would have seeded with time " + new Date().getTime());
}

- (void)awakeFromCib
{
    var now = [CPDate date];
    [textField setObjectValue:now];
}

@end
