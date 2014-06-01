//
//  FolderViewController.h
//  Sass Watcher
//
//  Created by Alex Seifert on 6/1/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface FolderViewController : NSViewController

@property (assign) IBOutlet NSArrayController *arrayFolders;
@property (assign) IBOutlet NSTableView *tableView;
@property (retain, nonatomic) NSMutableArray* folders;
@property (retain, nonatomic) NSString *plistFilePath;

- (IBAction)addFolder:(id)sender;
- (IBAction)removeFolder:(id)sender;

@end