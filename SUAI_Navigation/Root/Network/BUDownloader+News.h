//
//  BUDownloader+News.h
//  SUAI_Navigation
//
//  Created by Виктор on 30.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUDownloader.h"

@interface BUDownloader (News)

+ (void)loadNewsPageWithSuccess:(void (^) (NSData *data))success
                           fail:(void (^) (NSString *fail))fail;

+ (void)loadImage:(NSString *)newsUrl
             success:(void (^) (NSData *data))success
                fail:(void (^) (NSString *fail))fail;

+ (void)loadNewsPage:(NSString *)newsId
             success:(void (^) (NSData *data))success
                fail:(void (^) (NSString *fail))fail;

@end
