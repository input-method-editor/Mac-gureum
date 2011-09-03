//
//  CIMInputHandler.m
//  CharmIM
//
//  Created by youknowone on 11. 9. 1..
//  Copyright 2011 youknowone.org. All rights reserved.
//

#import "CIMInputManager.h"
#import "CIMInputHandler.h"
#import "CIMHangulComposer.h"

#define DEBUG_INPUTHANDLER TRUE

@implementation CIMInputHandler
@synthesize manager;

- (id)initWithManager:(CIMInputManager *)aManager {
    self = [super init];
    ICLog(DEBUG_INPUTHANDLER, @"** CIMInputHandler inited: %@ / with manage: %@", self, aManager);
    if (self) {
        self->manager = aManager;
    }
    return self;
}

- (void)setManager:(CIMInputManager *)aManager {
    self->manager = aManager;
}

#pragma - IMKServerInputTextData

- (BOOL)inputText:(NSString *)string key:(NSInteger)keyCode modifiers:(NSUInteger)flags client:(id)sender {    
    BOOL ret = [self->manager.currentComposer inputText:string key:keyCode modifiers:flags client:sender];
    
    NSString *commitString = self->manager.currentComposer.commitString;
    if ([commitString length] > 0) {
        ICLog(DEBUG_INPUTHANDLER, @"-- commit string: %@ on ret: %d", commitString, ret);
        [sender insertText:commitString replacementRange:NSMakeRange(NSNotFound, NSNotFound)];
    }
    
    return ret;
}

@end