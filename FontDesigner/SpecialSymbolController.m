//
//  SpecialSymbolController.m
//  CustomEmoji
//
//  Created by chenshun on 13-6-2.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import "SpecialSymbolController.h"
#import "UIColor+HexColor.h"
#import "SymbolCategory.h"
#import "SpecialSymbol.h"
#import "SepcialDetailViewController.h"
#import "AppDelegate.h"

@interface SpecialSymbolController ()

@end

@implementation SpecialSymbolController
@synthesize mTableView, symbolListArray;

- (void)dealloc
{
    [symbolListArray release];
    [mTableView release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        symbolListArray = [[NSMutableArray alloc] init];
        self.tabBarItem.image = [UIImage imageNamed:@"style.png"];
        self.title = NSLocalizedString(@"group", nil);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorFromHex:LightGray];
    self.mTableView.backgroundView = nil;
    self.mTableView.separatorColor = [UIColor colorFromHex:SeperatorColor];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Specialsss.plist" ofType:nil];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    for (int i=0; i<[[dic allKeys] count]; i++)
    {
        NSString *key = [[dic allKeys] objectAtIndex:i];
        SymbolCategory *category = [[SymbolCategory alloc] init];
        category.categoryName = key;
        NSMutableDictionary *arrayDic = [dic objectForKey:key];
        for (int j=0; j<[[arrayDic allKeys] count]; j++)
        {
            NSString *key = [[arrayDic allKeys] objectAtIndex:j];
            NSString *value = [arrayDic objectForKey:key];
            uint hexValue = (uint)strtol([key UTF8String], 0, 16);
            NSString *symbolStr = nil;
            if (hexValue >= 0x10000)
            {
                UniChar c[2];
                CFStringGetSurrogatePairForLongCharacter(hexValue, c);
                symbolStr = [[NSString alloc] initWithCharacters:c length:2];
                
//                UniChar c[2];
//                CFStringGetSurrogatePairForLongCharacter(0x0001F345, c);
//                NSLog(@"%4x --- %4x", c[0], c[1]);
//                UTF32Char u32 = CFStringGetLongCharacterForSurrogatePair(c[0], c[1]);
//                NSLog(@"%08x", u32);
            }
            else
            {
                NSData *data = [NSData dataWithBytes:&hexValue length:sizeof(uint)];
                symbolStr = [[NSString alloc] initWithData:data
                                                            encoding:NSUTF16LittleEndianStringEncoding];
            }


            
            NSString *unicode = [NSString stringWithFormat:@"U+%@", key];
            SpecialSymbol *specialSymbol = [[SpecialSymbol alloc] initWithText:symbolStr unicode:unicode desc:value];
            [category.symbolArray addObject:specialSymbol];
        }
        
        [symbolListArray addObject:category];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [symbolListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        CGRect rect = cell.frame;
        rect.origin.x = cell.contentView.frame.size.width - 40;
        rect.size.width = 40;
        UILabel *label3 = [[[UILabel alloc] initWithFrame:rect] autorelease];
        label3.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
        label3.backgroundColor = [UIColor clearColor];
        label3.tag = 104;
        [cell.contentView addSubview:label3];
        label3.font = [UIFont systemFontOfSize:17];
        label3.textColor = [UIColor colorFromHex:0x074765];
        label3.textAlignment = UITextAlignmentCenter;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    SymbolCategory *category = [symbolListArray objectAtIndex:[indexPath row]];
    cell.textLabel.text = category.categoryName;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    UILabel *label3 = (UILabel *)[cell.contentView viewWithTag:104];
    label3.text = [NSString stringWithFormat:@"%d", [category.symbolArray count]];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor whiteColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SepcialDetailViewController *detailViewController = [[SepcialDetailViewController alloc] initWithNibName:@"SepcialDetailViewController" bundle:nil];
//    detailViewController.symbolDesc = [symbolListArray objectAtIndex:[indexPath row]];
    SymbolCategory *category = [symbolListArray objectAtIndex:[indexPath row]];
    detailViewController.symbolListArray = category.symbolArray;
    detailViewController.categoryName = category.categoryName;
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}
@end
