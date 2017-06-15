//
//  ViewController.m
//  XSound
//
//  Created by king eru on 2017/6/2.
//  Copyright © 2017年 NASA. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "PlayView.h"
@interface ViewController ()

@property UIScrollView *scrollView;
@property (strong ,nonatomic) NSMutableArray * playViews;

@end

//NSArray * iconNames = @[@"",@""];

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
//background-color: rgb(22, 124, 128);
    self.view.backgroundColor = [UIColor colorWithRed:22/255.0 green:124/255.0 blue:128/255.0 alpha:1.0];

    _scrollView = [[UIScrollView alloc] init];
    _scrollView.scrollEnabled = YES;
//    _scrollView.pagingEnabled = YES;
    
    [self.view addSubview:_scrollView];


    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(5);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-5);
//        make.width.equalTo(self.view);
    }];
    
    UIView *tmScro = [[UIView alloc] init];
    [_scrollView addSubview:tmScro];
    [tmScro mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView);
        make.top.left.bottom.and.right.equalTo(_scrollView).with.insets(UIEdgeInsetsZero);
        make.width.equalTo(_scrollView);
    }];
    //    _scrollView.showsHorizontalScrollIndicator = NO;
    
    
    PlayView *tmPlayView = nil;
    PlayView *lastPlayView = nil;
    
    NSArray *imagesName = [[NSArray alloc] initWithObjects:@"brownnoise",@"coffee",@"fan",@"fire",@"forest",@"leaves",@"pinknoise",@"rain",@"seaside",@"summernight",@"thunderstorm", @"train",@"water",@"waterstream",@"whitenoise", @"wind", nil];
    
    int i = 0;

    for (NSString *tm in imagesName) {
        
//        NSLog(@"%@",tm);
        
        tmPlayView = [[PlayView alloc] initWithFrame:CGRectZero iconName:tm];
        
        [_playViews addObject:tmPlayView];
        
        [tmScro addSubview:tmPlayView];
        
        if(i%2 == 0) {
            
            if(i == 0 ) {
                
                [tmPlayView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(tmScro).offset(5);
                    make.right.equalTo(self.view.mas_centerX).offset(-5);
                    make.top.equalTo(tmScro).offset(5);
                    make.height.equalTo(tmPlayView.mas_width);
                }];
                
            }else {
                
                [tmPlayView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(tmScro).offset(5);
                    make.right.equalTo(self.view.mas_centerX).offset(-5);
                    make.top.equalTo(lastPlayView.mas_bottom).offset(5);
                    make.height.equalTo(tmPlayView.mas_width);
                }];
            }

            
        } else {
            
            if(i == 1) {
                
                [tmPlayView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.view.mas_centerX).offset(5);
                    make.right.equalTo(tmScro).offset(-5);
                    make.top.equalTo(tmScro).offset(5);
                    make.height.equalTo(tmPlayView.mas_width);
                }];
                
            }else {
                
                [tmPlayView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.view.mas_centerX).offset(5);
                    make.right.equalTo(tmScro).offset(-5);
                    make.top.equalTo(lastPlayView.mas_bottom).offset(5);
                    make.height.equalTo(tmPlayView.mas_width);
                }];
            }

            lastPlayView = tmPlayView;
        
        }
        
        i = i + 1;
    }
    
    [tmScro mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastPlayView);
    }];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
