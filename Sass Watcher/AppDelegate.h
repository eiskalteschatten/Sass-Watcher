//
//  AppDelegate.h
//  Sass Watcher
//
//  Created by Alex Seifert on 6/1/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSMenu *statusMenu;

@property (retain, nonatomic) NSStatusItem *statusItem;
@property (retain, nonatomic) NSImage *statusImage;
@property (retain, nonatomic) NSImage *statusHighlightImage;

- (BOOL)checkCompassInstalled;

@end
