//
//  mapboxSoundAudioUnit.h
//  mapboxSound
//
//  Created by Chavez Bobb on 7/15/22.
//

#import <AudioToolbox/AudioToolbox.h>
#import "mapboxSoundDSPKernelAdapter.h"

// Define parameter addresses.
extern const AudioUnitParameterID myParam1;

@interface mapboxSoundAudioUnit : AUAudioUnit

@property (nonatomic, readonly) mapboxSoundDSPKernelAdapter *kernelAdapter;
- (void)setupAudioBuses;
- (void)setupParameterTree;
- (void)setupParameterCallbacks;
@end
