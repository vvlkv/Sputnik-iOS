//
//  BURefrerenceViewModelLinksConstructor.m
//  SUAI_Navigation
//
//  Created by Виктор on 22/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BURefrerenceViewModelLinksConstructor.h"
#import "BULink.h"
#import "BUDepartment.h"
#import "BUSubdivision.h"
#import "BUReferenceViewModelLinkItem.h"

@implementation BURefrerenceViewModelLinksConstructor

- (NSArray *)createModelFrom:(id)model {
    NSMutableArray *rows = [NSMutableArray array];
    BULink *link;
    if ([model isKindOfClass:[BUDepartment class]]) {
        link = (BULink *)[(BUDepartment *)model link];
    } else if ([model isKindOfClass:[BUSubdivision class]]) {
        link = (BULink *)[(BUSubdivision *)model link];
    } else {
        link = (BULink *)model;
    }
    
    if (![[link site] isEqualToString:@""]) {
        BUReferenceViewModelLinkItem *siteItem = [[BUReferenceViewModelLinkItem alloc] initWithAction:ReferenceActionTypeSite];
        siteItem.nameDescription = @"Сайт";
        siteItem.value = [link site];
        [rows addObject:siteItem];
    }
    if (![[link mail] isEqualToString:@""]) {
        BUReferenceViewModelLinkItem *mailItem = [[BUReferenceViewModelLinkItem alloc] initWithAction:ReferenceActionTypeMail];
        mailItem.nameDescription = @"Почта";
        mailItem.value = [link mail];
        [rows addObject:mailItem];
    }
    if ([model isKindOfClass:[BUInfoPlacedEntity class]]) {
        BUInfoPlacedEntity *placedEntity = (BUInfoPlacedEntity *)model;
        if (![[placedEntity aud] isEqualToString:@""]) {
            BUReferenceViewModelLinkItem *audItem = [[BUReferenceViewModelLinkItem alloc] initWithAction:ReferenceActionTypeAuditory];
            audItem.nameDescription = @"Аудитория";
            audItem.value = [NSString stringWithFormat:@"%@ %@", [placedEntity pos], [placedEntity aud]];
            [rows addObject:audItem];
        }
    }
    return rows;
}

@end
