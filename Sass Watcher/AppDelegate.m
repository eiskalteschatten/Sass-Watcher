//
//  AppDelegate.m
//  task Watcher
//
//  Created by Alex Seifert on 6/1/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
    
    _statusImage = [NSImage imageNamed:@"menu-icon"];
    _statusHighlightImage = [NSImage imageNamed:@"menu-icon-alt"];
    
    [_statusItem setImage:_statusImage];
    [_statusItem setAlternateImage:_statusHighlightImage];
    
    [_statusItem setMenu:_statusMenu];
    [_statusItem setToolTip:@"Sass Watcher"];
    [_statusItem setHighlightMode:YES];
    
    BOOL compassInstalled = [self checkCompassInstalled];

    if (!compassInstalled) {
        NSInteger button = NSRunAlertPanel(NSLocalizedStringFromTable(@"Install SASS and Compass", @"Localized", @"Install SASS and Compass"), NSLocalizedStringFromTable(@"The Ruby Gems for SASS and Compass are not installed on your system and are required for SASS Watcher to function properly. Would you like to install them?\n\nClicking \"Install\" will open a Terminal window and require administrative privileges.", @"Localized", @"The Ruby Gems for SASS and Compass are not installed on your system."), NSLocalizedStringFromTable(@"Install", @"Localized", @"Install"), NSLocalizedStringFromTable(@"Cancel", @"Localized", @"Cancel"), nil);
        
        if (button == NSAlertDefaultReturn) {
            [_logView insertIntoLog:@"Installing SASS and Compass..."];
            NSURL *installScript = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"install_compass" ofType:@"scpt"]];
            NSDictionary* errors = [NSDictionary dictionary];
            NSAppleScript *appleScript = [[NSAppleScript alloc] initWithContentsOfURL:installScript error:&errors];
            [appleScript executeAndReturnError:nil];
        }
        else {
            [_logView insertIntoLog:@"Sass Watcher cannot function without Sass and Compass. Please install them by restarting Sass Watcher and clicking the \"Install\" button."];
        }
    }
}

- (BOOL)checkCompassInstalled {
    NSPipe *pipe = [NSPipe pipe];
    
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath:@"/usr/bin/compass"];
    [task setArguments: [NSArray arrayWithObjects:@"-v", nil]];
    [task setStandardOutput: pipe];
    [task setStandardError: pipe];
    
    @try {
        [task launch];
        
        return YES;
    }
    @catch (NSException *exception) {
        [_logView insertIntoLog:@"Compass not installed"];
        return NO;
    }
}


- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender {
    [_folderView stopWatchingAll];
    
    return NSTerminateNow;
}

@end
