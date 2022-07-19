//
//  mapboxSoundDSPKernelAdapter.h
//  mapboxSound
//
//  Created by Chavez Bobb on 7/15/22.
//

#import <AudioToolbox/AudioToolbox.h>

@class AudioUnitViewController;

NS_ASSUME_NONNULL_BEGIN

@interface mapboxSoundDSPKernelAdapter : NSObject

@property (nonatomic) AUAudioFrameCount maximumFramesToRender;
@property (nonatomic, readonly) AUAudioUnitBus *inputBus;
@property (nonatomic, readonly) AUAudioUnitBus *outputBus;

- (void)setParameter:(AUParameter *)parameter value:(AUValue)value;
- (AUValue)valueForParameter:(AUParameter *)parameter;

- (void)allocateRenderResources;
- (void)deallocateRenderResources;
- (AUInternalRenderBlock)internalRenderBlock;

@end

NS_ASSUME_NONNULL_END
