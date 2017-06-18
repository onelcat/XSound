//
//  PlayView.m
//  XSound
//
//  Created by king eru on 2017/6/13.
//  Copyright © 2017年 NASA. All rights reserved.
//

#import "PlayView.h"
#import "Masonry.h"

#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface PlayView()<AVAudioPlayerDelegate>
@property (nonatomic ,strong) UIImageView * soundView;
@property (nonatomic ,strong) UISlider * soundSlider;
@property (nonatomic ,assign) BOOL isPlay;
@property (nonatomic, strong) AVAudioPlayer *player;
@end

@implementation PlayView

- (id)initWithFrame:(CGRect)frame iconName:(NSString *) name{
    self = [super initWithFrame:frame];
    if(self) {
        // Initialization code
        _isPlay = NO;
        NSError *err;
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:name withExtension:@"mp3"];
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&err];
        
        NSLog(@"%@ %@", name, err);
        if(err) {
            NSLog(@"-------------");
            NSURL *url = [[NSBundle mainBundle] URLForResource:name withExtension:@"wav"];
            _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&err];
        }
        
        _player.volume = 0.4;
        _player.delegate = self;
        _player.rate = 1.0;
        _player.numberOfLoops = -1;
        [_player prepareToPlay];
        
        UITapGestureRecognizer *tag1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(isSelectView:)];
        
        _soundView = [[UIImageView alloc] init];
        [_soundView setImage:[UIImage imageNamed:name]];
        [_soundView addGestureRecognizer:tag1];
        [_soundView setUserInteractionEnabled:YES];
        [self addSubview:_soundView];
        
        [_soundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(5);
            make.centerX.equalTo(self);
            make.width.equalTo(self).offset(-30);
            make.height.equalTo(_soundView.mas_width);
        }];
        
        _soundSlider = [[UISlider alloc] init];
        _soundSlider.minimumValue = 0.0;
        _soundSlider.maximumValue = 1.0;
        _soundSlider.value = 0.4;
        _soundSlider.continuous = NO;
        [_soundSlider addTarget:self action:@selector(doSomething:) forControlEvents:UIControlEventValueChanged];
        
        [self addSubview:_soundSlider];
        _soundSlider.tag = self.tag;
        [_soundSlider setThumbTintColor:[UIColor whiteColor]];
        
        [_soundSlider setThumbImage:[UIImage imageNamed:@"Oval"] forState:UIControlStateNormal];
        [_soundSlider setThumbImage:[UIImage imageNamed:@"Oval"] forState:UIControlStateHighlighted];
        [_soundSlider thumbRectForBounds:CGRectMake(0, 0, 25, 25) trackRect:CGRectMake(0, 0, 25, 25) value:10.0];
        
        [_soundSlider setMaximumTrackImage:[UIImage imageNamed:@"Rectangle"] forState:UIControlStateNormal];
        [_soundSlider setMinimumTrackImage:[UIImage imageNamed:@"Rectangle"] forState:UIControlStateNormal];
        
        [_soundSlider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_soundView.mas_bottom).offset(5);
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.width.equalTo(self);
        }];
        
        [_soundSlider setHidden:YES];
        
    }
    return self;
}


-(void) doSomething:(id) sender {
        UISlider * tm = (UISlider *) sender;
        _player.volume = tm.value;
}

-(void) isSelectView:(UITapGestureRecognizer *)gesture {
    _isPlay = !_isPlay;
    if(_isPlay){
        [_player play];
        [_soundSlider setHidden:NO];
    }
    else if(!_isPlay) {
        [_player pause];
        [_soundSlider setHidden:YES];
    }
}


#pragma mark --AVAudioPlayerDelegate
// 播放完成
-(void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    //
    NSLog(@"audioPlayerDidFinishPlaying");
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error{
    NSLog(@"my error %@",error);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
