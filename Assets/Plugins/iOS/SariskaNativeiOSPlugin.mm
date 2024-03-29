#import <sariska/sariska.h>

char const *GAME_OBJECT = "PluginBridge";

@interface SariskaNativeiOSPlugin : NSObject
@end

@implementation SariskaNativeiOSPlugin

static SariskaNativeiOSPlugin *_sharedInstance;

+(SariskaNativeiOSPlugin*)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[SariskaNativeiOSPlugin alloc] init];
    });
    return _sharedInstance;
}

-(id)init
{
    self = [super init];
    if (self)
        [self initHelper];
    return self;
}

-(void)initHelper
{
    // Set up code goes here
    NSLog(@"Initialized NativeCalculationsPlugin class");
}

-(void) performSampleFunction
{
    NSLog(@"performing sample functions");
    
    [SariskaMediaTransport initializeSdk];
    
    NSLog(@"initialized Sariska Media Transport yay!");
    
    Connection *connection = [SariskaMediaTransport JitsiConnection:@"1234"];
    
    if(connection == NULL){
        NSLog(@"Connection is not null");
    }
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
        @YES, @"audio", @YES, @"video", nil];
    
    [SariskaMediaTransport createLocalTracks:options callback:^(NSMutableArray * _Nonnull tracks) {
        for (JitsiLocalTrack *obj in tracks) {
            if([obj.getType  isEqual: @"video"]){
                NSLog(@"We are here in local track");
                RTCVideoView *videoView = [obj render];
                [videoView setMirror:true];
                NSLog(@"We are here after local track");
            }
        }
    }];
}

@end

extern "C"{
    void initializeSariskaMediaTransport(){
        NSLog(@"We are in iOS from Unity");
        [[SariskaNativeiOSPlugin sharedInstance] performSampleFunction];
    }
    
}


