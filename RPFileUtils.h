//
//  RPFileUtils.h
//  Jogo das Palavras
//
//  Created by Ricardo Paiva on 22/05/13.
//
//

#import <Foundation/Foundation.h>

@interface RPFileUtils : NSObject

+ (NSString *) cacheDirectoryPath;
+ (NSString *)documentDirectoryPath;
+ (NSURL *) documentDirectoryPathURL;
+ (NSString *) bundlePath;
+ (NSString *) resourcePath;
+ (NSURL *) resourcePathURL;
+ (NSString *) temporaryPath;
+ (NSURL *) temporaryPathURL;
+ (BOOL) createEmptyFileAtPath:(NSString *)path;
+ (BOOL) moveFileAtPath:(NSString *)path toPath:(NSString *)newPath error:(NSError **)error;
+ (BOOL) moveFileAtPath:(NSString *)path toPath:(NSString *)newPath shouldOverwrite:(BOOL)overwrite error:(NSError **)error;
+ (BOOL) moveFileAtPathURL:(NSURL *)path toPathURL:(NSURL *)newPath error:(NSError **)error;
+ (BOOL) moveFileAtPathURL:(NSURL *)path toPathURL:(NSURL *)newPath shouldOverwrite:(BOOL)overwrite error:(NSError **)error;
+ (BOOL) removeFileAtPath:(NSString *)path;
+ (BOOL) removeFileAtPathURL:(NSURL *)path;
+ (BOOL) removeFilesAtDirectoryPath:(NSString *)path;
+ (BOOL) fileExistsAtPath:(NSString *)path;
+ (BOOL) fileExistsAtPathURL:(NSURL *)path;
+ (BOOL) directoryExistsAtPath:(NSString *)path;
+ (BOOL) createDirectoryAtPath:(NSString *)path;
+ (NSData *) contentsAtPath:(NSString *)path;
+ (NSArray *) filesWithExtension:(NSString *)extension inDirectoryPath:(NSString *)path;
+ (NSString *)pathWithDirectoryPath:(NSString *)path andFilename:(NSString *)filename;
+ (NSString *)pathFromFilePath:(NSString *)path withNewFilename:(NSString *)filename;
+ (NSString *)filenameFromPath:(NSString *)path;

+ (NSString*)encodeString:(NSString *)string;

@end
