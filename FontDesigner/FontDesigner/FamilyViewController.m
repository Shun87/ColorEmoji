//
//  FirstViewController.m
//  FontDesigner
//
//  Created by chenshun on 13-5-5.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import "FamilyViewController.h"
#import "FamilyDetailViewController.h"
#import <CoreText/CoreText.h>
#import "AppDelegate.h"
#import "Font.h"

@interface FamilyViewController ()

@end

@implementation FamilyViewController
@synthesize mTableView;
@synthesize type;
@synthesize fontArray;

static NSString *transformString(NSString *sourceString) {
    NSMutableString *source = [sourceString mutableCopy];
    CFStringTransform(( CFMutableStringRef)source, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform(( CFMutableStringRef)source, NULL, kCFStringTransformStripDiacritics, NO);
    return [source autorelease];
}

- (void)dealloc
{
    [fontArray release];
    [mTableView release];

    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
   
    fontArray = [[NSMutableArray alloc] init];
    if (type == Custom)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"refresh.png"] forState:UIControlStateNormal];
        [button setFrame:CGRectMake(0, 0, 40, 40)];
        button.showsTouchWhenHighlighted = YES;
        [button addTarget:self
                   action:@selector(reloadFonts) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.rightBarButtonItem = leftItem;
    }
    
    [self reloadFonts];
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

- (void)loadLocalFont
{
    NSString *documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory,
                                                                            NSUserDomainMask, YES ) objectAtIndex:0];
    NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectoryPath error:nil];
    for (int i=0; i<[array count]; i++)
    {
        NSString *filePath = [documentsDirectoryPath stringByAppendingPathComponent:[array objectAtIndex:i]];
        CGDataProviderRef provider = CGDataProviderCreateWithFilename([filePath UTF8String]);
        
        CFErrorRef error = nil;
        CGFontRef font = CGFontCreateWithDataProvider(provider);
        if (! CTFontManagerRegisterGraphicsFont(font, &error)) {
            CFStringRef errorDescription = CFErrorCopyDescription(error);
            NSLog(@"Failed to load font: %@", errorDescription);
            CFRelease(errorDescription);
        }
        
        CFRelease(font);
        CFRelease(provider);
    }
}

- (void)reloadFonts
{
    [fontArray removeAllObjects];
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSMutableArray *tempArray = [NSMutableArray array];
    if (type == Custom)
    {
        NSString *fontPath = [[NSBundle mainBundle] pathForResource:@"手写体.ttf" ofType:nil];
        CGDataProviderRef provider = CGDataProviderCreateWithFilename([fontPath UTF8String]);
        
        CFErrorRef error = nil;
        CGFontRef font = CGFontCreateWithDataProvider(provider);
        if (! CTFontManagerRegisterGraphicsFont(font, &error)) {
            CFStringRef errorDescription = CFErrorCopyDescription(error);
            NSLog(@"Failed to load font: %@", errorDescription);
            CFRelease(errorDescription);
        }
        
        CFRelease(font);
        CFRelease(provider);
        
        [self loadLocalFont];
        
        // 找出自定义字体
        NSArray *allFonts = [UIFont familyNames];
        for (NSString *family in allFonts)
        {
            if (![app.systemFontFamily containsObject:family])
            {
                [tempArray addObject:family];
            }
        }
    }
    else
    {
        [tempArray addObjectsFromArray:app.systemFontFamily];
    }
    
    for (int i=0; i<[tempArray count]; i++)
    {
        NSString *name = [tempArray objectAtIndex:i];
        name = transformString(name);
        NSRange range;
        range.location = 0;
        range.length = 1;
        NSString *preCharactor = [name substringWithRange:range];
        Font *font = nil;
        
        for (Font *aFont in fontArray)
        {
            if ([aFont.sectionTitle isEqualToString:preCharactor])
            {
                font = aFont;
                break;
            }
        }
        
        if (font == nil)
        {
            font = [[Font alloc] init];
            font.sectionTitle = preCharactor;
            [fontArray addObject:font];
            [font release];
        }
        
        [font.fontFamilyArray addObject:name];
    }
    
    for (Font *aFont in fontArray)
    {
        [aFont sortFamilies];
    }
    
    [self.mTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [fontArray count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 25)];
    UIImage *image = [UIImage imageNamed:@"sectionBk"];
    imageView.image = image;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 25, 22)];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = UITextAlignmentCenter;
    [imageView addSubview:label];

    Font *font = [fontArray objectAtIndex:section];
    label.text = font.sectionTitle;
    label.textColor = [UIColor darkGrayColor];
    return imageView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Font *font = [fontArray objectAtIndex:section];
    return [font.fontFamilyArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];

    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    Font *font = [fontArray objectAtIndex:[indexPath section]];
    NSString *familyName = [font.fontFamilyArray objectAtIndex:[indexPath row]];
    NSString *fontName = [[UIFont fontNamesForFamilyName:familyName] objectAtIndex:0];

    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont fontWithName:fontName size:16];
    cell.textLabel.text = familyName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FamilyDetailViewController *detailViewController = [[FamilyDetailViewController alloc] initWithNibName:@"FamilyDetailViewController" bundle:nil];
    Font *font = [fontArray objectAtIndex:[indexPath section]];
    
    detailViewController.familyName = [font.fontFamilyArray objectAtIndex:[indexPath row]];
    [detailViewController.sourceArray addObjectsFromArray:[UIFont fontNamesForFamilyName:detailViewController.familyName]];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}

@end
