//
//  FontViewController.m
//  TextFont
//
//  Created by chenshun on 13-6-15.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import "FontViewController.h"
#import "UIColor+HexColor.h"

@interface FontViewController ()

@end

@implementation FontViewController
@synthesize mTableView, sourceArray, language;
- (void)dealloc
{
    [mTableView release];
    [sourceArray release];
    [language release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        sourceArray = [[NSMutableArray alloc] init];
        [sourceArray addObjectsFromArray:[UIFont familyNames]];
        self.navigationItem.title = NSLocalizedString(@"Text", nil);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorFromHex:TableViewBKColor];
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
    self.navigationItem.title = language;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sourceArray count];;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
     NSString *family = [sourceArray objectAtIndex:section];
    return family;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *family = [sourceArray objectAtIndex:section];
    return [[UIFont fontNamesForFamilyName:family] count];
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
    NSString *family = [sourceArray objectAtIndex:[indexPath section]];
    NSArray *array = [UIFont fontNamesForFamilyName:family];
    NSString *fontName = [array objectAtIndex:[indexPath row]];
    cell.textLabel.font = [UIFont fontWithName:fontName size:16];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = fontName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *family = [sourceArray objectAtIndex:[indexPath section]];
    NSArray *array = [UIFont fontNamesForFamilyName:family];
    NSString *fontName = [array objectAtIndex:[indexPath row]];
    [UIView transitionWithView:self.view
                      duration:0.65
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:nil
                    completion:^(BOOL complete){
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeFont" object:fontName];
                        UINavigationController *nav = [self.tabBarController.viewControllers objectAtIndex:0];
                        [nav popToRootViewControllerAnimated:YES];
                        [self.tabBarController setSelectedIndex:0];
                        [self.navigationController popToRootViewControllerAnimated:NO];
                        
                    }];

}

@end
