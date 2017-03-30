//
//  AppDelegate.m
//  StockQuoter
//
//  Created by Pratt, Jeffrey on 7/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{

}

- (NSArray*) loadQuoteData 
{
    // TODO: Make this a preference
    NSURL *url = 
        [NSURL URLWithString:@"https://download.finance.yahoo.com/d/quotes.csv?s=AMZN&f=sl1c1"];
    
    NSString *csv = 
        [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:NULL];
    
    NSArray *quoteData = [csv componentsSeparatedByString:@","];
    
    return quoteData;
}

- (NSImage*) getImage:(float)stock 
{
    NSImage *image = [NSImage imageNamed:@"neutral.png"];
    
    // Stock is down. :-(
    if (stock < 0.00) {
        image = [NSImage imageNamed:@"frown.png"];
    }
    
    // Stock is up! :-)
    if (stock > 0.00) {
        image = [NSImage imageNamed:@"happy.png"];
    }
    
    [image setSize:(NSSize){15, 15}];
    
    return image;
}

- (void) drawIcon
{
    NSLog(@"Updating icon at timestamp %f", CFAbsoluteTimeGetCurrent()); 
    
    statusItem = [[NSStatusBar systemStatusBar]
                   statusItemWithLength:NSVariableStatusItemLength];
    
    [statusItem setMenu:statusMenu];
    
    NSArray *quoteData = [self loadQuoteData];
    float stockPrice = [[quoteData objectAtIndex:2] floatValue];
    
    [statusItem setImage:[self getImage:stockPrice]];
    [statusItem setToolTip:[quoteData componentsJoinedByString:@", "]];
    
}

- (void) awakeFromNib 
{
    [self drawIcon];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60 
                                                      target:self 
                                                    selector:@selector(drawIcon)
                                                    userInfo:nil 
                                                     repeats:YES];
}

- (void) handleQuitClick 
{
    [NSApp terminate:self];
}

- (IBAction) handleNewsClick:(id)sender
{
    [[NSWorkspace sharedWorkspace] 
        openURL:[NSURL URLWithString:@"http://finance.yahoo.com/q?d=t&s=AMZN"]]; 
}

@end
