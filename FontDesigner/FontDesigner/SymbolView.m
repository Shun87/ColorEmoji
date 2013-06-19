//
//  SymbolView.m
//  FontDesigner
//
//  Created by  on 13-6-17.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import "SymbolView.h"
#import "SymbolDesc.h"
#import "UIColor+HexColor.h"
#import <AudioToolbox/AudioToolbox.h>
#import "SymbolUnits.h"
#import <QuartzCore/QuartzCore.h>
@implementation UIScrollView(Overide)
// called before scrolling begins if touches have already been delivered to a subview of the scroll view. if it returns NO the touches will continue to be delivered to the subview and scrolling will not occur
// not called if canCancelContentTouches is NO. default returns YES if view isn't a UIControl
- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    return YES;
}

@end
@implementation SymbolView
@synthesize delegate = _delegate;

- (void)dealloc
{
    _delegate = nil;
    [scrollView release];
    [symbolList release];
    [segmentControl release];
    [labelArray release];
    [super dealloc];
}

- (id)init
{    
    self = [super initWithFrame:CGRectMake(0, 0, 320, 216)];
    if (self) {
        labelArray = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor colorFromHex:LightGray];
        
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 170)];
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = YES;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.delegate = self;
        scrollView.canCancelContentTouches = YES;
        [self addSubview:scrollView];
    }
    return self;
}

- (void)setSymbolShowType:(SymbolType)aType
{
    type = aType;
    
    [self loadLocalSymbols];
    [self resizeContent:0];
    if (type == ST_Symbol)
    {
        [self addSegment];
    }
}

- (void)loadLocalSymbols
{
    if (symbolList == nil)
    {
        symbolList = [[NSMutableArray alloc] init];
    }
    
    if (type == ST_Symbol)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"CommonSymbol.plist" ofType:nil];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
        for (int i=0; i<[[dic allKeys] count]; i++)
        {
            NSString *key = [[dic allKeys] objectAtIndex:i];
            NSDictionary *arrayDic = [dic objectForKey:key];
            SymbolUnits *symbolUnit = [[SymbolUnits alloc] init];
            symbolUnit.name = key;
            symbolUnit.symbolID = [[arrayDic objectForKey:@"symboID"] intValue];
            for (int j=0; j<[[arrayDic allKeys] count] - 1; j++)
            {
                NSString *key2 = [NSString stringWithFormat:@"h%d", j+1];//[[arrayDic allKeys] objectAtIndex:j];
    
                if (![key2 isEqualToString:@"symboID"])
                {
                    NSDictionary *dic2 = [arrayDic objectForKey:key2];
                    NSString *min = [dic2 objectForKey:@"from"];
                    NSString *max = [dic2 objectForKey:@"to"];
                    SymbolDesc *symbol = [[SymbolDesc alloc] initWithName:key minHex:min maxHex:max];
                    [symbolUnit.symbolArray addObject:symbol];
                    [symbol release];
                }
            }
            
            [symbolList addObject:symbolUnit];
            [symbolUnit release];
        }
        
        [symbolList sortUsingComparator: ^NSComparisonResult(id obj1, id obj2){
            
            SymbolUnits *objSymbol1 = (SymbolUnits *)obj1;
            SymbolUnits *objSymbol2 = (SymbolUnits *)obj2;
            
            if (objSymbol1.symbolID > objSymbol2.symbolID)
            {
                return NSOrderedDescending;
            }
            
            return NSOrderedAscending;
        }];
    }
}

- (void)addSegment
{
    int topMargin = scrollView.frame.size.height + 2;
    segmentControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:
                                                                @"\u2749",
                                                                @"\u265c",
                                                                @"\u24b6",
                                                                @"\u220c", 
                                                                @"\u21af",
                                                                @"\u25d3",
                                                                
                                                                nil ]];
    
    segmentControl.frame = CGRectMake(20, topMargin, 280, 40);
    [self addSubview:segmentControl];
    segmentControl.segmentedControlStyle = UISegmentedControlStyleBar;
    segmentControl.tintColor = [UIColor darkGrayColor];
    segmentControl.selectedSegmentIndex = 0;
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:
                                                                    [UIFont systemFontOfSize:24],
                                                                    [UIColor whiteColor],
                                                                    nil] 
                                                           forKeys:[NSArray arrayWithObjects:
                                                                    UITextAttributeFont, 
                                                                    UITextAttributeTextColor,
                                                                    nil]];
    [segmentControl setTitleTextAttributes:dictionary forState:UIControlStateNormal];
    [segmentControl addTarget:self action:@selector(changeSymbolCategory:) forControlEvents:UIControlEventValueChanged];
}

- (IBAction)changeSymbolCategory:(id)sender
{
    NSInteger index = segmentControl.selectedSegmentIndex;
    if (index <= 5)
    {
        [self resizeContent:index];
    }
}

- (void)resizeContent:(NSInteger)index
{
    [self removeAllSymbol];
   
    NSMutableArray *array = [NSMutableArray array];
    if (type == ST_History)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"History.plist"];
        NSArray *contents = [NSMutableArray arrayWithContentsOfFile:path];
        for (int i=0; i<[contents count]; i++)
        {
            NSString *symbolStr = nil;
            uint hexVal = [[contents objectAtIndex:i] unsignedIntValue];
            if (hexVal >= 0x10000)
            {
                UniChar c[2];
                CFStringGetSurrogatePairForLongCharacter(hexVal, c);
                symbolStr = [[NSString alloc] initWithCharacters:c length:2];
            }
            else
            {
                NSData *data = [NSData dataWithBytes:&hexVal length:sizeof(ushort)];
                symbolStr = [[[NSString alloc] initWithData:data
                                                             encoding:NSUTF16LittleEndianStringEncoding] autorelease];

            }
            
            [array addObject:symbolStr];
        }
    }
    else if (type == ST_Emoji)
    {
        NSArray *array1 = [[NSArray arrayWithObjects:@"\U0001F604",@"\U0001F60A",@"\U0001F603",@"\u263A",@"\U0001F609",@"\U0001F60D",@"\U0001F618",@"\U0001F61A",@"\U0001F633",@"\U0001F60C",@"\U0001F601",@"\U0001F61C",@"\U0001F61D",@"\U0001F612",@"\U0001F60F",@"\U0001F613",@"\U0001F614",@"\U0001F61E",@"\U0001F616",@"\U0001F625",@"\U0001F630",@"\U0001F628",@"\U0001F623",@"\U0001F622",@"\U0001F62D",@"\U0001F602",@"\U0001F632",@"\U0001F631",@"\U0001F620",@"\U0001F621",@"\U0001F62A",@"\U0001F637",@"\U0001F47F",@"\U0001F47D",@"\U0001F49B",@"\U0001F499",@"\U0001F49C",@"\U0001F497",@"\U0001F49A",@"\u2764",@"\U0001F494",@"\U0001F493",@"\U0001F498",@"\u2728",@"\u2B50",@"\U0001F31F",@"\U0001F4A2",@"\u2757",@"\u2755",@"\u2753",@"\u2754",@"\U0001F4A4",@"\U0001F4A8",@"\U0001F4A6",@"\U0001F3B6",@"\U0001F3B5",@"\U0001F525",@"\U0001F4A9",@"\U0001F44D",@"\U0001F44E",@"\U0001F44C",@"\U0001F44A",@"\u270A",@"\u270C",@"\U0001F44B",@"\u270B",@"\U0001F450",@"\U0001F446",@"\U0001F447",@"\U0001F449",@"\U0001F448",@"\U0001F64C",@"\U0001F64F",@"\u261D",@"\U0001F44F",@"\U0001F4AA",@"\U0001F6B6",@"\U0001F3C3",@"\U0001F46B",@"\U0001F483",@"\U0001F46F",@"\U0001F646",@"\U0001F645",@"\U0001F481",@"\U0001F647",@"\U0001F48F",@"\U0001F491",@"\U0001F486",@"\U0001F487",@"\U0001F485",@"\U0001F466",@"\U0001F467",@"\U0001F469",@"\U0001F468",@"\U0001F476",@"\U0001F475",@"\U0001F474",@"\U0001F471",@"\U0001F472",@"\U0001F473",@"\U0001F477",@"\U0001F46E",@"\U0001F47C",@"\U0001F478",@"\U0001F482",@"\U0001F480",@"\U0001F463",@"\U0001F48B",@"\U0001F444",@"\U0001F442",@"\U0001F440",@"\U0001F443", nil] retain];
        NSArray *array2 = [[NSArray arrayWithObjects:@"\u2600",@"\u2614",@"\u2601",@"\u26C4",@"\U0001F319",@"\u26A1",@"\U0001F300",@"\U0001F30A",@"\U0001F431",@"\U0001F436",@"\U0001F42D",@"\U0001F439",@"\U0001F430",@"\U0001F43A",@"\U0001F438",@"\U0001F42F",@"\U0001F428",@"\U0001F43B",@"\U0001F437",@"\U0001F42E",@"\U0001F417",@"\U0001F412",@"\U0001F434",@"\U0001F40E",@"\U0001F42B",@"\U0001F411",@"\U0001F418",@"\U0001F40D",@"\U0001F426",@"\U0001F424",@"\U0001F414",@"\U0001F427",@"\U0001F41B",@"\U0001F419",@"\U0001F435",@"\U0001F420",@"\U0001F41F",@"\U0001F433",@"\U0001F42C",@"\U0001F490",@"\U0001F338",@"\U0001F337",@"\U0001F340",@"\U0001F339",@"\U0001F33B",@"\U0001F33A",@"\U0001F341",@"\U0001F343",@"\U0001F342",@"\U0001F334",@"\U0001F335",@"\U0001F33E",@"\U0001F41A", nil] retain];
        NSArray *array3 = [[NSArray arrayWithObjects:@"\U0001F38D",@"\U0001F49D",@"\U0001F38E",@"\U0001F392",@"\U0001F393",@"\U0001F38F",@"\U0001F386",@"\U0001F387",@"\U0001F390",@"\U0001F391",@"\U0001F383",@"\U0001F47B",@"\U0001F385",@"\U0001F384",@"\U0001F381",@"\U0001F514",@"\U0001F389",@"\U0001F388",@"\U0001F4BF",@"\U0001F4C0",@"\U0001F4F7",@"\U0001F3A5",@"\U0001F4BB",@"\U0001F4FA",@"\U0001F4F1",@"\U0001F4E0",@"\u260E",@"\U0001F4BD",@"\U0001F4FC",@"\U0001F50A",@"\U0001F4E2",@"\U0001F4E3",@"\U0001F4FB",@"\U0001F4E1",@"\u27BF",@"\U0001F50D",@"\U0001F513",@"\U0001F512",@"\U0001F511",@"\u2702",@"\U0001F528",@"\U0001F4A1",@"\U0001F4F2",@"\U0001F4E9",@"\U0001F4EB",@"\U0001F4EE",@"\U0001F6C0",@"\U0001F6BD",@"\U0001F4BA",@"\U0001F4B0",@"\U0001F531",@"\U0001F6AC",@"\U0001F4A3",@"\U0001F52B",@"\U0001F48A",@"\U0001F489",@"\U0001F3C8",@"\U0001F3C0",@"\u26BD",@"\u26BE",@"\U0001F3BE",@"\u26F3",@"\U0001F3B1",@"\U0001F3CA",@"\U0001F3C4",@"\U0001F3BF",@"\u2660",@"\u2665",@"\u2663",@"\u2666",@"\U0001F3C6",@"\U0001F47E",@"\U0001F3AF",@"\U0001F004",@"\U0001F3AC",@"\U0001F4DD",@"\U0001F4D6",@"\U0001F3A8",@"\U0001F3A4",@"\U0001F3A7",@"\U0001F3BA",@"\U0001F3B7",@"\U0001F3B8",@"\u303D",@"\U0001F45F",@"\U0001F461",@"\U0001F460",@"\U0001F462",@"\U0001F455",@"\U0001F454",@"\U0001F457",@"\U0001F458",@"\U0001F459",@"\U0001F380",@"\U0001F3A9",@"\U0001F451",@"\U0001F452",@"\U0001F302",@"\U0001F4BC",@"\U0001F45C",@"\U0001F484",@"\U0001F48D",@"\U0001F48E",@"\u2615",@"\U0001F338",@"\U0001F37A",@"\U0001F37B",@"\U0001F378",@"\U0001F376",@"\U0001F374",@"\U0001F354",@"\U0001F35F",@"\U0001F35D",@"\U0001F35B",@"\U0001F371",@"\U0001F363",@"\U0001F359",@"\U0001F358",@"\U0001F35A",@"\U0001F35C",@"\U0001F372",@"\U0001F35E",@"\U0001F373",@"\U0001F362",@"\U0001F361",@"\U0001F366",@"\U0001F367",@"\U0001F382",@"\U0001F370",@"\U0001F34E",@"\U0001F34A",@"\U0001F349",@"\U0001F353",@"\U0001F346",@"\U0001F345", nil] retain];
        NSArray *array4 = [[NSArray arrayWithObjects:@"\U0001F3E0",@"\U0001F3EB",@"\U0001F3E2",@"\U0001F3E3",@"\U0001F3E5",@"\U0001F3E6",@"\U0001F3EA",@"\U0001F3E9",@"\U0001F3E8",@"\U0001F492",@"\u26EA",@"\U0001F3EC",@"\U0001F44A",@"\U0001F306",@"\uE50A",@"\U0001F3EF",@"\U0001F3F0",@"\u26FA",@"\U0001F3ED",@"\U0001F5FC",@"\U0001F5FB",@"\U0001F304",@"\U0001F305",@"\U0001F303",@"\U0001F5FD",@"\U0001F308",@"\U0001F3A1",@"\u26F2",@"\U0001F3A2",@"\U0001F6A2",@"\U0001F6A4",@"\u26F5",@"\u2708",@"\U0001F680",@"\U0001F6B2",@"\U0001F699",@"\U0001F697",@"\U0001F695",@"\U0001F68C",@"\U0001F693",@"\U0001F692",@"\U0001F691",@"\U0001F69A",@"\U0001F683",@"\U0001F689",@"\U0001F684",@"\U0001F685",@"\U0001F3AB",@"\u26FD",@"\U0001F6A5",@"\u26A0",@"\U0001F6A7",@"\U0001F530",@"\U0001F3E7",@"\U0001F3B0",@"\U0001F68F",@"\U0001F488",@"\u2668",@"\U0001F3C1",@"\U0001F38C",@"\U0001F1EF",@"\U0001F1F5",@"\U0001F1F0",@"\U0001F1F7",@"\U0001F1E8",@"\U0001F1F3",@"\U0001F1FA",@"\U0001F1F8",@"\U0001F1EB",@"\U0001F1F7",@"\U0001F1EA",@"\U0001F1F8",@"\U0001F1EE",@"\U0001F1F9",@"\U0001F1F7",@"\U0001F1FA",@"\U0001F1EC",@"\U0001F1E7",@"\U0001F1E9",@"\U0001F1EA", nil] retain];
        NSArray *array5 = [[NSArray arrayWithObjects:[NSString stringWithFormat:@"%C%C",0x0031,0x20E3],[NSString stringWithFormat:@"%C%C",0x0032,0x20E3],[NSString stringWithFormat:@"%C%C",0x0033,0x20E3],[NSString stringWithFormat:@"%C%C",0x0034,0x20E3],[NSString stringWithFormat:@"%C%C",0x0035,0x20E3],[NSString stringWithFormat:@"%C%C",0x0036,0x20E3],[NSString stringWithFormat:@"%C%C",0x0037,0x20E3],[NSString stringWithFormat:@"%C%C",0x0038,0x20E3],[NSString stringWithFormat:@"%C%C",0x0039,0x20E3],[NSString stringWithFormat:@"%C%C",0x0030,0x20E3],[NSString stringWithFormat:@"%C%C",0x0023,0x20E3],@"\u2B06",@"\u2B07",@"\u2B05",@"\u27A1",@"\u2197",@"\u2196",@"\u2198",@"\u2199",@"\u25C0",@"\u25B6",@"\u23EA",@"\u23E9",@"\U0001F197",@"\U0001F195",@"\U0001F51D",@"\U0001F199",@"\U0001F192",@"\U0001F3A6",@"\U0001F201",@"\U0001F4F6",@"\U0001F235",@"\U0001F233",@"\U0001F250",@"\U0001F239",@"\U0001F22F",@"\U0001F23A",@"\U0001F236",@"\U0001F21A",@"\U0001F237",@"\U0001F238",@"\U0001F202",@"\U0001F6BB",@"\U0001F6B9",@"\U0001F6BA",@"\U0001F6BC",@"\U0001F6AD",@"\U0001F17F",@"\u267F",@"\U0001F434",@"\U0001F6BE",@"\u3299",@"\u3297",@"\U0001F51E",@"\U0001F194",@"\u2733",@"\u2734",@"\U0001F49F",@"\U0001F19A",@"\U0001F4F3",@"\U0001F4F4",@"\U0001F4B9",@"\U0001F4B1",@"\u2648",@"\u2649",@"\u264A",@"\u264B",@"\u264C",@"\u264D",@"\u264E",@"\u264F",@"\u2650",@"\u2651",@"\u2652",@"\u2653",@"\u26CE",@"\U0001F52F",@"\U0001F170",@"\U0001F171",@"\U0001F18E",@"\U0001F17E",@"\U0001F532",@"\U0001F534",@"\U0001F533",@"\U0001F55B",@"\U0001F550",@"\U0001F551",@"\U0001F552",@"\U0001F553",@"\U0001F554",@"\U0001F555",@"\U0001F556",@"\U0001F557",@"\U0001F558",@"\U0001F559",@"\U0001F55A",@"\u2B55",@"\u274C",@"\u00A9",@"\u00AE", nil] retain];
        
        [array addObjectsFromArray:array1];
        [array addObjectsFromArray:array2];
        [array addObjectsFromArray:array3];
        [array addObjectsFromArray:array4];
        [array addObjectsFromArray:array5];
    }
    else
    {
        SymbolUnits *unit = [symbolList objectAtIndex:index];
        for (int i=0; i<[unit.symbolArray count]; i++)
        {
            SymbolDesc *symbolDesc = [unit.symbolArray objectAtIndex:i];
            NSString *minUnicode = [symbolDesc.minUnicode stringByReplacingOccurrencesOfString:@"U+" withString:@""];
            NSString *maxUnicode = [symbolDesc.maxUnicode stringByReplacingOccurrencesOfString:@"U+" withString:@""];
            unichar minHex = (unichar)strtol([minUnicode UTF8String], 0, 16);
            unichar maxHex = (unichar)strtol([maxUnicode UTF8String], 0, 16);
            for (unichar hex = minHex; hex <= maxHex; hex++)
            {
                BOOL legal = ![[NSCharacterSet illegalCharacterSet] characterIsMember:hex];
                if (legal)
                {
                    NSData *data = [NSData dataWithBytes:&hex length:sizeof(ushort)];
                    NSString *symbolStr = [[NSString alloc] initWithData:data
                                                                encoding:NSUTF16LittleEndianStringEncoding];

                    [array addObject:symbolStr];
                }
            }
        }
    }

    int countOnePage = 32;
    if (type == ST_History || type == ST_Emoji)
    {
        countOnePage = 40;
        CGRect rect = scrollView.frame;
        rect.size.height += 40;
        scrollView.frame = rect;
    }
    int countOneRow = 8;
    int width = 40;
    for (int i=0; i<[array count]; i++)
    {
        NSString *text = [array objectAtIndex:i];
        UILabel *label = [[[UILabel alloc] init] autorelease];
        float leftMargin = i/countOnePage * 320 + (i%countOnePage)%countOneRow * width;
        float topMargin = (i%countOnePage)/countOneRow * width + 4;
        
        label.frame = CGRectMake(leftMargin, topMargin, width, 40);
        if (type == ST_Emoji)
        {
            label.font = [UIFont fontWithName:@"Apple Color Emoji" size:24];
        }
        else
        {
            label.font = [UIFont systemFontOfSize:24];
        }
        
        label.textColor = [UIColor blackColor];
        label.text = text;
        label.layer.borderWidth = 0.5;
        label.layer.borderColor = [UIColor grayColor].CGColor;
        label.textAlignment = UITextAlignmentCenter;
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(handleTap:)];
        [label addGestureRecognizer:gesture];
        [gesture release];
        [labelArray addObject:label];
        [scrollView addSubview:label];
    }
    
    float pageCount = [array count] / countOnePage + ([array count] % countOnePage > 0 ? 1 : 0);
    scrollView.contentSize = CGSizeMake(pageCount * 320, scrollView.frame.size.height);
}

- (void)removeAllSymbol
{
    for (int i=0; i<[labelArray count]; i++)
    {
        UIView *subView = (UIView *)[labelArray objectAtIndex:i];
        [subView removeFromSuperview];
    }
    
    [labelArray removeAllObjects];
}

- (void)handleTap:(UIGestureRecognizer *)gesture
{
    AudioServicesPlaySystemSound(1104);
    UILabel *label = (UILabel *)gesture.view;
//    
//    
    NSData *data = [label.text dataUsingEncoding:NSUTF16LittleEndianStringEncoding];
    int nLen = [data length];
    UTF32Char hexValue = 0;
   // for (int i=0; i<nLen; i+=2)
    {
        if (nLen == 2)
        {
            NSRange range;
            range.location = 0;
            range.length = 2;
            char buffer[2];
            [data getBytes:buffer range:range];
             hexValue = *(ushort *)buffer;
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
        }
    }
   [_delegate selectSymbol:label.text];
    
    [self saveHistory:hexValue];
}

- (void)saveHistory:(unsigned int)hexValue
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"History.plist"];
    NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:path];
    if (array == nil)
    {
        array = [NSMutableArray array];
    }
    
    NSNumber *number = [NSNumber numberWithUnsignedInt:hexValue];
    NSLog(@"%d", [number intValue]);
    if (![array containsObject:number] )
    {
        [array insertObject:number atIndex:0];
        [array writeToFile:path atomically:YES];
    }
}
@end
