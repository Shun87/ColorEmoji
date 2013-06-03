//
//  SymbolsViewController.h
//  SymbolsViewController
//
//  Created by  on 13-5-23.
//  Copyright (c) 2013年 Crearo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SymbolCell.h"
#import "SymbolDesc.h"

typedef enum
{
    Symbol,
    Emoji,
    Private_Smybol
}UnicodeType;
@interface SymbolsViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *mTableView;
    UINib *cellNib;
    SymbolCell *tmpCell;
    
    NSMutableArray *symbolArray;
    
    SymbolDesc *symbolDesc;
    UnicodeType unicodeType;
    UIView *symbolDetailView;
}
@property (nonatomic)UnicodeType unicodeType;
@property (nonatomic, retain)SymbolDesc *symbolDesc;
@property (nonatomic, retain)IBOutlet SymbolCell *tmpCell;
@property (nonatomic, retain) UINib *cellNib;
@property (nonatomic, retain)IBOutlet UITableView *mTableView;
@property (nonatomic, retain)NSMutableArray *symbolArray;
@end
