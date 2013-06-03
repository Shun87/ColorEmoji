//
//  Font.h
//  FontDesigner
//
//  Created by chenshun on 13-5-6.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Font : NSObject
{
    NSString *sectionTitle;
    NSMutableArray *fontFamilyArray;
}
@property (nonatomic, copy)NSString *sectionTitle;
@property (nonatomic, retain)NSMutableArray *fontFamilyArray;

- (void)addFamily:(NSString *)family;
- (void)sortFamilies;
@end
