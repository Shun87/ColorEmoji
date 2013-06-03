//
//  SymbolCategory.m
//  CustomEmoji
//
//  Created by chenshun on 13-6-2.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import "SymbolCategory.h"

@implementation SymbolCategory
@synthesize categoryName, symbolArray;
- (void)dealloc
{
    [categoryName release];
    [symbolArray release];
    [super dealloc];
}

- (id)init
{
    if(self = [super init])
    {
        symbolArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}
@end
