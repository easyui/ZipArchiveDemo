//
//  EZViewController.m
//  ZipArchiveDemo
//
//  Created by EZ on 13-12-4.
//  Copyright (c) 2013年 cactus. All rights reserved.
//

#import "EZViewController.h"
#import "EZZipTools.h"
@interface EZViewController ()

@end

@implementation EZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)zipAction:(id)sender
{
    [EZZipTools createZipFile:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"你好.zip"] toZipFilesArr:@[[[NSBundle mainBundle]pathForResource:@"Default" ofType:@"png"], [[NSBundle mainBundle]pathForResource:@"Default-568h@2x" ofType:@"png"]]];
    //        [EZZipTools createZipFile:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"eee.zip"] password:nil toZipFiles:[[NSBundle mainBundle]pathForResource:@"Default" ofType:@"png"],[[NSBundle mainBundle]pathForResource:@"Default@2x" ofType:@"png"],[[NSBundle mainBundle]pathForResource:@"Default-568h@2x" ofType:@"png"]];
}

- (IBAction)unZipAction:(id)sender
{
    //    [EZZipTools unZipFile:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"你好.zip"]];
    [EZZipTools unZipFile:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"归档.zip"] toUnzipDirectoryPath:NSTemporaryDirectory() password:nil];
}

- (IBAction)saveToDocument:(id)sender
{
    NSString    *filePath = [[NSBundle mainBundle] pathForResource:@"Localizable.zip" ofType:nil];
    NSData      *zipData = [[NSData alloc] initWithContentsOfFile:filePath];
    NSArray     *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString    *ourDocumentPath = [documentPaths objectAtIndex:0];
    NSString    *localizablePath = [ourDocumentPath stringByAppendingPathComponent:@"Localizable.zip"];

    [zipData writeToFile:localizablePath atomically:YES];
}

- (IBAction)unzipLocal:(id)sender
{
    NSArray         *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString        *ourDocumentPath = [documentPaths objectAtIndex:0];
    NSString        *localizablePath = [ourDocumentPath stringByAppendingPathComponent:@"Localizable"];
    NSFileManager   *manager = [NSFileManager defaultManager];

    if (![manager contentsOfDirectoryAtPath:localizablePath error:nil]) {
        [manager createDirectoryAtPath:localizablePath withIntermediateDirectories:NO attributes:nil error:nil];
    }

    [EZZipTools unZipFile:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"Localizable.zip"] toUnzipDirectoryPath:localizablePath password:nil];
}

- (IBAction)resolveLocal:(id)sender
{
    NSArray         *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString        *ourDocumentPath = [documentPaths objectAtIndex:0];
    NSString        *localizablePath = [ourDocumentPath stringByAppendingPathComponent:@"Localizable/Localizable_en.string"];
    NSDictionary    *dic = [self LocalKeyValueForStringsAtPath:localizablePath];

    NSLog(@"%@", dic);
    NSLog(@"结束");
    [NSString stringWithFormat:@"Localizable/%@", @"ss"];
}

- (NSDictionary *)LocalKeyValueForStringsAtPath:(NSString *)path
{
    if (!path) {
        return nil;
    }

    NSStringEncoding    encoding;
    NSError             *error;
    NSString            *stringsString = [NSString stringWithContentsOfFile:path usedEncoding:&encoding error:&error];

    if (!stringsString || (stringsString.length == 0)) {
        return nil;
    }

    NSRegularExpression *regEx = [NSRegularExpression regularExpressionWithPattern:@"[^/\\\\[ ]*]\"([ ]*[a-zA-Z0-9._]*[ ]*)\"[ ]*=[ ]*\"([ ]*.+?[ ]*)\"[ ]*;" options:NSRegularExpressionAnchorsMatchLines error:&error];
    NSArray             *matches = [regEx matchesInString:stringsString options:NSMatchingReportCompletion range:NSMakeRange(0, stringsString.length)];

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:matches.count];
    [matches enumerateObjectsUsingBlock:^(NSTextCheckingResult *match, NSUInteger idx, BOOL *stop) {
        NSString *key = [stringsString substringWithRange:[match rangeAtIndex:1]];
        NSString *value = [stringsString substringWithRange:[match rangeAtIndex:2]];
        //        if ([dic objectForKey:key]) {
        //            NSLog(@"_____%@",key);
        //        }else{
        [dic setObject:value forKey:key];
        //        }
    }];
    return (NSDictionary *)dic;
}

- (NSDictionary *)LocalKeyValueForStringsAtURL:(NSURL *)stringsURL
{
    if (!stringsURL) {
        return nil;
    }

    NSStringEncoding    encoding;
    NSError             *error;
    NSString            *stringsString = [NSString stringWithContentsOfURL:stringsURL usedEncoding:&encoding error:&error];

    if (!stringsString || (stringsString.length == 0)) {
        return nil;
    }

    NSRegularExpression *regEx = [NSRegularExpression regularExpressionWithPattern:@"[^/\\\\[ ]*]\"([ ]*[a-zA-Z0-9._]*[ ]*)\"[ ]*=[ ]*\"([ ]*.+?[ ]*)\"[ ]*;" options:NSRegularExpressionAnchorsMatchLines error:&error];
    NSArray             *matches = [regEx matchesInString:stringsString options:NSMatchingReportCompletion range:NSMakeRange(0, stringsString.length)];

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:matches.count];
    [matches enumerateObjectsUsingBlock:^(NSTextCheckingResult *match, NSUInteger idx, BOOL *stop) {
        NSString *key = [stringsString substringWithRange:[match rangeAtIndex:1]];
        NSString *value = [stringsString substringWithRange:[match rangeAtIndex:2]];
        [dic setObject:value forKey:key];
    }];
    return (NSDictionary *)dic;
}

@end