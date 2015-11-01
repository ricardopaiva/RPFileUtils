//
//  RPUtils.m
//  Jogo das Palavras
//
//  Created by Ricardo Paiva on 22/05/13.
//
//

#import "RPFileUtils.h"

@implementation RPFileUtils

+ (NSString *) cacheDirectoryPath
{
    NSArray *cachesArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDirectory = [cachesArray lastObject];
    
    return cacheDirectory;
}

+ (NSString *) documentDirectoryPath
{
    NSArray *docArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirectory = [docArray lastObject];
    
    return docDirectory;
}

+ (NSURL *)documentDirectoryPathURL
{
    return [NSURL fileURLWithPath:[self documentDirectoryPath]];
}

+ (NSString *) bundlePath
{
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    return bundlePath;
}

+ (NSString *) resourcePath
{
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    return resourcePath;
}

+ (NSURL *) resourcePathURL
{
    return [NSURL fileURLWithPath:[self resourcePath]];
}

+ (NSString *) temporaryPath
{
    NSString *tempDirectory = NSTemporaryDirectory();
    return tempDirectory;
}

+ (NSURL *) temporaryPathURL
{
    return [NSURL fileURLWithPath:[self temporaryPath]];
}

+ (BOOL) createEmptyFileAtPath:(NSString *) path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        NSError *error = nil;
        [[NSData data] writeToFile:path options:0 error:&error];
        if (error) {
            NSLog(@"Error creating file: %@", error);
            return NO;
        }
        return YES;
    }
    return NO;
}

+ (BOOL) moveFileAtPath:(NSString *)path toPath:(NSString *)newPath error:(NSError **)error
{
    return [self moveFileAtPath:path toPath:newPath shouldOverwrite:NO error:error];
}

+ (BOOL) moveFileAtPath:(NSString *)path toPath:(NSString *)newPath shouldOverwrite:(BOOL)overwrite error:(NSError **)error
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *fileError = nil;

    //If origin and destination are the same, it exits
    if ([path isEqualToString:newPath])
        return NO;

    if ([fileManager fileExistsAtPath:path]) {
        if ([fileManager fileExistsAtPath:newPath] && overwrite) {
            [self removeFileAtPath:newPath];
        }
        [fileManager moveItemAtPath:path toPath:newPath error:&fileError];
        if (!fileError) {
            return YES;
        }
    }
    return NO;
}

+ (BOOL) moveFileAtPathURL:(NSURL *)path toPathURL:(NSURL *)newPath error:(NSError **)error
{
    return [self moveFileAtPathURL:path toPathURL:newPath shouldOverwrite:NO error:error];
}

+ (BOOL) moveFileAtPathURL:(NSURL *)path toPathURL:(NSURL *)newPath shouldOverwrite:(BOOL)overwrite error:(NSError **)error
{
    return [self moveFileAtPath:[path path] toPath:[newPath path] shouldOverwrite:overwrite error:error];
}

+ (BOOL)removeFileAtPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *fileError = nil;
    [fileManager removeItemAtPath:path error:&fileError];
    if (!fileError) {
        return YES;
    }
    return NO;
}

+ (BOOL)removeFileAtPathURL:(NSURL *)path
{
    return [self removeFileAtPath:[path path]];
}

+ (BOOL)removeFilesAtDirectoryPath:(NSString *)path
{
    NSError *error = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    for (NSString *file in [fileManager contentsOfDirectoryAtPath:path error:&error]) {
        if (![fileManager removeItemAtPath:[path stringByAppendingPathComponent:file] error:&error]) {
            return NO;
        }
    }
    return YES;
}

+ (BOOL) fileExistsAtPath:(NSString *)path
{
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

+ (BOOL) fileExistsAtPathURL:(NSURL *)path
{
    return [self fileExistsAtPath:[path path]];
}

+ (BOOL) directoryExistsAtPath:(NSString *)path;
{
    BOOL isDir;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path isDirectory:&isDir] && isDir)
    {
        return YES;
    }
    return NO;
}

+ (BOOL) createDirectoryAtPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *fileError = nil;
    [fileManager createDirectoryAtPath:path
           withIntermediateDirectories:YES
                            attributes:nil
                                 error:&fileError];
    if (!fileError) {
        return YES;
    }
    return NO;
}

+ (NSData *) contentsAtPath:(NSString *)path
{
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:path];
    return data;
}

+ (NSArray *)filesWithExtension:(NSString *)extension inDirectoryPath:(NSString *)path
{
    NSArray *dirContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
//    NSPredicate *fltr = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"self ENDSWITH '.%@'", extension]];
//    NSArray *filteredFiles = [dirContents filteredArrayUsingPredicate:fltr];

    NSArray *filterTypes = [NSArray arrayWithObject:extension];
    NSArray *filteredFiles = [dirContents pathsMatchingExtensions:filterTypes];
    return filteredFiles;
}

+ (NSString *)pathWithDirectoryPath:(NSString *)path andFilename:(NSString *)filename
{
    NSString *concatenatedPath = [path stringByAppendingPathComponent:filename];
    return concatenatedPath;
}

+ (NSString *)pathFromFilePath:(NSString *)path withNewFilename:(NSString *)filename
{
    NSString *dirPath = [path stringByDeletingLastPathComponent];
    NSString *fullPath = [dirPath stringByAppendingPathComponent:filename];
    return fullPath;
}

+ (NSString *)filenameFromPath:(NSString *)path
{
    return [path lastPathComponent];
}

+ (NSString*)encodeString:(NSString *)string
{
    NSString *newString = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    if (newString)
    {
        return newString;
    }
    
    return @"";
}

@end
