//
//  Document.h
//  Ch32TahDoodle
//
//  Created by Xiao Lu on 4/5/15.
//  Copyright (c) 2015 Xiao Lu. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface BNRDocument : NSDocument

@property (nonatomic) NSMutableArray *tasks;
@property (nonatomic) IBOutlet NSTableView *taskTable;

- (IBAction)addTask:(id)sender;

@end

