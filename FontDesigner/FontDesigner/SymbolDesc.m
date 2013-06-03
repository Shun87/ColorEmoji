//
//  SymbolDesc.m
//  FontDesigner
//
//  Created by chenshun on 13-5-23.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import "SymbolDesc.h"

@implementation SymbolDesc
@synthesize maxUnicode, minUnicode, symbolName;

- (id)initWithName:(NSString *)symbol minHex:(NSString *)minStr maxHex:(NSString *)maxStr
{
    if (self = [super init])
    {
        self.symbolName = symbol;
        self.minUnicode = minStr;
        self.maxUnicode = maxStr;
    }
    
    return self;
}

- (void)dealloc
{
    [maxUnicode release];
    [minUnicode release];
    [symbolName release];
    [super dealloc];
}
@end
