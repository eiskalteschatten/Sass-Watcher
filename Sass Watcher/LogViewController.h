//
//  LogViewController.h
//  Sass Watcher
//
//  Created by Alex Seifert on 6/2/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface LogViewController : NSViewController

@property (assign) IBOutlet NSTextView *logView;
@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSButton *floatAboveWindows;

@property (assign) NSUserDefaults *standardDefaults;

- (void)insertIntoLog:(NSString*)string;
- (IBAction)setFloatOption:(id)sender;

@end
