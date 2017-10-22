//
//  BUDownloader+News.m
//  SUAI_Navigation
//
//  Created by Виктор on 30.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUDownloader+News.h"
#import "AFNetworking.h"

@implementation BUDownloader (News)

+ (void)loadNewsPageWithSuccess:(void (^) (NSData *data))success
                           fail:(void (^) (NSString *fail))fail {
    NSURL *url = [NSURL URLWithString:@"http://new.guap.ru/pubs"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFCompoundResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"text/html", nil];
    
    [manager POST:url.absoluteString
       parameters:nil
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              if (success) {
                  success(responseObject);
                  [manager invalidateSessionCancelingTasks:YES];
              }
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              if (fail) {
                  fail(error.localizedDescription);
                  [manager invalidateSessionCancelingTasks:YES];
              }
          }];
}

+ (void)loadImage:(NSString *)newsUrl
           success:(void (^) (NSData *data))success
              fail:(void (^) (NSString *fail))fail {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURL *URL = [NSURL URLWithString:newsUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request
                                                                     progress:nil
                                                                  destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[NSString stringWithFormat:@"%@%d", [response suggestedFilename], arc4random() % 100]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSData *data = [[NSData alloc] initWithContentsOfURL:filePath];
        [[NSFileManager defaultManager] removeItemAtPath:[filePath path] error:&error];
        if (success) {
            success(data);
            [manager invalidateSessionCancelingTasks:YES];
        }
    }];
    [downloadTask resume];
}

+ (void)loadNewsPage:(NSString *)newsId
             success:(void (^) (NSData *data))success
                fail:(void (^) (NSString *fail))fail {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://new.guap.ru%@", newsId]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFCompoundResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"text/html", nil];
    
    [manager POST:url.absoluteString
       parameters:nil
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              if (success) {
                  success(responseObject);
                  [manager invalidateSessionCancelingTasks:YES];
              }
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              if (fail) {
                  fail(error.localizedDescription);
                  [manager invalidateSessionCancelingTasks:YES];
              }
          }];
}

@end
