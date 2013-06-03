//
//  SymbolCategory.h
//  CustomEmoji
//
//  Created by chenshun on 13-6-2.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SymbolCategory : NSObject
{
    NSString *categoryName;
    NSMutableArray *symbolArray;
}
@property (nonatomic, copy)NSString *categoryName;
@property (nonatomic, copy)NSMutableArray *symbolArray;
@end
