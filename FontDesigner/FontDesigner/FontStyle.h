//
//  Style.h
//  FontDesigner
//
//  Created by chenshun on 13-5-6.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FontStyle : NSObject
{
    NSString *styleTitle;
    NSMutableArray *fontNameArray;
}
@property (nonatomic, copy)NSString *styleTitle;
@property (nonatomic, retain)NSMutableArray *fontNameArray;

- (void)addFont:(NSString *)font;
- (void)sortFonts;
@end
