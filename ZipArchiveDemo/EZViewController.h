//
//  EZViewController.h
//  ZipArchiveDemo
//
//  Created by EZ on 13-12-4.
//  Copyright (c) 2013年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EZViewController : UIViewController
- (IBAction)zipAction:(id)sender;

- (IBAction)unZipAction:(id)sender;

- (IBAction)saveToDocument:(id)sender;
- (IBAction)unzipLocal:(id)sender;
- (IBAction)resolveLocal:(id)sender;
@end
