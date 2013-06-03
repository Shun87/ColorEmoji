//
//  SecondViewController.m
//  FontDesigner
//
//  Created by chenshun on 13-5-5.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import "StyleViewController.h"
#import "AppDelegate.h"
#import "FontStyle.h"
#import "UIColor+HexColor.h"
#import "FamilyDetailViewController.h"

@interface StyleViewController ()

@end

@implementation StyleViewController
@synthesize mTableView;

- (void)dealloc
{
    [mTableView release];
    [styleArray release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Styles", @"style");
        self.tabBarItem.image = [UIImage imageNamed:@"style"];
    }
    return self;
}

- (FontStyle *)findStyleByName:(NSString *)style
{
    FontStyle *tmpStyle = nil;
    for (FontStyle *aStyle in styleArray)
    {
        if ([aStyle.styleTitle isEqualToString:style])
        {
            tmpStyle = aStyle;
            break;
        }
    }
    
    if (tmpStyle == nil)
    {
        tmpStyle = [[FontStyle alloc] init];
        tmpStyle.styleTitle = style;
        [styleArray addObject:tmpStyle];
        [tmpStyle release];
    }
    return tmpStyle;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	styleArray = [[NSMutableArray alloc] init];
    self.mTableView.backgroundView = nil;
    self.mTableView.backgroundColor = [UIColor colorFromHex:TableViewBKColor];
    self.mTableView.separatorColor = [UIColor colorFromHex:SeperatorColor];
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    for (int i=0; i<[app.systemFontFamily count]; i++)
    {
        NSArray *fonts = [UIFont fontNamesForFamilyName:[app.systemFontFamily objectAtIndex:i]];
        for (int j=0; j<[fonts count]; j++){
            NSString *fontName = [fonts objectAtIndex:j];
            NSArray *subArray = [fontName componentsSeparatedByString:@"-"];
            if ([subArray count] > 1)
            {
                NSString *styleName = [subArray objectAtIndex:1];
                FontStyle *style = [self findStyleByName:styleName];
                [style addFont:fontName];
            }
        }
    }
    
    [styleArray sortUsingComparator: ^NSComparisonResult(id obj1, id obj2){
        
        FontStyle *objStr1 = (FontStyle *)obj1;
        FontStyle *objStr2 = (FontStyle *)obj2;
        return [objStr1.styleTitle compare:objStr2.styleTitle];
    }];
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
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor whiteColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [styleArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    FontStyle *fontStyle = [styleArray objectAtIndex:[indexPath row]];
    
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont fontWithName:[fontStyle.fontNameArray objectAtIndex:0] size:16];
    cell.textLabel.text = fontStyle.styleTitle;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FamilyDetailViewController *detailViewController = [[FamilyDetailViewController alloc] initWithNibName:@"FamilyDetailViewController" bundle:nil];
    FontStyle *aFontStyle = [styleArray objectAtIndex:[indexPath row]];
    [detailViewController.sourceArray addObjectsFromArray:aFontStyle.fontNameArray];
    detailViewController.familyName = aFontStyle.styleTitle;
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}

@end
