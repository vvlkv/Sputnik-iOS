//
//  BUDownloader.m
//  SUAI_Navigation
//
//  Created by Виктор on 16.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUDownloader.h"
#import "ParserConstants.h"
#import "AFNetworking.h"

@implementation BUDownloader

+ (void)loadURLWithType:(ScheduleType)type
                success:(void (^) (NSData *data))success
                   fail:(void (^) (NSString *fail))fail {
    
    NSURL *url = (type == ScheduleTypeSession) ? [NSURL URLWithString:sessionLink] : [NSURL URLWithString:semesterLink];
    
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

+ (void)loadScheduleOfType:(ScheduleType)scheduleType
                    entity:(EntityType)entityType
                  entityId:(NSString *)identificator
                   success:(void (^) (NSData *data))success
                      fail:(void (^) (NSString *fail))fail {
    
    NSMutableString *url = [[NSMutableString alloc] init];
    if (scheduleType == ScheduleTypeSession) {
        [url appendString:sessionLink];
    } else {
        [url appendString:semesterLink];
    }
    
    if (entityType == EntityTypeGroup) {
        [url appendFormat:@"/?g=%@", identificator];
    } else {
        [url appendFormat:@"/?p=%@", identificator];
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFCompoundResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"text/html", nil];
    
    [manager POST:url
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
