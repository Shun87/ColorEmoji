//
//  SymbolDesc.h
//  FontDesigner
//
//  Created by chenshun on 13-5-23.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SymbolDesc : NSObject
{
    NSString *symbolName;
    NSString *minUnicode;
    NSString *maxUnicode;
}
@property (nonatomic, copy)NSString *symbolName;
@property (nonatomic, copy)NSString *minUnicode;
@property (nonatomic, copy)NSString *maxUnicode;

- (id)initWithName:(NSString *)symbol minHex:(NSString *)minStr maxHex:(NSString *)maxStr;
@end
