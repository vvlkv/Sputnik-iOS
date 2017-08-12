//
//  BUNewsDetailInfoDownloader.h
//  SUAI_Navigation
//
//  Created by Виктор on 31.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BUNewsDetailInfoDownloaderDelegate <NSObject>

@required
- (void)newsLoaded:(id)news;

@end

@interface BUNewsDetailInfoDownloader : NSObject

@property (weak, nonatomic) id <BUNewsDetailInfoDownloaderDelegate> delegate;

- (void)loadNews:(NSString *)newsId;

@end
