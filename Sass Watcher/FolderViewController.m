//
//  FolderViewController.m
//  Sass Watcher
//
//  Created by Alex Seifert on 6/1/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import "FolderViewController.h"

@interface FolderViewController ()

@end

@implementation FolderViewController

- (void)awakeFromNib {
    _folders = [[NSMutableArray alloc] init];
    
    NSString* bundleID = [[NSBundle mainBundle] bundleIdentifier];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray* appSupportDir = [fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask];
    NSURL *dirPath = nil;
    
    if ([appSupportDir count] > 0) {
        dirPath = [[appSupportDir objectAtIndex:0] URLByAppendingPathComponent:bundleID];
        
        NSError* theError = nil;
        if (![fileManager createDirectoryAtURL:dirPath withIntermediateDirectories:YES attributes:nil error:&theError]) {
            NSLog(@"Could not create Application Support directory!");
        }
        
        NSString *plistName = @"Sass-Folders.plist";
        _plistFilePath = [dirPath path];
        _plistFilePath = [_plistFilePath stringByAppendingString:@"/"];
        _plistFilePath = [_plistFilePath stringByAppendingString:plistName];
        
        if ([fileManager fileExistsAtPath:_plistFilePath]) {
            NSMutableArray *foldersFile = [[NSMutableArray alloc] initWithContentsOfFile:_plistFilePath];
            for (id folder in foldersFile) {
                [_arrayFolders addObject:folder];
            }
        }
        
        [self startWatching];
    }
    else {
        NSLog(@"Could not get Application Support directory!");
    }
}

- (IBAction)addFolder:(id)sender {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
	
	[panel setCanChooseDirectories: YES];
	[panel setCanChooseFiles: NO];
	[panel setAllowsMultipleSelection: NO];
	
	if ([panel runModal] == NSOKButton) {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[[panel URL] path], @"folder", nil];
        [_arrayFolders addObject:dict];
        
        if ( ![[NSFileManager defaultManager] fileExistsAtPath:_plistFilePath] || [[NSFileManager defaultManager] isWritableFileAtPath:_plistFilePath]) {
            [[_arrayFolders arrangedObjects] writeToFile:_plistFilePath atomically:YES];
        }
        
        
        NSString *pathToScript = [[NSBundle mainBundle] pathForResource:@"CompassCreate" ofType:@"sh"];
        NSPipe *pipe = [NSPipe pipe];
        NSTask *script = [[NSTask alloc] init];
        
        [script setLaunchPath:@"/bin/sh"];
        [script setArguments: [NSArray arrayWithObjects: pathToScript, [[panel URL] path], nil]];
        [script setStandardOutput: pipe];
        [script setStandardError: pipe];
        [script launch];
        
        NSData *data = [[pipe fileHandleForReading] readDataToEndOfFile];
        NSString *output = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        NSLog(output);
        
        [self startWatching];
	}
}

- (IBAction)removeFolder:(id)sender {
    NSInteger selectedRow = [_tableView selectedRow];
    [_arrayFolders removeObjectAtArrangedObjectIndex:selectedRow];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:_plistFilePath] || [[NSFileManager defaultManager] isWritableFileAtPath:_plistFilePath]) {
        [[_arrayFolders arrangedObjects] writeToFile:_plistFilePath atomically:YES];
    }
}

- (void)startWatching {
    NSArray *folders = _arrayFolders.arrangedObjects;
    NSPipe *pipe = [NSPipe pipe];
    NSString *pathToScript = [[NSBundle mainBundle] pathForResource:@"CompassWatch" ofType:@"sh"];
    
    for (id folder in folders) {
        NSString *folderName = [folder objectForKey:@"folder"];
        
        NSTask *script = [[NSTask alloc] init];
        [script setLaunchPath:@"/bin/sh"];
        [script setArguments: [NSArray arrayWithObjects: pathToScript, folderName, nil]];
        [script setStandardOutput: pipe];
        [script setStandardError: pipe];
        [script launch];
    
        NSData *data = [[pipe fileHandleForReading] readDataToEndOfFile];
        NSString *output = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        NSLog(output);
    }
}

@end
