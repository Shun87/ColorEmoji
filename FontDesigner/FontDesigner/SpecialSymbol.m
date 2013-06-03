//
//  SpecialSymbol.m
//  CustomEmoji
//
//  Created by chenshun on 13-6-2.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import "SpecialSymbol.h"

@implementation SpecialSymbol
@synthesize symbolText, unicode, desc;
- (void)dealloc
{
    [symbolText release];
    [unicode release];
    [desc release];
    [super dealloc];
}

- (id)initWithText:(NSString *)symbol unicode:(NSString *)unicodeStr desc:(NSString *)description
{
    self = [super init];
    self.symbolText = symbol;
    self.unicode = unicodeStr;
    self.desc = description;
    return self;
}

@end
