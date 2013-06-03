//
//  SymbolCell.m
//  SymbolsViewController
//
//  Created by  on 13-5-23.
//  Copyright (c) 2013年 Crearo. All rights reserved.
//

#import "SymbolCell.h"

@implementation SymbolCell
@synthesize symButton1, symButton2, symButton3, symButton4, symButton5, symButton6, symButton7, symButton8;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)awakeFromNib{
    
    buttonArray  = [[NSMutableArray alloc] init];
    [buttonArray addObjectsFromArray:[NSArray arrayWithObjects:symButton1,
                                      symButton2,symButton3,symButton4,symButton5,symButton6,
                                      symButton7, symButton8, nil]];
    [self setNormalColor:[UIColor blackColor]];
    //[self setHighlightColor:[UIColor blueColor]];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(handleTap:)];
    [self addGestureRecognizer:gesture];
    [gesture release];

}

- (void)handleTap:(UITapGestureRecognizer *)gesture
{
    CGPoint point = [gesture locationInView:self];
    for (UILabel *label in buttonArray)
    {
        CGRect rc = label.frame;
        if (CGRectContainsPoint(rc, point))
        {
            [_mtarget performSelector:_maction withObject:label];
            break;
        }
    }
}

- (void)setFontSize:(NSInteger)size
{
    for (UILabel *label in buttonArray)
    {
        label.font = [UIFont systemFontOfSize:size];
    }
}

- (void)setHighlightColor:(UIColor *)color
{
    for (UILabel *label in buttonArray)
    {
        label.textColor = color;
    }
}

- (void)setTitle:(NSArray *)array withFont:(BOOL)changeFont
{
    for (int i=0; i<[array count]; i++)
    {
        NSString *string = [array objectAtIndex:i];
        UILabel *label = [buttonArray objectAtIndex:i];
        label.text = string;
        if (changeFont)
        {
            label.font = [UIFont fontWithName:@"Apple Color Emoji" size:32];
        }
    }
}

- (void)addTaget:(id)target selector:(SEL)sel
{
    _mtarget = target;
    _maction = sel;
}

- (void)setNormalColor:(UIColor *)color
{
    for (UILabel *label in buttonArray)
    {
        label.textColor = color;
    }
}

- (void)dealloc
{
    [symButton1 release];
    [symButton2 release];
    [symButton3 release];
    [symButton4 release];
    [symButton5 release];
    [symButton6 release];
    [symButton7 release];
    [symButton8 release];
    [buttonArray release];
    [super dealloc];
}

@end
