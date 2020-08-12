//
//  Header.h
//  bdmap_location_flutter_plugin
//
//  Created by Wang,Shengzhan on 2020/2/4.
//


#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN
@class BdmapFlutterStreamHandler;
@interface BdmapFlutterStreamManager : NSObject
+ (instancetype)sharedInstance ;
@property (nonatomic, strong) BdmapFlutterStreamHandler* streamHandler;

@end

@interface BdmapFlutterStreamHandler : NSObject<FlutterStreamHandler>
@property (nonatomic, strong) FlutterEventSink eventSink;

@end
NS_ASSUME_NONNULL_END

