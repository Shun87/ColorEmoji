//
//  Font.m
//  FontDesigner
//
//  Created by chenshun on 13-5-6.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import "Font.h"

@implementation Font
@synthesize sectionTitle, fontFamilyArray;

- (void)dealloc
{
    [sectionTitle release];
    [fontFamilyArray release];
    [super dealloc];
}

- (id)init{
    if (self = [super init])
    {
        fontFamilyArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addFamily:(NSString *)family
{
     [fontFamilyArray addObject:family];
    //if (![fontFamilyArray containsObject:family])
    {
       
    }
}

- (void)sortFamilies
{
    [fontFamilyArray sortUsingComparator: ^NSComparisonResult(id obj1, id obj2){
        
        NSString *objStr1 = (NSString *)obj1;
        NSString *objStr2 = (NSString *)obj2;
        return [objStr1 compare:objStr2];
    }];
}

@end
