//
//  AppDelegate.h
//  StockQuoter
//
//  Created by Pratt, Jeffrey on 7/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
    IBOutlet NSMenu *statusMenu;
    NSStatusItem *statusItem;
}

@property (assign) IBOutlet NSWindow *window;

- (NSArray*) loadQuoteData;
- (NSImage*) getImage:(float)stock;
- (void) drawIcon;
- (void) handleQuitClick;
- (IBAction) openNewsLink:(id)sender;

@end
