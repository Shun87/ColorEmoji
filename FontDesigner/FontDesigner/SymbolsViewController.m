//
//  SymbolsViewController.m
//  SymbolsViewController
//
//  Created by  on 13-5-23.
//  Copyright (c) 2013年 Crearo. All rights reserved.
//

#import "SymbolsViewController.h"
#import "AppDelegate.h"
@implementation SymbolsViewController
@synthesize mTableView;
@synthesize tmpCell, cellNib, symbolArray, symbolDesc, unicodeType;

- (void)dealloc
{
    [mTableView release];
    [cellNib release];
    [tmpCell release];
    [symbolArray release];
    [symbolDesc release];

    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        symbolArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.cellNib = [UINib nibWithNibName:@"SymbolsCell" bundle:nil];
    self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    if (unicodeType == Symbol)
    {
        NSString *minUnicode = [symbolDesc.minUnicode stringByReplacingOccurrencesOfString:@"U+" withString:@""];
        NSString *maxUnicode = [symbolDesc.maxUnicode stringByReplacingOccurrencesOfString:@"U+" withString:@""];
        uint minHex = (uint)strtol([minUnicode UTF8String], 0, 16);
        uint maxHex = (uint)strtol([maxUnicode UTF8String], 0, 16);
        
        for (uint hex = minHex; hex<maxHex; hex++)
        {
            NSData *data = [NSData dataWithBytes:&hex length:sizeof(ushort)];
            NSString *symbolStr = [[NSString alloc] initWithData:data
                                                        encoding:NSUTF16LittleEndianStringEncoding];
            [symbolArray addObject:symbolStr];
        }
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"back_white.png"] forState:UIControlStateNormal];
        [button setFrame:CGRectMake(0, 0, 40, 40)];
        button.showsTouchWhenHighlighted = YES;
        [button addTarget:self
                   action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.leftBarButtonItem = leftItem;
        self.navigationItem.title = symbolDesc.symbolName;
    
    }
    else if (unicodeType == Private_Smybol)
    {
        NSString *string = nil;
        for (int i=0xe001; i<=0xe05a; i++)
        {
            string = [NSString stringWithFormat:@"%C", i];
            [symbolArray addObject:string];
        }
        for (int i=0xe101; i<=0xe15a; i++)
        {
             string = [NSString stringWithFormat:@"%C", i];
            [symbolArray addObject:string];
        }
        for (int i=0xe201; i<=0xe253; i++)
        {
             string = [NSString stringWithFormat:@"%C", i];
            [symbolArray addObject:string];
        }
        for (int i=0xe301; i<=0xe34d; i++)
        {
             string = [NSString stringWithFormat:@"%C", i];
            [symbolArray addObject:string];
        }
        for (int i=0xe401; i<=0xe44c; i++)
        {
             string = [NSString stringWithFormat:@"%C", i];
            [symbolArray addObject:string];
        }
        for (int i=0xe501; i<=0xe536; i++)
        {
             string = [NSString stringWithFormat:@"%C", i];
            [symbolArray addObject:string];
        }
        
        
    }
    else if (unicodeType == Emoji)
    {
        self.navigationItem.title = NSLocalizedString(@"Emoj", nil);
        NSArray *array1 = [[NSArray arrayWithObjects:@"\U0001F604",@"\U0001F60A",@"\U0001F603",@"\u263A",@"\U0001F609",@"\U0001F60D",@"\U0001F618",@"\U0001F61A",@"\U0001F633",@"\U0001F60C",@"\U0001F601",@"\U0001F61C",@"\U0001F61D",@"\U0001F612",@"\U0001F60F",@"\U0001F613",@"\U0001F614",@"\U0001F61E",@"\U0001F616",@"\U0001F625",@"\U0001F630",@"\U0001F628",@"\U0001F623",@"\U0001F622",@"\U0001F62D",@"\U0001F602",@"\U0001F632",@"\U0001F631",@"\U0001F620",@"\U0001F621",@"\U0001F62A",@"\U0001F637",@"\U0001F47F",@"\U0001F47D",@"\U0001F49B",@"\U0001F499",@"\U0001F49C",@"\U0001F497",@"\U0001F49A",@"\u2764",@"\U0001F494",@"\U0001F493",@"\U0001F498",@"\u2728",@"\u2B50",@"\U0001F31F",@"\U0001F4A2",@"\u2757",@"\u2755",@"\u2753",@"\u2754",@"\U0001F4A4",@"\U0001F4A8",@"\U0001F4A6",@"\U0001F3B6",@"\U0001F3B5",@"\U0001F525",@"\U0001F4A9",@"\U0001F44D",@"\U0001F44E",@"\U0001F44C",@"\U0001F44A",@"\u270A",@"\u270C",@"\U0001F44B",@"\u270B",@"\U0001F450",@"\U0001F446",@"\U0001F447",@"\U0001F449",@"\U0001F448",@"\U0001F64C",@"\U0001F64F",@"\u261D",@"\U0001F44F",@"\U0001F4AA",@"\U0001F6B6",@"\U0001F3C3",@"\U0001F46B",@"\U0001F483",@"\U0001F46F",@"\U0001F646",@"\U0001F645",@"\U0001F481",@"\U0001F647",@"\U0001F48F",@"\U0001F491",@"\U0001F486",@"\U0001F487",@"\U0001F485",@"\U0001F466",@"\U0001F467",@"\U0001F469",@"\U0001F468",@"\U0001F476",@"\U0001F475",@"\U0001F474",@"\U0001F471",@"\U0001F472",@"\U0001F473",@"\U0001F477",@"\U0001F46E",@"\U0001F47C",@"\U0001F478",@"\U0001F482",@"\U0001F480",@"\U0001F463",@"\U0001F48B",@"\U0001F444",@"\U0001F442",@"\U0001F440",@"\U0001F443", nil] retain];
        NSArray *array2 = [[NSArray arrayWithObjects:@"\u2600",@"\u2614",@"\u2601",@"\u26C4",@"\U0001F319",@"\u26A1",@"\U0001F300",@"\U0001F30A",@"\U0001F431",@"\U0001F436",@"\U0001F42D",@"\U0001F439",@"\U0001F430",@"\U0001F43A",@"\U0001F438",@"\U0001F42F",@"\U0001F428",@"\U0001F43B",@"\U0001F437",@"\U0001F42E",@"\U0001F417",@"\U0001F412",@"\U0001F434",@"\U0001F40E",@"\U0001F42B",@"\U0001F411",@"\U0001F418",@"\U0001F40D",@"\U0001F426",@"\U0001F424",@"\U0001F414",@"\U0001F427",@"\U0001F41B",@"\U0001F419",@"\U0001F435",@"\U0001F420",@"\U0001F41F",@"\U0001F433",@"\U0001F42C",@"\U0001F490",@"\U0001F338",@"\U0001F337",@"\U0001F340",@"\U0001F339",@"\U0001F33B",@"\U0001F33A",@"\U0001F341",@"\U0001F343",@"\U0001F342",@"\U0001F334",@"\U0001F335",@"\U0001F33E",@"\U0001F41A", nil] retain];
        NSArray *array3 = [[NSArray arrayWithObjects:@"\U0001F38D",@"\U0001F49D",@"\U0001F38E",@"\U0001F392",@"\U0001F393",@"\U0001F38F",@"\U0001F386",@"\U0001F387",@"\U0001F390",@"\U0001F391",@"\U0001F383",@"\U0001F47B",@"\U0001F385",@"\U0001F384",@"\U0001F381",@"\U0001F514",@"\U0001F389",@"\U0001F388",@"\U0001F4BF",@"\U0001F4C0",@"\U0001F4F7",@"\U0001F3A5",@"\U0001F4BB",@"\U0001F4FA",@"\U0001F4F1",@"\U0001F4E0",@"\u260E",@"\U0001F4BD",@"\U0001F4FC",@"\U0001F50A",@"\U0001F4E2",@"\U0001F4E3",@"\U0001F4FB",@"\U0001F4E1",@"\u27BF",@"\U0001F50D",@"\U0001F513",@"\U0001F512",@"\U0001F511",@"\u2702",@"\U0001F528",@"\U0001F4A1",@"\U0001F4F2",@"\U0001F4E9",@"\U0001F4EB",@"\U0001F4EE",@"\U0001F6C0",@"\U0001F6BD",@"\U0001F4BA",@"\U0001F4B0",@"\U0001F531",@"\U0001F6AC",@"\U0001F4A3",@"\U0001F52B",@"\U0001F48A",@"\U0001F489",@"\U0001F3C8",@"\U0001F3C0",@"\u26BD",@"\u26BE",@"\U0001F3BE",@"\u26F3",@"\U0001F3B1",@"\U0001F3CA",@"\U0001F3C4",@"\U0001F3BF",@"\u2660",@"\u2665",@"\u2663",@"\u2666",@"\U0001F3C6",@"\U0001F47E",@"\U0001F3AF",@"\U0001F004",@"\U0001F3AC",@"\U0001F4DD",@"\U0001F4D6",@"\U0001F3A8",@"\U0001F3A4",@"\U0001F3A7",@"\U0001F3BA",@"\U0001F3B7",@"\U0001F3B8",@"\u303D",@"\U0001F45F",@"\U0001F461",@"\U0001F460",@"\U0001F462",@"\U0001F455",@"\U0001F454",@"\U0001F457",@"\U0001F458",@"\U0001F459",@"\U0001F380",@"\U0001F3A9",@"\U0001F451",@"\U0001F452",@"\U0001F302",@"\U0001F4BC",@"\U0001F45C",@"\U0001F484",@"\U0001F48D",@"\U0001F48E",@"\u2615",@"\U0001F338",@"\U0001F37A",@"\U0001F37B",@"\U0001F378",@"\U0001F376",@"\U0001F374",@"\U0001F354",@"\U0001F35F",@"\U0001F35D",@"\U0001F35B",@"\U0001F371",@"\U0001F363",@"\U0001F359",@"\U0001F358",@"\U0001F35A",@"\U0001F35C",@"\U0001F372",@"\U0001F35E",@"\U0001F373",@"\U0001F362",@"\U0001F361",@"\U0001F366",@"\U0001F367",@"\U0001F382",@"\U0001F370",@"\U0001F34E",@"\U0001F34A",@"\U0001F349",@"\U0001F353",@"\U0001F346",@"\U0001F345", nil] retain];
        NSArray *array4 = [[NSArray arrayWithObjects:@"\U0001F3E0",@"\U0001F3EB",@"\U0001F3E2",@"\U0001F3E3",@"\U0001F3E5",@"\U0001F3E6",@"\U0001F3EA",@"\U0001F3E9",@"\U0001F3E8",@"\U0001F492",@"\u26EA",@"\U0001F3EC",@"\U0001F44A",@"\U0001F306",@"\uE50A",@"\U0001F3EF",@"\U0001F3F0",@"\u26FA",@"\U0001F3ED",@"\U0001F5FC",@"\U0001F5FB",@"\U0001F304",@"\U0001F305",@"\U0001F303",@"\U0001F5FD",@"\U0001F308",@"\U0001F3A1",@"\u26F2",@"\U0001F3A2",@"\U0001F6A2",@"\U0001F6A4",@"\u26F5",@"\u2708",@"\U0001F680",@"\U0001F6B2",@"\U0001F699",@"\U0001F697",@"\U0001F695",@"\U0001F68C",@"\U0001F693",@"\U0001F692",@"\U0001F691",@"\U0001F69A",@"\U0001F683",@"\U0001F689",@"\U0001F684",@"\U0001F685",@"\U0001F3AB",@"\u26FD",@"\U0001F6A5",@"\u26A0",@"\U0001F6A7",@"\U0001F530",@"\U0001F3E7",@"\U0001F3B0",@"\U0001F68F",@"\U0001F488",@"\u2668",@"\U0001F3C1",@"\U0001F38C",@"\U0001F1EF",@"\U0001F1F5",@"\U0001F1F0",@"\U0001F1F7",@"\U0001F1E8",@"\U0001F1F3",@"\U0001F1FA",@"\U0001F1F8",@"\U0001F1EB",@"\U0001F1F7",@"\U0001F1EA",@"\U0001F1F8",@"\U0001F1EE",@"\U0001F1F9",@"\U0001F1F7",@"\U0001F1FA",@"\U0001F1EC",@"\U0001F1E7",@"\U0001F1E9",@"\U0001F1EA", nil] retain];
        NSArray *array5 = [[NSArray arrayWithObjects:[NSString stringWithFormat:@"%C%C",0x0031,0x20E3],[NSString stringWithFormat:@"%C%C",0x0032,0x20E3],[NSString stringWithFormat:@"%C%C",0x0033,0x20E3],[NSString stringWithFormat:@"%C%C",0x0034,0x20E3],[NSString stringWithFormat:@"%C%C",0x0035,0x20E3],[NSString stringWithFormat:@"%C%C",0x0036,0x20E3],[NSString stringWithFormat:@"%C%C",0x0037,0x20E3],[NSString stringWithFormat:@"%C%C",0x0038,0x20E3],[NSString stringWithFormat:@"%C%C",0x0039,0x20E3],[NSString stringWithFormat:@"%C%C",0x0030,0x20E3],[NSString stringWithFormat:@"%C%C",0x0023,0x20E3],@"\u2B06",@"\u2B07",@"\u2B05",@"\u27A1",@"\u2197",@"\u2196",@"\u2198",@"\u2199",@"\u25C0",@"\u25B6",@"\u23EA",@"\u23E9",@"\U0001F197",@"\U0001F195",@"\U0001F51D",@"\U0001F199",@"\U0001F192",@"\U0001F3A6",@"\U0001F201",@"\U0001F4F6",@"\U0001F235",@"\U0001F233",@"\U0001F250",@"\U0001F239",@"\U0001F22F",@"\U0001F23A",@"\U0001F236",@"\U0001F21A",@"\U0001F237",@"\U0001F238",@"\U0001F202",@"\U0001F6BB",@"\U0001F6B9",@"\U0001F6BA",@"\U0001F6BC",@"\U0001F6AD",@"\U0001F17F",@"\u267F",@"\U0001F434",@"\U0001F6BE",@"\u3299",@"\u3297",@"\U0001F51E",@"\U0001F194",@"\u2733",@"\u2734",@"\U0001F49F",@"\U0001F19A",@"\U0001F4F3",@"\U0001F4F4",@"\U0001F4B9",@"\U0001F4B1",@"\u2648",@"\u2649",@"\u264A",@"\u264B",@"\u264C",@"\u264D",@"\u264E",@"\u264F",@"\u2650",@"\u2651",@"\u2652",@"\u2653",@"\u26CE",@"\U0001F52F",@"\U0001F170",@"\U0001F171",@"\U0001F18E",@"\U0001F17E",@"\U0001F532",@"\U0001F534",@"\U0001F533",@"\U0001F55B",@"\U0001F550",@"\U0001F551",@"\U0001F552",@"\U0001F553",@"\U0001F554",@"\U0001F555",@"\U0001F556",@"\U0001F557",@"\U0001F558",@"\U0001F559",@"\U0001F55A",@"\u2B55",@"\u274C",@"\u00A9",@"\u00AE", nil] retain];
        
        [symbolArray addObjectsFromArray:array1];
        [symbolArray addObjectsFromArray:array2];
        [symbolArray addObjectsFromArray:array3];
        [symbolArray addObjectsFromArray:array4];
        [symbolArray addObjectsFromArray:array5];

    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
#if FreeApp
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (app.adBanner.superview != nil)
    {
        [app.adBanner removeFromSuperview];
    }
    
    CGRect rect = app.adBanner.frame;
    rect.origin.y = self.view.frame.size.height -  CGSizeFromGADAdSize(kGADAdSizeBanner).height;
    app.adBanner.frame = rect;
    app.adBanner.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:app.adBanner];
#endif
}

- (IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)symbolClicked:(id)sender
{
    UILabel *label = (UILabel *)sender;
    if (symbolDetailView == nil)
    {
        symbolDetailView = [[UIView alloc] initWithFrame:self.mTableView.frame];
        symbolDetailView.backgroundColor = [UIColor blackColor];
        symbolDetailView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.85];
        
        UILabel *taillabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, symbolDetailView.frame.size.height - 200, symbolDetailView.frame.size.width, 60)]autorelease];
        taillabel.textAlignment =  UITextAlignmentCenter;
        taillabel.textColor = [UIColor darkGrayColor];
        taillabel.text = label.text;
        [symbolDetailView addSubview:taillabel];
        taillabel.tag = 1001;
        taillabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
        if (unicodeType == Emoji || unicodeType == Private_Smybol)
        {
            taillabel.font = [UIFont fontWithName:@"Apple Color Emoji" size:59];
        }
        else
        {
            taillabel.font = [UIFont systemFontOfSize:59];
        }
        taillabel.backgroundColor = [UIColor clearColor];
        
        UILabel *copyLable = [[[UILabel alloc] initWithFrame:CGRectMake(0, taillabel.frame.origin.y + taillabel.frame.size.height +  10, symbolDetailView.frame.size.width, 20)] autorelease];
        copyLable.textAlignment =  UITextAlignmentCenter;
        copyLable.textColor = [UIColor darkGrayColor];
        [symbolDetailView addSubview:copyLable];
        copyLable.tag = 1002;
        copyLable.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
        copyLable.font = [UIFont systemFontOfSize:20];
        copyLable.text = NSLocalizedString(@"Copied", nil);
        taillabel.backgroundColor = [UIColor clearColor];
//        
        UILabel *unicodeLable = [[[UILabel alloc] initWithFrame:CGRectMake(0, copyLable.frame.origin.y + copyLable.frame.size.height + 10, symbolDetailView.frame.size.width, 25)] autorelease];
        unicodeLable.textAlignment =  UITextAlignmentCenter;
        unicodeLable.textColor = [UIColor darkGrayColor];
        unicodeLable.text = label.text;
        [symbolDetailView addSubview:unicodeLable];
        unicodeLable.tag = 1003;
        unicodeLable.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
        unicodeLable.font = [UIFont systemFontOfSize:20];
        taillabel.backgroundColor = [UIColor clearColor];
    }
    [self.view addSubview:symbolDetailView];
    UILabel *detail = (UILabel *)[symbolDetailView viewWithTag:1001];
    detail.text = label.text;
    UILabel *unicodeLable = (UILabel *)[symbolDetailView viewWithTag:1003];
    NSString *unicode = nil;

    NSData *data = [label.text dataUsingEncoding:NSUTF16LittleEndianStringEncoding];
    int nLen = [data length];
    if (nLen == 2)
    {
        NSRange range;
        range.location = 0;
        range.length = 2;
        char buffer[2];
        [data getBytes:buffer range:range];
        ushort hexValue = *(ushort *)buffer;
        NSString *hexStr = [NSString stringWithFormat:@"%04x", hexValue];
        unicode = [NSString stringWithFormat:@"U+%@", hexStr];

    }
    else if (nLen == 4)
    {
        NSRange range;
        range.location = 0;
        range.length = 2;
        char buffer[2];
        [data getBytes:buffer range:range];
        ushort high = *(ushort *)buffer;
        
        NSRange range2;
        range2.location = 2;
        range2.length = 2;
        char buffer2[2];
        [data getBytes:buffer2 range:range2];
        ushort low = *(ushort *)buffer2;
        
        UTF32Char u32 = CFStringGetLongCharacterForSurrogatePair(high, low);
        unicode = [NSString stringWithFormat:@"U+%lx", u32];
    }

    unicodeLable.text = unicode;
    UIPasteboard *board = [UIPasteboard generalPasteboard];
    board.string = label.text;
    
    symbolDetailView.alpha = 1.0;
    [self performSelector:@selector(removeSymbolDetailView) withObject:nil afterDelay:1.3];
}

- (void)removeSymbolDetailView
{
    [symbolDetailView removeFromSuperview];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = [symbolArray count] % 8;
    NSInteger total = [symbolArray count] / 8 + (count == 0 ? 0 : 1);
    return total;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    SymbolCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        [self.cellNib instantiateWithOwner:self options:nil];
        cell = tmpCell;
        self.tmpCell = nil;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell setFontSize:28];
    NSInteger row = [indexPath row];
    NSMutableArray *array = [NSMutableArray array];
    for (int i=row*8; i<row*8+8; i++)
    {
        if (i < [symbolArray count])
        {
            [array addObject:[symbolArray objectAtIndex:i]];
        }
    }
    [cell setTitle:array withFont:(unicodeType == Emoji || unicodeType == Private_Smybol)];
        
    [cell addTaget:self selector:@selector(symbolClicked:)];
  
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor whiteColor];
}
@end
