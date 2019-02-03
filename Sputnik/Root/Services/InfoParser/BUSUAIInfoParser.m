//
//  SUAIInfoParser.m
//  SUAIInfoParser
//
//  Created by Виктор on 28.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUSUAIInfoParser.h"
#import "NSString+Lowercalize.h"
#import "TBXML.h"
#import "BUFaculty.h"
#import "BUItem.h"
#import "BUDean.h"
#import "BUCathedral.h"

@interface BUSUAIInfoParser() {
    NSXMLParser *parser;
}

@end

@implementation BUSUAIInfoParser

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSArray *)loadFile {
    
    NSData *xmlData = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"information" ofType:@"xml"]];
    NSError *error;
    NSMutableArray *objects = [NSMutableArray array];
    
    TBXML *source = [[TBXML alloc] initWithXMLData:xmlData error:&error];
    
    NSArray *attributes = @[@"name", @"Auditorium", @"Time", @"Telephone"];
    
    TBXMLElement *others = [TBXML childElementNamed:@"Others" parentElement:source.rootXMLElement];
    [objects addObject:[self loadObjects:others withAttributes:attributes forType:ItemTypeOther]];
    
    TBXMLElement *faculties = [TBXML childElementNamed:@"faculties" parentElement:source.rootXMLElement];
    [objects addObject:[self loadFaculties:faculties]];
    
    TBXMLElement *departments = [TBXML childElementNamed:@"Departments" parentElement:source.rootXMLElement];
    [objects addObject:[self loadObjects:departments withAttributes:attributes forType:ItemTypeDepartment]];
    
    return objects;
}

- (NSArray *)loadFaculties:(TBXMLElement *)faculties {
    
    NSMutableArray *objects = [NSMutableArray array];
//    TBXMLElement *faculty = faculties->firstChild;
//    TBXMLElement *element;
//    NSArray *attributes;
//
//    do {
//        element = (faculty->firstChild);
//        NSString *facultNumber = [TBXML valueOfAttributeNamed:@"number" forElement:faculty];
//        NSString *facultName = [TBXML valueOfAttributeNamed:@"name" forElement:faculty];
//        BUFaculty *facultEntity = [[BUFaculty alloc] initWithNumber:facultNumber
//                                                            andName:facultName];
//        [objects addObject:facultEntity];
//        do {
//            if ([[TBXML elementName:element] isEqualToString:@"Dean"]) {
//
//                attributes = @[@"Auditorium", @"Telephone", @"HeaderName|name"];
//                BUDean *dean = (BUDean *)[self loadEntity:element withAttributes:attributes andClass:[BUDean class]];
//                [dean setHeader:[facultEntity title]];
//                facultEntity.dean = dean;
//
//            } else {
//
//                attributes = @[@"name", @"Auditorium", @"number", @"Telephone", @"HeaderName|headerName"];
//                BUCathedral *cathedral = (BUCathedral *)[self loadEntity:element withAttributes:attributes andClass:[BUCathedral class]];
//                [cathedral setHeader:cathedral.name];
//                [facultEntity addCathedral:cathedral];
//            }
//        } while ((element = element->nextSibling));
//    } while ((faculty = faculty->nextSibling));
//
    return [objects copy];
}

- (NSArray *)loadObjects:(TBXMLElement *)entities
          withAttributes:(NSArray *)attributes
                 forType:(ItemType)type {
    
    NSMutableArray *objects = [NSMutableArray array];
    TBXMLElement *department = entities->firstChild;
    
    do {
        BUItem *item = [self loadEntity:department withAttributes:attributes forType:type];
        [objects addObject:item];
    } while ((department = department->nextSibling));
    
    return [objects copy];
}

- (id)loadEntity:(TBXMLElement *)element
  withAttributes:(NSArray *)attributes
        andClass:(Class)class {
    
    BUAbstractItem *item = [[class alloc] init];
    TBXMLElement *destination;
    
    for (NSString *attribute in attributes) {
        NSArray *components = [attribute componentsSeparatedByString:@"|"];
        destination = [TBXML childElementNamed:[components firstObject] parentElement:element];
        [item setValue:[TBXML textForElement:destination] forKey:[[components lastObject] lowercalizedString]];
    }
    return item;
}

- (BUItem *)loadEntity:(TBXMLElement *)element
        withAttributes:(NSArray *)attributes
               forType:(ItemType)type {
    
    BUItem *item = [[BUItem alloc] initWithType:type];
    TBXMLElement *destination;
    
    for (NSString *attribute in attributes) {
        NSArray *components = [attribute componentsSeparatedByString:@"|"];
        destination = [TBXML childElementNamed:[components firstObject] parentElement:element];
        [item setValue:[TBXML textForElement:destination] forKey:[[components lastObject] lowercaseString]];
    }
    return item;
}

@end
