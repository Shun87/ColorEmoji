//
//  FontPreviewController.h
//  FontDesigner
//
//  Created by chenshun on 13-5-6.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FontPreviewController : UIViewController
{
    UITextView *textView1;
    CGRect oldRect;
    NSString *fontName;
}
@property (nonatomic, copy)NSString *fontName;
@property (nonatomic, retain)IBOutlet UITextView *textView1;
@end
