//
//  FamilyDetailViewController.m
//  FontDesigner
//
//  Created by chenshun on 13-5-5.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import "FamilyDetailViewController.h"
#import "UIColor+HexColor.h"
#import "FontPreviewController.h"
#import "AppDelegate.h"

@interface FamilyDetailViewController ()

@end

@implementation FamilyDetailViewController
@synthesize mTableView, familyName, sourceArray;
- (void)dealloc
{
    [mTableView release];
    [sourceArray release];
    [familyName release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        sourceArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.mTableView.backgroundView = nil;
    self.mTableView.backgroundColor = [UIColor colorFromHex:TableViewBKColor];
    self.mTableView.separatorColor = [UIColor colorFromHex:SeperatorColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"back_white.png"] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 40, 40)];
    button.showsTouchWhenHighlighted = YES;
    [button addTarget:self
               action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.navigationItem.title = familyName;
}

- (IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [sourceArray sortUsingComparator: ^NSComparisonResult(id obj1, id obj2){
        
        NSString *objStr1 = (NSString *)obj1;
        NSString *objStr2 = (NSString *)obj2;
        return [objStr1 compare:objStr2];
    }];
    
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [sourceArray count];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor whiteColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSString *fontName = [sourceArray objectAtIndex:[indexPath row]];
    
    cell.textLabel.font = [UIFont fontWithName:fontName size:16];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = [sourceArray objectAtIndex:[indexPath row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FontPreviewController *fontPreviewController = [[FontPreviewController alloc] initWithNibName:@"FontPreviewController" bundle:nil];
    fontPreviewController.fontName = [sourceArray objectAtIndex:[indexPath row]];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:fontPreviewController];
    
    [self presentViewController:navigationController animated:YES completion:nil];
}

@end
