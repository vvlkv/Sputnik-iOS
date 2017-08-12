//
//  BUNews.h
//  SUAI_Navigation
//
//  Created by Виктор on 30.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;
@interface BUNews : NSObject

@property (strong, nonatomic) NSString *publicationId;
@property (strong, nonatomic) NSString *imageSource;
@property (strong, nonatomic) NSString *header;
@property (strong, nonatomic) NSString *subHeader;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) UIImage *image;

@end
