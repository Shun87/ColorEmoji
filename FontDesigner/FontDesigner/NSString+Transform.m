//
//  NSString+Transform.m
//  FontDesigner
//
//  Created by chenshun on 13-5-23.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import "NSString+Transform.h"

@implementation NSString (Transform)
- (NSString *)transformString
{
    CFStringTransform(( CFMutableStringRef)self, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform(( CFMutableStringRef)self, NULL, kCFStringTransformStripDiacritics, NO);
    return self;
}

@end
