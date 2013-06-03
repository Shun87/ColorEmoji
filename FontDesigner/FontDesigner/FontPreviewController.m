//
//  FontPreviewController.m
//  FontDesigner
//
//  Created by chenshun on 13-5-6.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import "FontPreviewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+HexColor.h"
#import "AppDelegate.h"
#import "ProVersionViewController.h"

@interface FontPreviewController ()

@end

@implementation FontPreviewController
@synthesize textView1;
@synthesize fontName;

- (void)dealloc
{
    [textView1 release];
    [fontName release];
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
    
    textView1.layer.cornerRadius = 8;
    textView1.layer.masksToBounds = YES;
    self.navigationItem.title = NSLocalizedString(@"Font Preview", nil);
    
    self.view.backgroundColor = [UIColor colorFromHex:TableViewBKColor];
    textView1.backgroundColor = [UIColor whiteColor];
    textView1.font = [UIFont fontWithName:fontName size:20];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 40, 40)];
    button.showsTouchWhenHighlighted = YES;
    [button addTarget:self
               action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
    [leftItem release];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 40, 40)];
    button.showsTouchWhenHighlighted = YES;
    [button addTarget:self
               action:@selector(showProVersion:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
    [rightItem release];
   

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    CGRect accesoryViewRect = CGRectMake(0, 0, 320, 30);
    UIView *accessoryView = [[UIView alloc]initWithFrame:accesoryViewRect];
    accessoryView.backgroundColor = [UIColor clearColor];
    
    CGRect buttonRect = CGRectMake(320 - 58, 0, 55, 30);
    UIButton *hideButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [hideButton setFrame:buttonRect];
    [hideButton setImage:[UIImage imageNamed:@"hideKey"] forState:UIControlStateNormal];
    [hideButton addTarget:self action:@selector(hideKey:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView addSubview:hideButton];
    textView1.inputAccessoryView = accessoryView;
    [accessoryView release];
}

- (IBAction)showProVersion:(id)sender
{
    NSData *data = [textView1.text dataUsingEncoding:NSUTF16LittleEndianStringEncoding];
    int nLen = [data length];
    for (int i=0; i<nLen; i+=2)
    {
        NSRange range;
        range.location = i;
        range.length = 2;
        char buffer[2];
        [data getBytes:buffer range:range];
        
        ushort hexValue = *(ushort *)buffer;
        NSString *hexStr = [NSString stringWithFormat:@"%04x", hexValue];
        NSString *unicode = [NSString stringWithFormat:@"U+%@", hexStr];
        NSLog(@"%@", unicode);
    }
//    ProVersionViewController*proViewController = [[ProVersionViewController alloc] initWithNibName:@"ProVersionViewController" bundle:nil];
//    [self.navigationController pushViewController:proViewController animated:YES];
//    [proViewController release];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (IBAction)hideKey:(id)sender
{
    [textView1 resignFirstResponder];
}

- (void)keyboardWillShow:(NSNotification *)aNotification
{
    NSTimeInterval animationDuration =
    [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardRect = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect convRect = [window convertRect:keyboardRect toView:self.view];
    
    oldRect = self.textView1.frame;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect textViewRect = self.textView1.frame;
    textViewRect.size.height = abs(self.textView1.frame.origin.y - convRect.origin.y);
    self.textView1.frame = textViewRect;
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)aNotification
{
    NSTimeInterval animationDuration =
    [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];

    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.textView1.frame = oldRect;
    [UIView commitAnimations];
}


- (IBAction)changeFont:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)goBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
