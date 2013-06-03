//
//  SymbolCell.h
//  SymbolsViewController
//
//  Created by  on 13-5-23.
//  Copyright (c) 2013年 Crearo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SymbolCell : UITableViewCell
{
    UILabel *symButton1;
    UILabel *symButton2;
    UILabel *symButton3;
    UILabel *symButton4;
    UILabel *symButton5;
    UILabel *symButton6;
    UILabel *symButton7;
    UILabel *symButton8;
    
    NSMutableArray *buttonArray;
    
    id _mtarget;
    SEL _maction;
}

@property (nonatomic, retain)IBOutlet UILabel *symButton1;
@property (nonatomic, retain)IBOutlet UILabel *symButton2;
@property (nonatomic, retain)IBOutlet UILabel *symButton3;
@property (nonatomic, retain)IBOutlet UILabel *symButton4;
@property (nonatomic, retain)IBOutlet UILabel *symButton5;
@property (nonatomic, retain)IBOutlet UILabel *symButton6;
@property (nonatomic, retain)IBOutlet UILabel *symButton7;
@property (nonatomic, retain)IBOutlet UILabel *symButton8;

- (void)setFontSize:(NSInteger)size;
- (void)setNormalColor:(UIColor *)color;
- (void)setHighlightColor:(UIColor *)color;
- (void)setTitle:(NSArray *)array withFont:(BOOL)changeFont;
- (void)addTaget:(id)target selector:(SEL)sel;
@end
