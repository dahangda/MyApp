//
//  YHAdPagesView.m
//  MyApp
//
//  Created by 燕航 on 2017/10/4.
//  Copyright © 2017年 yanhang. All rights reserved.
//

#import "YHAdPagesView.h"
 NSString const *adImageName = @"adImageName";
 NSString const *adImageUrl = @"adImageUrl";
static int btn_time = 5;

@interface YHAdPagesView()
/** 广告页存放图片 */
@property(nonatomic,strong) UIImageView *adView ;
/*广告页button */
@property(nonatomic,strong) UIButton * adButton;
/** 定时器 */
@property(nonatomic,strong) NSTimer * countTimer;
//临时减量
@property(nonatomic,assign) NSInteger count;
//图片路径
@property(nonatomic,strong) NSString * fliePath;
//点击跳转block
@property(nonatomic,copy)TapBlock tapblock;



@end

@implementation YHAdPagesView
- (instancetype)initWithFrame:(CGRect)frame andTap:(TapBlock)block
{
    if (self = [super initWithFrame:frame])
    {
//        广告图片view
        _adView = [[UIImageView alloc] initWithFrame:frame];
        _adView.userInteractionEnabled = YES;
        _adView.contentMode = UIViewContentModeScaleToFill;
        UIGestureRecognizer *tap = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(pushAd)];
        [_adView addGestureRecognizer:tap];
        
        float btn_w = 40;
        float btn_h =30;
        _adButton = [[UIButton alloc] initWithFrame:CGRectMake(YHScreen_W - btn_w -15, 20, btn_w, btn_h)];
        [_adButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        _adButton.layer.cornerRadius = 4;
        _adButton.backgroundColor = YHRGBAColor(40, 40, 40, 0.6);
        
        
        [_adButton setTitle:[NSString stringWithFormat:@"跳过%d",btn_time] forState: UIControlStateNormal];
        _adButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _count = btn_time;
        [self addSubview:self.adView];
        [self addSubview:self.adButton];
        
        _countTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
        
        
        NSString *filePath = [self getFilePathWithImageName:[YHUserDefaults valueForKey:adImageName]];
        BOOL isExist = [self isFileExistWithFilePath:filePath];
        if (isExist) {
            
            [self setImageWithFilePath:filePath];
            self.tapblock = block;
            [self show];
        }
        
        
            [self getAdvertisingImage];
       
        
        
    }
    return self;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark - 获取广告图片方法

-(void)getAdvertisingImage
{
    NSArray *imagesArray = @[@"http://oxcgiq3e6.bkt.clouddn.com/Snip20171005_1.png",@"http://oxcgiq3e6.bkt.clouddn.com/Snip20171005_2.png",@"http://oxcgiq3e6.bkt.clouddn.com/Snip20171005_4.png",@"http://oxcgiq3e6.bkt.clouddn.com/Snip20171005_3.jpg"];
    NSString *imageUrl =imagesArray[arc4random()%imagesArray.count];
    
    NSArray *stringArray = [imageUrl componentsSeparatedByString:@"/"];
    NSString *imageName = [stringArray lastObject];
    
    NSString *filePath   =  [self getFilePathWithImageName:imageName];
    
    BOOL isExist = [self isFileExistWithFilePath:filePath];
    
    if (!isExist) {
        [self downloadAdImageUrl:imageUrl imageName:imageName];
    }
    
}

#pragma mark - 展示广告页

- (void)show{
    
    [[NSRunLoop mainRunLoop ] addTimer:_countTimer forMode:NSRunLoopCommonModes];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    
}

#pragma mark - 下载广告页


-(void)downloadAdImageUrl:(NSString*)imageUrl imageName:(NSString*)imageName{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        UIImage *image = [UIImage imageWithData:data];
        NSString *filePath = [self getFilePathWithImageName:imageName];
        if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {
            YHLog(@"广告加载成功");
            [self deleteOldImage];
            [YHUserDefaults setValue:imageName forKey:adImageName];
            [YHUserDefaults synchronize];
        }
        else{
            YHLog(@"加载失败");
        }
        
    });
}
#pragma mark - 删除旧图片

- (void)deleteOldImage{
    NSString *imageName = [YHUserDefaults valueForKey:adImageName];
    NSString *filePath = [self getFilePathWithImageName:imageName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:filePath error:nil];
    
    
    
}


- (void)setImageWithFilePath:(NSString*)filepath{
    _fliePath = filepath;
    _adView.image = [UIImage imageWithContentsOfFile:filepath];
    
    
}
#pragma mark - 判断文件是否在本地存储

- (BOOL)isFileExistWithFilePath:(NSString*)filepath{
    
    NSFileManager *fileManager  =[NSFileManager defaultManager];
    BOOL isdrectory;
    return [fileManager fileExistsAtPath:filepath isDirectory:&isdrectory];
    
}

#pragma mark - 移除广告页

- (void)dismiss{
    [self.countTimer invalidate];
    self.countTimer = nil;
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 0.f;
        
    } completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
    
    
}
#pragma mark - 跳转到广告内容

- (void)pushAd{
    [self dismiss];
    if (_tapblock) {
        _tapblock();
        
    }
    
}

#pragma mark - 拼接图片路径方法

- (NSString *)getFilePathWithImageName:(NSString *)adImageName
{
    if (adImageName) {
        NSArray *paths =NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *pathfile = [[paths objectAtIndex:0] stringByAppendingPathComponent:adImageName];
        
        return pathfile;
        }
    
    else return nil;

}
#pragma mark - 定时执行方法

-(void)countDown{
    
    _count--;
    [_adButton setTitle:[NSString stringWithFormat:@"跳过%ld",_count] forState:UIControlStateNormal];
    if (_count<=0) {
        [self dismiss];
        
    }
}
@end
