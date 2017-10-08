//
//  BUNewsDownloader.h
//  SUAI_Navigation
//
//  Created by Виктор on 30.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BUNewsDownloaderDelegate <NSObject>

@required
- (void)newsLoaded:(NSArray *)news;
- (void)failureLoading:(NSString *)failureText;

@end

@interface BUNewsDownloader : NSObject

@property (weak, nonatomic) id <BUNewsDownloaderDelegate> delegate;

- (void)loadNews;

@end
