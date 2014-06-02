//
//  FolderViewController.h
//  Sass Watcher
//
//  Created by Alex Seifert on 6/1/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LogViewController.h"

@interface FolderViewController : NSViewController

@property (assign) IBOutlet NSArrayController *arrayFolders;
@property (assign) IBOutlet NSTableView *tableView;
@property (assign) IBOutlet LogViewController *logView;
@property (assign) IBOutlet NSMenuItem *compressCss;

@property (assign) NSUserDefaults *standardDefaults;
@property (assign) BOOL cssCompresssed;

@property (retain, nonatomic) NSMutableArray *folders;
@property (retain, nonatomic) NSMutableDictionary *processes;
@property (retain, nonatomic) NSString *plistFilePath;

- (IBAction)addFolder:(id)sender;
- (IBAction)removeFolder:(id)sender;

- (void)startWatchingAll;
- (void)startWatching:(NSString*)folderName;
- (void)stopWatchingAll;
- (void)stopWatching:(NSString*)folder;
- (void)taskDidTerminate:(NSNotification *)notification;

- (IBAction)compressCss:(id)sender;

@end
