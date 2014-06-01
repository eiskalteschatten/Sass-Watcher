//
//  AppDelegate.m
//  Sass Watcher
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
}

- (IBAction)openFolders:(id)sender {
    NSBundle *bundle = [NSBundle mainBundle];
    
    NSString *helperAppPath = [[bundle bundlePath] stringByAppendingString:@"/Contents/Resources/Sass Folders.app"];
    
    [[NSWorkspace sharedWorkspace] launchApplication:helperAppPath];
}

@end
