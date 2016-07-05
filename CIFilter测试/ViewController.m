//
//  ViewController.m
//  CIFilter测试
//
//  Created by 李小亚 on 16/7/5.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) UIImage *originalImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.originalImage = self.imageView.image;
}

- (IBAction)originalImage:(id)sender {
    self.imageView.image = self.originalImage;
}
- (IBAction)blackWhiteImage:(id)sender {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        CIImage *inputImage = [[CIImage alloc] initWithImage:self.originalImage];
        
        /**
         *  CIColorMonochrome  CISepiaTone
         */
        
        CIFilter *filter = [CIFilter filterWithName:@"CIColorMonochrome"];
        [filter setValue:inputImage forKey:kCIInputImageKey];
        
        NSLog(@"%@", filter.attributes);
        NSLog(@"%@", [CIFilter filterNamesInCategory:kCICategoryColorEffect]);
        
        CIContext *content = [CIContext contextWithOptions:nil];
        CIImage *outputImage = [filter outputImage];
        
        CGImageRef cgImage = [content createCGImage:outputImage fromRect:[outputImage extent]];
        UIImage *newImage = [UIImage imageWithCGImage:cgImage];
        CGImageRelease(cgImage);
        dispatch_async(dispatch_get_main_queue(), ^{
            //展示图片
            self.imageView.image = newImage;
        });
    });
}

@end
