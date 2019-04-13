//
//  BUAboutAppViewController.m
//  SUAI_Navigation
//
//  Created by Виктор on 12.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUAboutAppViewController.h"
#import "UIColor+SUAI.h"

@interface BUAboutAppViewController ()

@property (weak, nonatomic) IBOutlet UILabel *siteLabel;
@property (weak, nonatomic) IBOutlet UILabel *vkLabel;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UILabel *appName;

@end

@implementation BUAboutAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"О приложении";
    UITapGestureRecognizer *tapOnVkGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapVkLabel:)];
    self.vkLabel.userInteractionEnabled = YES;
    self.vkLabel.textColor = [UIColor suaiBlueColor];
    self.vkLabel.highlighted = YES;
    self.vkLabel.highlightedTextColor = [UIColor suaiBlueColor];
    [self.vkLabel addGestureRecognizer:tapOnVkGesture];
    UITapGestureRecognizer *tapOnSiteGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapSiteLabel:)];
    self.siteLabel.userInteractionEnabled = YES;
    self.siteLabel.textColor = [UIColor suaiBlueColor];
    self.siteLabel.highlighted = YES;
    self.siteLabel.highlightedTextColor = [UIColor suaiBlueColor];
    [self.siteLabel addGestureRecognizer:tapOnSiteGesture];
    self.appName.text = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSMutableString *presentText = [NSMutableString stringWithFormat:@"Версия %@", version];
    NSString *buildDate = [self buildDate];
    if (buildDate != nil) {
        [presentText appendString:[NSString stringWithFormat:@" от %@", buildDate]];
    }
    self.versionLabel.text = presentText;
}

- (NSString *)buildDate {
    var *creation = [[[NSBundle mainBundle] executableURL] resourceValuesForKeys:@[NSURLCreationDateKey] error:nil];
    if ([creation count] == 1) {
        NSDate *date = (NSDate *)[creation allValues][0];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd MMMM yyyy"];
        [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"]];
        NSString *dateStr = [dateFormatter stringFromDate:date];
        return dateStr;
    }
    return nil;
}

- (void)didTapSiteLabel:(UITapGestureRecognizer *)recognizer {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://sputnik.guap.ru"]];
}

- (void)didTapVkLabel:(UITapGestureRecognizer *)recognizer {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://vk.com/suainav"]];
}


@end
