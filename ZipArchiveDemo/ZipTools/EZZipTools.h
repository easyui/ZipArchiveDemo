//
//  EZZipTools.h
//  ZipArchiveDemo
//
//  Created by EZ on 13-12-12.
//  Copyright (c) 2013年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZipArchive.h"
@interface EZZipTools : NSObject
/*
+(BOOL)createZipFile:(NSString *) zipFilePath toZipFiles:(NSString *)filesPath,...;
+(BOOL)createZipFile:(NSString *) zipFilePath password:(NSString*) password toZipFiles:(NSString *)filesPath,...;
*/
+(BOOL)createZipFile:(NSString *) zipFilePath toZipFilesArr:(NSArray *)filesPath;
+(BOOL)createZipFile:(NSString *) zipFilePath password:(NSString*) password toZipFilesArr:(NSArray *)filesPath;

//todo 多平台的压缩包解压有点问题
+(BOOL)unZipFile:(NSString *) zipFilePath ;
+(BOOL)unZipFile:(NSString *) zipFilePath password:(NSString*) password ;
+(BOOL)unZipFile:(NSString *) zipFilePath toUnzipDirectoryPath:(NSString *) unzipDirectoryPath   ;
+(BOOL)unZipFile:(NSString *) zipFilePath toUnzipDirectoryPath:(NSString *) unzipDirectoryPath  password:(NSString*) password ;
@end
