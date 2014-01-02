//
//  EZZipTools.m
//  ZipArchiveDemo
//
//  Created by EZ on 13-12-12.
//  Copyright (c) 2013年 cactus. All rights reserved.
//

#import "EZZipTools.h"

@implementation EZZipTools

#pragma mark - zip
/*
+ (BOOL)createZipFile:(NSString *)zipFilePath toZipFiles:(NSString *)filesPath, ...{
    return [self createZipFile:zipFilePath toZipFiles:filesPath];
}
+ (BOOL)createZipFile:(NSString *)zipFilePath password:(NSString *)password toZipFiles:(NSString *)filesPath, ...{
    NSMutableArray  *arr = [[NSMutableArray alloc] init];
    NSString        *eachArg;
    va_list         argList;

    if (filesPath) {
        [arr addObject:filesPath];
        va_start(argList, filesPath);
        eachArg = [[NSString alloc] initWithUTF8String:va_arg(argList, const char *)];
        while (eachArg ) {
            [arr addObject:eachArg];
        }

        va_end(argList);
    }
  

    return [self createZipFile:zipFilePath password:password toZipFilesArr:[arr copy]];
}
 */

+ (BOOL)createZipFile:(NSString *)zipFilePath toZipFilesArr:(NSArray *)filesPath
{
    return [EZZipTools createZipFile:zipFilePath password:nil toZipFilesArr:filesPath];
}

+ (BOOL)createZipFile:(NSString *)zipFilePath password:(NSString *)password toZipFilesArr:(NSArray *)filesPath
{
    BOOL        isSuccess;
    ZipArchive  *zip = [[ZipArchive alloc] init];

    if (password.length > 0) {
        isSuccess = [zip CreateZipFile2:zipFilePath Password:password];
    } else {
        isSuccess = [zip CreateZipFile2:zipFilePath];
    }

    if (!isSuccess) {
        return isSuccess;
    }

    for (NSString *filePath in filesPath) {
        isSuccess = [zip addFileToZip:filePath newname:[filePath lastPathComponent]];

        if (!isSuccess) {
            return isSuccess;
        }
    }

    isSuccess = [zip CloseZipFile2];

    return isSuccess;
}

#pragma mark - unZip

+ (BOOL)unZipFile:(NSString *)zipFilePath
{
    return [EZZipTools unZipFile:zipFilePath toUnzipDirectoryPath:nil password:nil];
}

+ (BOOL)unZipFile:(NSString *)zipFilePath password:(NSString *)password
{
    return [EZZipTools unZipFile:zipFilePath toUnzipDirectoryPath:nil password:password];
}

+ (BOOL)unZipFile:(NSString *)zipFilePath toUnzipDirectoryPath:(NSString *)unzipDirectoryPath
{
    return [EZZipTools unZipFile:zipFilePath toUnzipDirectoryPath:unzipDirectoryPath password:nil];
}

+ (BOOL)unZipFile:(NSString *)zipFilePath toUnzipDirectoryPath:(NSString *)unzipDirectoryPath password:(NSString *)password
{
    BOOL        isSuccess;
    ZipArchive  *zip = [[ZipArchive alloc] init];

    if (password.length > 0) {
        isSuccess = [zip UnzipOpenFile:zipFilePath Password:password];
    } else {
        isSuccess = [zip UnzipOpenFile:zipFilePath];
    }

    if (!isSuccess) {
        return isSuccess;
    }

    if (unzipDirectoryPath.length <= 0) {
        unzipDirectoryPath = [zipFilePath substringToIndex:(zipFilePath.length - 4)];
    }

    isSuccess = [zip UnzipFileTo:unzipDirectoryPath overWrite:YES];

    return isSuccess;
}

@end