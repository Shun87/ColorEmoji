//
//  SpecialSymbol.h
//  CustomEmoji
//
//  Created by chenshun on 13-6-2.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpecialSymbol : NSObject
{
    NSString *symbolText;
    NSString *unicode;
    NSString *desc;
}
@property (nonatomic, copy)NSString *symbolText;
@property (nonatomic, copy)NSString *unicode;
@property (nonatomic, copy)NSString *desc;

- (id)initWithText:(NSString *)symbol unicode:(NSString *)unicodeStr desc:(NSString *)description;
@end
