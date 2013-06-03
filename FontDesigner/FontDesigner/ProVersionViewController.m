//
//  ProVersionViewController.m
//  FontDesigner
//
//  Created by chenshun on 13-5-11.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import "ProVersionViewController.h"
#import "UIColor+HexColor.h"

@interface ProVersionViewController ()

@end

@implementation ProVersionViewController
@synthesize button;
@synthesize lable;
- (void)dealloc
{
    [lable release];
    [button release];
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
    self.view.backgroundColor = [UIColor colorFromHex:TableViewBKColor];
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setImage:[UIImage imageNamed:@"back_white.png"] forState:UIControlStateNormal];
    [leftButton setFrame:CGRectMake(0, 0, 40, 40)];
    leftButton.showsTouchWhenHighlighted = YES;
    [leftButton addTarget:self
               action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    [leftItem release];
    [button setTitleColor:[UIColor colorFromHex:0x57595b] forState:UIControlStateNormal];
    [lable setTextColor:[UIColor colorFromHex:0x57595b]];
    lable.text = NSLocalizedString(@"pro", nil);
    [button setTitle:NSLocalizedString(@"learn more", nil) forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"Learn.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"Learn_s.png"] forState:UIControlStateHighlighted];
    [button addTarget:self
               action:@selector(proversion:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.title = NSLocalizedString(@"pro", nil);
}

- (IBAction)proversion:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms://itunes.apple.com/us/app/font-design-pro-custom-font/id645489866?mt=8"]];
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

@end
