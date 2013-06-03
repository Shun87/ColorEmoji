//
//  MoreViewController.m
//  Text2Group
//
//  Created by chenshun on 13-4-12.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import "SettingViewController.h"
#import "TTSocial.h"
#import "UIColor+HexColor.h"
#import "MoreApp.h"


@interface SettingViewController ()
{
    TTSocial *socila;
}
@end

@implementation SettingViewController
@synthesize appArray;

- (void)dealloc
{
    [appArray release];
    [socila release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        self.title = NSLocalizedString(@"Settings", nil);
        self.tabBarItem.image = [UIImage imageNamed:@"Setting.png"];
        socila = [[TTSocial alloc] init];
        socila.viewController = self;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorFromHex:LightGray];
    self.tableView.backgroundView = nil;
    self.tableView.separatorColor = [UIColor colorFromHex:SeperatorColor];
   
    self.appArray = [MoreApp moreApps];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 3;
    }
    else if (section == 1)
    {
        return [appArray count] + 1;
    }
    else if (section == 2)
    {
        return 1;
    }
    
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return NSLocalizedString(@"Feedback", nil);
    }
    else if (section == 1)
    {
        return NSLocalizedString(@"More Apps", nil);
    }
    else if (section == 2)
    {
        return NSLocalizedString(@"About", nil);
    }
    
    return nil;
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
        
        
        UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(65, 4, 200, 20)] autorelease];
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
        label.backgroundColor = [UIColor clearColor];
        label.tag = 100;
        [cell.contentView addSubview:label];
        label.font = [UIFont boldSystemFontOfSize:16];

        UILabel *label2 = [[[UILabel alloc] initWithFrame:CGRectMake(65, 26, 200, 14)] autorelease];
        label2.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
        label2.backgroundColor = [UIColor clearColor];
        label2.tag = 102;
        [cell.contentView addSubview:label2];
        label2.font = [UIFont boldSystemFontOfSize:12];
        label2.textColor = [UIColor darkGrayColor];
        
        if ([indexPath section] == 1)
        {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(4, (cell.bounds.size.height - 36 ) / 2, 36, 36)];
            imageView.tag = 101;
            [cell.contentView addSubview:imageView];
            imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin;
        }
        
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
        
        rect.origin.x = (cell.contentView.frame.size.width - 200 ) / 2;
        rect.size.width = 200;
        UILabel *label5 = [[[UILabel alloc] initWithFrame:rect] autorelease];
        label5.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
        label5.backgroundColor = [UIColor clearColor];
        label5.tag = 105;
        [cell.contentView addSubview:label5];
        label5.font = [UIFont boldSystemFontOfSize:16];
        label5.textAlignment = UITextAlignmentCenter;
    }
    
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:100];
    label.text = nil;
    UILabel *label2 = (UILabel *)[cell.contentView viewWithTag:102];
    label.text = nil;
    UILabel *label3 = (UILabel *)[cell.contentView viewWithTag:104];
    label3.text = nil;
    UILabel *label5 = (UILabel *)[cell.contentView viewWithTag:105];
    label5.text = nil;
    
    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:101];
    imageView.image = nil;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    if (section == 0)
    {
        if (row == 0)
        {
            cell.textLabel.text = NSLocalizedString(@"Invite By Email", nil);
            cell.imageView.image = [UIImage imageNamed:@"email"];
        }
        else if (row == 1)
        {
            cell.textLabel.text = NSLocalizedString(@"Invite By SMS", nil);
            cell.imageView.image = [UIImage imageNamed:@"sms"];
        }
        else if (row == 2)
        {
            cell.textLabel.text = NSLocalizedString(@"Send feekback", nil);
            cell.imageView.image = [UIImage imageNamed:@"feedback"];
        }
        else{
            cell.textLabel.text = NSLocalizedString(@"Rate us", nil);
            cell.imageView.image = [UIImage imageNamed:@"like"];
        }
    }
    else if (section == 1)
    {
        if ([indexPath row] < [appArray count])
        {
            AppDesc *app = [appArray objectAtIndex:[indexPath row]];
            imageView.image = app.icon;
            label.text = app.name;
            label2.text = app.description;
        }
        else
        {
            label5.text = NSLocalizedString(@"View more", nil);
        }
    }
    else if (section == 2)
    {
        cell.textLabel.text = NSLocalizedString(@"Version", nil);
        label3.text = @"1.0";
    }

    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    if (section == 0)
    {
        if (row == 0)
        {
            [socila sendEmail:NSLocalizedString(@"ColorEmoji", nil) body:NSLocalizedString(@"invite", nil) recipient:nil];
        }
        else if (row == 1)
        {
            [socila showSMSPicker:NSLocalizedString(@"invite", nil) phones:nil];
        }
        else if (row == 2)
        {
            [socila sendFeedback:NSLocalizedString(@"ColorEmoji", nil) body:nil];
        }
        else
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms://itunes.apple.com/us/app/font-design-pro-custom-font/id648963730?mt=8"]];
        }
    }
    else if (section == 1)
    {
        if (row < [appArray count])
        {
            AppDesc *app = [appArray objectAtIndex:row];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:app.url]];
        }
        else
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms://itunes.apple.com/us/artist/chen-shun/id623735008"]];
        }
    }
}
@end
