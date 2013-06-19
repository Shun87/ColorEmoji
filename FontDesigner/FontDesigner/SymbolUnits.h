//
//  SymbolUnits.h
//  FontDesigner
//
//  Created by  on 13-6-17.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//


#import <UIKit/UIKit.h>
@interface SymbolUnits : NSObject
{
    NSMutableArray *symbolArray;
    NSString *name;
    NSInteger symbolID;
}
@property (nonatomic, assign)NSInteger symbolID;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, retain)NSMutableArray *symbolArray;
@end
