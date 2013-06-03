//
//  Style.m
//  FontDesigner
//
//  Created by chenshun on 13-5-6.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import "FontStyle.h"

@implementation FontStyle
@synthesize styleTitle, fontNameArray;

- (void)dealloc
{
    [styleTitle release];
    [fontNameArray release];
    [super dealloc];
}

- (id)init{
    if (self = [super init])
    {
        fontNameArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addFont:(NSString *)family
{
    [fontNameArray addObject:family];
}

- (void)sortFamilies
{
    [fontNameArray sortUsingComparator: ^NSComparisonResult(id obj1, id obj2){
        
        NSString *objStr1 = (NSString *)obj1;
        NSString *objStr2 = (NSString *)obj2;
        return [objStr1 compare:objStr2];
    }];
}

@end
