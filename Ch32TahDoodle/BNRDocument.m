//
//  Document.m
//  Ch32TahDoodle
//
//  Created by Xiao Lu on 4/5/15.
//  Copyright (c) 2015 Xiao Lu. All rights reserved.
//

#import "BNRDocument.h"

@interface BNRDocument ()

@end

@implementation BNRDocument

#pragma mark - NSDocument Overrides

- (instancetype)init {
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
        // Test comment 3
    }
    return self;
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController {
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

+ (BOOL)autosavesInPlace {
    return YES;
}

- (NSString *)windowNibName {
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"BNRDocument";
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError {
    // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
    if (!self.tasks) {
        self.tasks = [NSMutableArray array];
    }
    
    NSData *data = [NSPropertyListSerialization
                    dataWithPropertyList:self.tasks
                    format:NSPropertyListXMLFormat_v1_0
                    options:0
                    error:outError];
    return data;

}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
    // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
    self.tasks = [NSPropertyListSerialization
                  propertyListWithData:data
                  options:NSPropertyListMutableContainers
                  format:NULL
                  error:outError];
    
    return (self.tasks != nil);
}


#pragma mark - Actions

- (void)addTask:(id)sender
{
    //    NSLog(@"Add Task button clicked!");
    if (!self.tasks) {
        self.tasks = [NSMutableArray array];
    }
    
    [self.tasks addObject:@"New Item"];
    
    [self.taskTable reloadData];
    
    [self updateChangeCount:NSChangeDone];
}

- (void)deleteTask:(id)sender
{
    if (!self.tasks
        || [self.tasks count] == 0) {
        return;
    }
    
    NSInteger selectedRow = [self.taskTable selectedRow];
    
    [self.tasks removeObjectAtIndex:selectedRow];
    
    [self.taskTable reloadData];
    
    [self updateChangeCount:NSChangeDone];
}


#pragma mark - Data Source Methods

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tv
{
    return [self.tasks count];
}


- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    return [self.tasks objectAtIndex:row];
}


- (void)tableView:(NSTableView *)tableView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    [self.tasks replaceObjectAtIndex:row withObject:object];
    [self updateChangeCount:NSChangeDone];
}




@end
