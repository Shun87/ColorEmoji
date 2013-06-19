//
//  SymbolUnits.m
//  FontDesigner
//
//  Created by  on 13-6-17.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import "SymbolUnits.h"

@implementation SymbolUnits
@synthesize symbolArray, name, symbolID;

- (void)dealloc
{
    [symbolArray release];
    [name release];
    [super dealloc];
}

- (id)init
{
    if (self = [super init])
    {
        symbolArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}
@end
