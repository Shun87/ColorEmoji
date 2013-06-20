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
#import "FontViewController.h"
@interface FontPreviewController ()

@end

@implementation FontPreviewController
@synthesize textView1;
@synthesize fontName, toolbar, symbolKeyboard, systemKeyButton, symbolKeyButton, fontKeyButton;
@synthesize aSlider;
@synthesize historySymbolKeyboard, emojiKeyButton, emojiSymbolKeyboard, deleteKeyButton, doneButton;

- (void)dealloc
{
    [aSlider release];
    [textView1 release];
    [fontName release];
    [toolbar release];
    [systemKeyButton release];
    [symbolKeyButton release];
    [fontKeyButton release];
    [emojiKeyButton release];
    [emojiSymbolKeyboard release];
    [symbolKeyboard release];
    [historySymbolKeyboard release];
    [social release];
    [deleteKeyButton release];
    [shareButton release];
    [doneButton release];
    [super dealloc];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Text", @"Text");
        self.tabBarItem.image = [UIImage imageNamed:@"Language.png"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    systemKeyButton.title = @"\u2328";
    symbolKeyButton.title = @"\u25d1";
    fontKeyButton.title = @"\u270e";
    emojiKeyButton.title = @"\u263b";
    deleteKeyButton.title = @"\u232b";
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:23] forKey:UITextAttributeFont];
    [symbolKeyButton setTitleTextAttributes:dic forState:UIControlStateNormal];
    [systemKeyButton setTitleTextAttributes:dic forState:UIControlStateNormal];
    [fontKeyButton setTitleTextAttributes:dic forState:UIControlStateNormal];
    [emojiKeyButton setTitleTextAttributes:dic forState:UIControlStateNormal];
    [deleteKeyButton setTitleTextAttributes:dic forState:UIControlStateNormal];
    
    textView1.layer.cornerRadius = 8;
    textView1.layer.masksToBounds = YES;
    textView1.delegate = self;
    self.view.backgroundColor = [UIColor colorFromHex:TableViewBKColor];
    textView1.backgroundColor = [UIColor whiteColor];
    textView1.font = [UIFont systemFontOfSize:18];
    aSlider.value = 18;
    
    [self.toolbar setBarStyle:UIBarStyleBlack];
    
    shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareAction:)];
    UIBarButtonItem *clearButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(clearAction:)];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:doneButton, shareButton, nil];
    self.navigationItem.leftBarButtonItem = clearButton;
    [clearButton release];
    
    social = [[TTSocial alloc] init];
    social.viewController = self;

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadFont:)
                                                 name:@"changeFont"
                                               object:nil];
    
    
    self.symbolKeyboard = [[[SymbolView alloc] init] autorelease];
    self.symbolKeyboard.delegate = self;
    [self.symbolKeyboard setSymbolShowType:ST_Symbol];
    textView1.inputAccessoryView = toolbar;
    
    self.historySymbolKeyboard = [[[SymbolView alloc] init] autorelease];
    [self.historySymbolKeyboard setSymbolShowType:ST_History];
    self.historySymbolKeyboard.delegate = self;
    
    self.emojiSymbolKeyboard = [[[SymbolView alloc] init] autorelease];
    [self.emojiSymbolKeyboard setSymbolShowType:ST_Emoji];
    self.emojiSymbolKeyboard.delegate = self;
    
    textView1.inputView = self.symbolKeyboard;
    [self performSelector:@selector(beganEding) withObject:nil afterDelay:0.35];
}


- (void)reloadFont:(NSNotification *)notificaiton
{
    self.fontName = (NSString *)[notificaiton object];
    textView1.font = [UIFont fontWithName:self.fontName size:aSlider.value];
}

- (IBAction)shareAction:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                              delegate:self
                                     cancelButtonTitle:NSLocalizedString(@"Cancel", nil)
                                destructiveButtonTitle:nil
                                     otherButtonTitles:NSLocalizedString(@"SMS", nil),
                                  NSLocalizedString(@"Email", nil),
                                  NSLocalizedString(@"Facebook", nil),
                                  NSLocalizedString(@"Twitter", nil),
                                  NSLocalizedString(@"Copy", nil),
                                 NSLocalizedString(@"Clear history", nil),
                                  nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    actionSheet.delegate = self;
	[actionSheet showFromTabBar:self.tabBarController.tabBar];
    [actionSheet release];
}

- (IBAction)clearAction:(id)sender
{
     textView1.text = nil;
}

- (IBAction)showProVersion:(id)sender
{
    textView1.text = nil;
//    ProVersionViewController*proViewController = [[ProVersionViewController alloc] initWithNibName:@"ProVersionViewController" bundle:nil];
//    [self.navigationController pushViewController:proViewController animated:YES];
//    [proViewController release];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    oldRect = textView1.frame;
    
#if FreeApp    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (app.adBanner.superview != nil)
    {
        [app.adBanner removeFromSuperview];
    }
    
    CGRect rect = app.adBanner.frame;
    rect.origin.y = 0;
    app.adBanner.frame = rect;
    app.adBanner.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:app.adBanner];
    
    
#endif

}

- (void)beganEding
{
    [textView1 becomeFirstResponder];
}

- (IBAction)symbolKeyboard:(id)sender
{
    textView1.inputView = self.symbolKeyboard;
    [textView1 reloadInputViews];
}

- (IBAction)systemKeyboard:(id)sender
{
    textView1.inputView = nil;
    [textView1 reloadInputViews];
}

- (IBAction)historyKeyboard:(id)sender
{
    [self.historySymbolKeyboard setSymbolShowType:ST_History];
    textView1.inputView = self.historySymbolKeyboard;
    [textView1 reloadInputViews];
}

- (IBAction)emojiKeyboard:(id)sender
{
    textView1.inputView = self.emojiSymbolKeyboard;
    [textView1 reloadInputViews];
}

- (IBAction)hideKeyboard:(id)sender
{
    [textView1 resignFirstResponder];
}


- (IBAction)deleteBackwardString:(id)sender
{
    [textView1 deleteBackward];
}


- (IBAction)changeFont:(id)sender
{
    FontViewController *viewController1 = [[[FontViewController alloc] initWithNibName:@"FontViewController" bundle:nil] autorelease];
    [self.navigationController pushViewController:viewController1 animated:YES];
}

- (IBAction)changeFontSize:(id)sender
{
    UISlider *slider = (UISlider *)sender;
    if (self.fontName != nil)
    {
        textView1.font = [UIFont fontWithName:self.fontName size:slider.value];
    }
    else
    {
        textView1.font = [UIFont systemFontOfSize:slider.value];
    }
}

- (IBAction)hideKey:(id)sender
{
    [textView1 resignFirstResponder];
}

- (IBAction)historySymbol:(id)sender
{
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [social showSMSPicker:textView1.text phones:nil];
    }
    else if (buttonIndex == 1)
    {
        [social showMailPicker:textView1.text to:nil cc:nil bcc:nil images:nil];
    }
    else if (buttonIndex == 2)
    {
        [textView1 resignFirstResponder];
        [social showFaceBook:textView1.text];
        
    }
    else if (buttonIndex == 3)
    {
        [textView1 resignFirstResponder];
        [social showTwitter:textView1.text];
    }
    else if (buttonIndex == 4)
    {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = textView1.text;
    }
    else if (buttonIndex == 5)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"History.plist"];
        BOOL exist = [[NSFileManager defaultManager] fileExistsAtPath:path];
        if (exist)
        {
            [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        }
        
        [self.historySymbolKeyboard setSymbolShowType:ST_History];
    }
}

- (void)keyboardWillShow:(NSNotification *)aNotification
{
    NSTimeInterval animationDuration =
    [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardRect = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect convRect = [window convertRect:keyboardRect toView:self.view];

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

- (IBAction)goBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)selectSymbol:(NSString *)text
{
    NSString *filledText = textView1.text;
    textView1.text = [filledText stringByAppendingFormat:@"%@", text];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
