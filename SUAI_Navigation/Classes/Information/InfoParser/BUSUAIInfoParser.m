//
//  SUAIInfoParser.m
//  SUAIInfoParser
//
//  Created by Виктор on 28.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUSUAIInfoParser.h"
#import "TBXML.h"
#import "BUFaculty.h"
#import "BUItem.h"

@interface BUSUAIInfoParser() {
    NSXMLParser *parser;
    NSData *xmlData;
}

@end

@implementation BUSUAIInfoParser

- (instancetype)init {
    self = [super init];
    if (self) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"information" ofType:@"xml"];
        xmlData = [[NSData alloc] initWithContentsOfFile:filePath];
    }
    return self;
}

- (NSArray *)loadFile {
    NSError *error;
    NSMutableArray *objects = [NSMutableArray array];
    NSArray *attributes = @[@"name", @"Auditorium", @"Time", @"Telephone"];
    
    TBXML *source = [[TBXML alloc] initWithXMLData:xmlData error:&error];
    TBXMLElement *faculties = [TBXML childElementNamed:@"faculties" parentElement:source.rootXMLElement];
    TBXMLElement *departments = [TBXML childElementNamed:@"Departments" parentElement:source.rootXMLElement];
    TBXMLElement *others = [TBXML childElementNamed:@"Others" parentElement:source.rootXMLElement];
    
    [objects addObject:[self loadObjects:others withAttributes:attributes forType:ItemTypeOther]];
    [objects addObject:[self loadFaculties:faculties]];
    [objects addObject:[self loadObjects:departments withAttributes:attributes forType:ItemTypeDepartment]];
    
    return objects;
}

- (NSArray *)loadFaculties:(TBXMLElement *)faculties {
    
    NSMutableArray *objects = [NSMutableArray array];
    TBXMLElement *faculty = faculties->firstChild;
    TBXMLElement *element;
    NSArray *attributes;
    
    do {
        element = (faculty->firstChild);
        NSString *facultNumber = [TBXML valueOfAttributeNamed:@"number" forElement:faculty];
        NSString *facultName = [TBXML valueOfAttributeNamed:@"name" forElement:faculty];
        BUFaculty *facultEntity = [[BUFaculty alloc] initWithNumber:facultNumber
                                                             andName:facultName];
        [objects addObject:facultEntity];
        do {
            if ([[TBXML elementName:element] isEqualToString:@"Dean"]) {
                
                attributes = @[@"Auditorium", @"Telephone", @"HeaderName|name"];
                BUDean *dean = [self loadEntity:element withAttributes:attributes forType:ItemTypeDean];
                dean.definition = @"Деканат";
                [facultEntity.departments addObject:dean];
                
            } else {
                
                attributes = @[@"name", @"Auditorium", @"number", @"Telephone"];
                BUItem *item = (BUItem *)[self loadEntity:element withAttributes:attributes forType:ItemTypeDepartment];
                item.definition = [item shortName];
                [facultEntity.departments addObject:item];
            }
        } while ((element = element->nextSibling));
    } while ((faculty = faculty->nextSibling));
    
    return [objects copy];
}

- (NSArray *)loadObjects:(TBXMLElement *)entities
      withAttributes:(NSArray *)attributes
             forType:(ItemType)type {
    
    NSMutableArray *objects = [NSMutableArray array];
    TBXMLElement *department = entities->firstChild;
    
    do {
        BUItem *item = (BUItem *)[self loadEntity:department withAttributes:attributes forType:type];
        [objects addObject:item];
    } while ((department = department->nextSibling));
    
    return [objects copy];
}

- (BUDean *)loadEntity:(TBXMLElement *)element
        withAttributes:(NSArray *)attributes
               forType:(ItemType)type {
    
    BUDean *item = (type == ItemTypeDean) ? [[BUDean alloc] init] : (BUItem *)[[BUItem alloc] initWithType:type];
    TBXMLElement *destination;
    
    for (NSString *attribute in attributes) {
        NSArray *components = [attribute componentsSeparatedByString:@"|"];
        destination = [TBXML childElementNamed:[components firstObject] parentElement:element];
        [item setValue:[TBXML textForElement:destination] forKey:[[components lastObject] lowercaseString]];
    }
    item.definition = item.name;
    return item;
}

@end
