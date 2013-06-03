//
//  SepcialDetailViewController.m
//  CustomEmoji
//
//  Created by chenshun on 13-6-2.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import "SepcialDetailViewController.h"
#import "UIColor+HexColor.h"
#import "SpecialSymbol.h"
#import "AppDelegate.h"
@interface SepcialDetailViewController ()

@end

@implementation SepcialDetailViewController
@synthesize mTableView, symbolListArray, categoryName;

- (void)dealloc
{
    [symbolListArray release];
    [mTableView release];
    [categoryName release];
    [symbolDetailView release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorFromHex:LightGray];
    self.mTableView.backgroundView = nil;
    self.mTableView.separatorColor = [UIColor colorFromHex:SeperatorColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"back_white.png"] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 40, 40)];
    button.showsTouchWhenHighlighted = YES;
    [button addTarget:self
               action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.title = categoryName;
}

- (IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor whiteColor];
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
        
        UILabel *unicodeImageLable = [[[UILabel alloc] initWithFrame:CGRectMake(5, 0, 45, cell.frame.size.height)] autorelease];
        unicodeImageLable.backgroundColor = [UIColor clearColor];
        unicodeImageLable.textAlignment = UITextAlignmentCenter;
        unicodeImageLable.font = [UIFont fontWithName:@"Apple Color Emoji" size:32];
        [cell.contentView addSubview:unicodeImageLable];
        unicodeImageLable.tag = 1001;
        
        UILabel *unicodeStrLable = [[[UILabel alloc] initWithFrame:CGRectMake(50, 5, 150, 16)] autorelease];
        unicodeStrLable.backgroundColor = [UIColor clearColor];
        unicodeStrLable.textAlignment = UITextAlignmentLeft;
        unicodeStrLable.font = [UIFont boldSystemFontOfSize:16];
        [cell.contentView addSubview:unicodeStrLable];
        unicodeStrLable.tag = 1002;
        
        UILabel *nameLable = [[[UILabel alloc] initWithFrame:CGRectMake(50, 23, 245, 15)] autorelease];
        nameLable.backgroundColor = [UIColor clearColor];
        nameLable.textAlignment = UITextAlignmentLeft;
        [cell.contentView addSubview:nameLable];
        nameLable.lineBreakMode = UILineBreakModeTailTruncation;
        nameLable.tag = 1003;
        nameLable.font = [UIFont boldSystemFontOfSize:12];
        nameLable.textColor = [UIColor darkGrayColor];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    UILabel *unicodeImageLable = (UILabel *)[cell.contentView viewWithTag:1001];
    UILabel *unicodeStrLable = (UILabel *)[cell.contentView viewWithTag:1002];
    UILabel *nameLable = (UILabel *)[cell.contentView viewWithTag:1003];
    SpecialSymbol *symbol = [symbolListArray objectAtIndex:[indexPath row]];

    unicodeImageLable.text = symbol.symbolText;
    unicodeStrLable.text = symbol.unicode;
    nameLable.text = symbol.desc;
    return cell;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    SpecialSymbol *symbol = [symbolListArray objectAtIndex:[indexPath row]];
    if (symbolDetailView == nil)
    {
        symbolDetailView = [[UIView alloc] initWithFrame:self.mTableView.frame];
        symbolDetailView.backgroundColor = [UIColor blackColor];
        symbolDetailView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.85];
        
        UILabel *taillabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, symbolDetailView.frame.size.height - 200, symbolDetailView.frame.size.width, 60)]autorelease];
        taillabel.textAlignment =  UITextAlignmentCenter;
        taillabel.textColor = [UIColor darkGrayColor];
        [symbolDetailView addSubview:taillabel];
        taillabel.tag = 1001;
        taillabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
        taillabel.font = [UIFont fontWithName:@"Apple Color Emoji" size:59];
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
        [symbolDetailView addSubview:unicodeLable];
        unicodeLable.tag = 1003;
        unicodeLable.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
        unicodeLable.font = [UIFont systemFontOfSize:20];
        taillabel.backgroundColor = [UIColor clearColor];
    }
    [self.view addSubview:symbolDetailView];
    UILabel *detail = (UILabel *)[symbolDetailView viewWithTag:1001];
    detail.text = symbol.symbolText;
    UILabel *unicodeLable = (UILabel *)[symbolDetailView viewWithTag:1003];
    unicodeLable.text = symbol.unicode;
    
    UIPasteboard *board = [UIPasteboard generalPasteboard];
    board.string = symbol.symbolText;
    
    symbolDetailView.alpha = 1.0;
    [self performSelector:@selector(removeSymbolDetailView) withObject:nil afterDelay:1.2];
}

- (void)removeSymbolDetailView
{
    [symbolDetailView removeFromSuperview];
}
@end
