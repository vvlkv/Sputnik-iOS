//
//  BUCameraViewController.m
//  SUAI_Navigation
//
//  Created by Виктор on 24.06.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUCameraViewController.h"
#import "UIFont+SUAI.h"
#import <AVFoundation/AVFoundation.h>

@interface BUCameraViewController () <AVCaptureMetadataOutputObjectsDelegate, UINavigationBarDelegate, UIBarPositioningDelegate> {
    UIView *scanView;
    __block NSString *metadataResult;
}

@property (weak, nonatomic) IBOutlet UIView *preview;
@property (strong, nonatomic) AVCaptureSession *captureSession;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@end

@implementation BUCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _captureSession = nil;
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"Назад"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(dismiss)];
    
    self.navigationItem.title = @"QR сканер";
    self.navigationItem.leftBarButtonItem = cancelItem;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    CGFloat screenWidth = screenRect.size.width;
    CGFloat rectSize = screenWidth - 120;
    CGRect activeRect = CGRectMake(screenWidth/2 - rectSize/2, screenHeight/2 - rectSize/2 - 64, rectSize, rectSize);
    scanView = [[UIView alloc] init];
    scanView.frame = activeRect;
    scanView.backgroundColor = [UIColor clearColor];
    scanView.layer.borderWidth = 2.f;
    scanView.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    UILabel *helpLabel = [[UILabel alloc] init];
    helpLabel.translatesAutoresizingMaskIntoConstraints = NO;
    helpLabel.text = @"Наведите на код для сканирования";
    helpLabel.textColor = [UIColor whiteColor];
    helpLabel.font = [UIFont suaiRobotoFont:RobotoFontMedium size:17.f];
    helpLabel.backgroundColor = [UIColor clearColor];
    helpLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:helpLabel];
    [self startReading];
    [self.view addSubview:scanView];
    [self.view sendSubviewToBack:self.preview];
    [self.view bringSubviewToFront:scanView];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(8)-[label]-(8)-|" options:0 metrics:nil views:@{@"label":helpLabel}]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:helpLabel attribute:NSLayoutAttributeCenterY relatedBy:0 toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:rectSize/2 + 16]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (metadataResult != nil) {
        [self.output didScannedCode:metadataResult];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)stopReading{
    [_captureSession stopRunning];
    _captureSession = nil;
    [_videoPreviewLayer removeFromSuperlayer];
}

#pragma mark - Actions

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        
        AVMetadataMachineReadableCodeObject *metadataObj = metadataObjects[0];
        
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            __block NSString *result;
            AVMetadataObject *object = [_videoPreviewLayer transformedMetadataObjectForMetadataObject:metadataObj];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                result = [metadataObj stringValue];
                [UIView animateWithDuration:0.2 animations:^{
                    self->scanView.frame = CGRectMake(object.bounds.origin.x , object.bounds.origin.y + 64, CGRectGetWidth(object.bounds), CGRectGetHeight(object.bounds));
                }];
            });
            [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
            dispatch_async(dispatch_get_main_queue(), ^{
                self->metadataResult = result;
                [self dismissViewControllerAnimated:YES completion:nil];
            });
        }
    }
}


#pragma mark - UIBarPositioningDelegate

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
    return UIBarPositionTopAttached;
}

- (BOOL) shouldAutorotate {
    return NO;
}

#pragma mark - IBAction method implementation

- (BOOL)startReading {
    NSError *error;
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (!input) {
        return NO;
    }
    _captureSession = [[AVCaptureSession alloc] init];
    [_captureSession addInput:input];
    
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_captureSession addOutput:captureMetadataOutput];
    
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:_preview.layer.bounds];
    [_preview.layer addSublayer:_videoPreviewLayer];
    [self.view sendSubviewToBack:_preview];
    [_captureSession startRunning];
    return YES;
}

@end
