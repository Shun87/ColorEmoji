//
//  FontPreviewController.h
//  FontDesigner
//
//  Created by chenshun on 13-5-6.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SymbolView.h"
#import "TTSocial.h"

@interface FontPreviewController : UIViewController<SymbolViewDelegate, UIActionSheetDelegate, UITextViewDelegate>
{
    UITextView *textView1;
    CGRect oldRect;
    NSString *fontName;
    UIToolbar *toolbar;
    SymbolView *symbolKeyboard;
    SymbolView *historySymbolKeyboard;
    SymbolView *emojiSymbolKeyboard;
    UIBarButtonItem *systemKeyButton;
    UIBarButtonItem *symbolKeyButton;
    UIBarButtonItem *fontKeyButton;
    UIBarButtonItem *emojiKeyButton;
    UIBarButtonItem *deleteKeyButton;
    UIBarButtonItem *shareButton;
    UIBarButtonItem *doneButton;
    TTSocial *social;
    UISlider *aSlider;
}
@property (nonatomic, retain)IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic, retain)IBOutlet UISlider *aSlider;
@property (nonatomic, retain)IBOutlet UIBarButtonItem *fontKeyButton;
@property (nonatomic, retain)IBOutlet UIBarButtonItem *symbolKeyButton;
@property (nonatomic, retain)IBOutlet UIBarButtonItem *systemKeyButton;
@property (nonatomic, retain)IBOutlet UIBarButtonItem *emojiKeyButton;
@property (nonatomic, retain)IBOutlet UIBarButtonItem *deleteKeyButton;
@property (nonatomic, retain)SymbolView *symbolKeyboard;
@property (nonatomic, retain)SymbolView *historySymbolKeyboard;
@property (nonatomic, retain)SymbolView *emojiSymbolKeyboard;
@property (nonatomic, retain)IBOutlet UIToolbar *toolbar;
@property (nonatomic, copy)NSString *fontName;
@property (nonatomic, retain)IBOutlet UITextView *textView1;

- (IBAction)symbolKeyboard:(id)sender;
- (IBAction)systemKeyboard:(id)sender;
- (IBAction)hideKeyboard:(id)sender;
- (IBAction)changeFont:(id)sender;
- (IBAction)historySymbol:(id)sender;
- (IBAction)deleteBackwardString:(id)sender;
- (IBAction)changeFontSize:(id)sender;
@end
