//
//  SymbolListViewController.m
//  FontDesigner
//
//  Created by chenshun on 13-5-23.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import "SymbolListViewController.h"
#import "UIColor+HexColor.h"
#import "SymbolDesc.h"
#import "SymbolsViewController.h"
#import "AppDelegate.h"

@interface SymbolListViewController ()

@end

@implementation SymbolListViewController

@synthesize symbolListArray, mTableView;
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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorFromHex:LightGray];
    self.mTableView.backgroundView = nil;
    self.mTableView.separatorColor = [UIColor colorFromHex:SeperatorColor];
//        
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Symbols.plist" ofType:nil];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    for (int i=0; i<[[dic allKeys] count]; i++)
    {
        NSString *key = [[dic allKeys] objectAtIndex:i];
        NSDictionary *symbolDic = [dic objectForKey:key];
        NSString *min = [symbolDic objectForKey:@"from"];
        NSString *max = [symbolDic objectForKey:@"to"];
        SymbolDesc *symbol = [[SymbolDesc alloc] initWithName:key minHex:min maxHex:max];
        [symbolListArray addObject:symbol];
    }
    
    [symbolListArray sortUsingComparator: ^NSComparisonResult(id obj1, id obj2){
        
        SymbolDesc *objStr1 = (SymbolDesc *)obj1;
        SymbolDesc *objStr2 = (SymbolDesc *)obj2;
        return [objStr1.minUnicode compare:objStr2.minUnicode];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (IBAction)emojSymbols:(id)sender
{
    SymbolsViewController *detailViewController = [[SymbolsViewController alloc] initWithNibName:@"SymbolsViewController" bundle:nil];
    detailViewController.unicodeType = Emoji;
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if ([symbolListArray count] > [indexPath row])
    {
        SymbolDesc *desc = [symbolListArray objectAtIndex:[indexPath row]];
        cell.textLabel.text = desc.symbolName;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@~%@", desc.minUnicode, desc.maxUnicode];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor whiteColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SymbolsViewController *detailViewController = [[SymbolsViewController alloc] initWithNibName:@"SymbolsViewController" bundle:nil];
    detailViewController.symbolDesc = [symbolListArray objectAtIndex:[indexPath row]];
    detailViewController.unicodeType = Symbol;
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}
@end
