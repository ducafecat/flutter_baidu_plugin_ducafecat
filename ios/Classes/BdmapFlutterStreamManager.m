//
//  BdmapFlutterStreamManager.m
//  bdmap_location_flutter_plugin
//
//  Created by Wang,Shengzhan on 2020/2/4.
//

#import "BdmapFlutterStreamManager.h"

@implementation BdmapFlutterStreamManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static BdmapFlutterStreamManager *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[BdmapFlutterStreamManager alloc] init];
        BdmapFlutterStreamHandler * streamHandler = [[BdmapFlutterStreamHandler alloc] init];
        manager.streamHandler = streamHandler;
    });
    
    return manager;
}

@end


@implementation BdmapFlutterStreamHandler

- (FlutterError*)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)eventSink {
    self.eventSink = eventSink;
    return nil;
}

- (FlutterError*)onCancelWithArguments:(id)arguments {
    
    return nil;
}

@end
 
