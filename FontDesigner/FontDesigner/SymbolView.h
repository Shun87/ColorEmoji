//
//  SymbolView.h
//  FontDesigner
//
//  Created by  on 13-6-17.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum 
{
    ST_Symbol,
    ST_Emoji,
    ST_History
}SymbolType;
@protocol SymbolViewDelegate;
@interface SymbolView : UIView <UIScrollViewDelegate>
{
    UIScrollView *scrollView;
    UISegmentedControl *segmentControl;
    NSMutableArray *symbolList;
    NSMutableArray *labelArray;
    id<SymbolViewDelegate> _delegate;
    SymbolType type;
}

@property (nonatomic, assign)id<SymbolViewDelegate> delegate;

- (void)setSymbolShowType:(SymbolType)aType;
@end
@protocol SymbolViewDelegate <NSObject>

- (void)selectSymbol:(NSString *)text;
@end