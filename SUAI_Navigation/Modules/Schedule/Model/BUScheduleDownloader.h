//
//  BUScheduleDownloader.h
//  SUAI_Navigation
//
//  Created by Виктор on 23.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BUScheduleDownloaderDelegate <NSObject>

@required
- (void)codesLoaded;
- (void)failedConnection;

@optional
- (void)dataLoaded:(NSDictionary *)data;

@end

@interface BUScheduleDownloader : NSObject

@property (strong, readonly) NSDictionary *codes;
@property (weak, nonatomic) id <BUScheduleDownloaderDelegate> delegate;
@property (strong, readonly) NSString *date;

- (void)downloadScheduleForEntity:(NSString *)entity
                                    andType:(NSUInteger)type;

@end
