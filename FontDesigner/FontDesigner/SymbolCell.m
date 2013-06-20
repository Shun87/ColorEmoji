//
//  SymbolCell.m
//  SymbolsViewController
//
//  Created by  on 13-5-23.
//  Copyright (c) 2013年 Crearo. All rights reserved.
//

#import "SymbolCell.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+HexColor.h"
#import <AudioToolbox/AudioToolbox.h>

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

    int width = 40;
    for (int i=0; i<[buttonArray count]; i++)
    {
        float leftMargin = i * width;
        float topMargin = 0;
        UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(leftMargin, topMargin, width, self.frame.size.height)] autorelease];
        view.layer.borderWidth = 0.5;
        view.layer.borderColor = [UIColor grayColor].CGColor;
        [self addSubview:view];
        view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight;
        
        UILabel *label = [buttonArray objectAtIndex:i];
        label.textColor = [UIColor blackColor];
        label.frame = CGRectMake(0, 0, width, 40);
        label.textAlignment = UITextAlignmentCenter;
        label.userInteractionEnabled = YES;
        label.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
        label.backgroundColor = [UIColor clearColor];
        [view addSubview:label];
        label.tag = 1014;
        
        float height = view.frame.size.height - label.frame.size.height;
        topMargin = label.frame.size.height;
        UILabel *unicodeLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, topMargin, width, height)] autorelease];
        unicodeLabel.backgroundColor = [UIColor clearColor];
        unicodeLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        unicodeLabel.textAlignment = UITextAlignmentCenter;
        [view addSubview:unicodeLabel];
        unicodeLabel.font = [UIFont systemFontOfSize:11];
        unicodeLabel.textColor = [UIColor darkGrayColor];
        unicodeLabel.userInteractionEnabled = YES;
        unicodeLabel.tag = 1015;
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(handleTap:)];
        [view addGestureRecognizer:gesture];
        [gesture release];
    }
}

- (void)handleTap:(UITapGestureRecognizer *)gesture
{
    AudioServicesPlaySystemSound(1104);
    UILabel *label = (UILabel *)[gesture.view viewWithTag:1014];
    [_mtarget performSelector:_maction withObject:label];
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
        UIView *view = label.superview;
        UILabel *unicodeLabel = (UILabel *)[view viewWithTag:1015];
        NSString *hexStr = [self hexStrUnicodeStr:label.text];
        unicodeLabel.text = hexStr;
        if (changeFont)
        {
            label.font = [UIFont fontWithName:@"Apple Color Emoji" size:24];
        }
    }
}

- (NSString *)hexStrUnicodeStr:(NSString *)str
{
    NSData *data = [str dataUsingEncoding:NSUTF16LittleEndianStringEncoding];
    int nLen = [data length];
    UTF32Char hexValue = 0;
    NSString *hexStr;
    if (nLen == 2)
    {
        NSRange range;
        range.location = 0;
        range.length = 2;
        char buffer[2];
        [data getBytes:buffer range:range];
        hexValue = *(ushort *)buffer;
        hexStr = [NSString stringWithFormat:@"%04x", hexValue];
    }
    else if (nLen == 4)
    {
        NSRange range;
        range.location = 0;
        range.length = 2;
        char buffer[2];
        [data getBytes:buffer range:range];
        unichar high = *(ushort *)buffer;
        
        range.location = 2;
        range.length = 2;
        char buffer2[2];
        [data getBytes:buffer2 range:range];
        unichar low = *(ushort *)buffer2;
        hexValue = CFStringGetLongCharacterForSurrogatePair(high, low);
        hexStr = [NSString stringWithFormat:@"%x", hexValue];
    }
    
    return hexStr;
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
