// Autogenerated from Pigeon (v11.0.1), do not edit directly.
// See also: https://pub.dev/packages/pigeon

#import "messages.h"

#if TARGET_OS_OSX
#import <FlutterMacOS/FlutterMacOS.h>
#else
#import <Flutter/Flutter.h>
#endif

#if !__has_feature(objc_arc)
#error File requires ARC to be enabled.
#endif

static NSArray *wrapResult(id result, FlutterError *error) {
  if (error) {
    return @[
      error.code ?: [NSNull null], error.message ?: [NSNull null], error.details ?: [NSNull null]
    ];
  }
  return @[ result ?: [NSNull null] ];
}
static id GetNullableObjectAtIndex(NSArray *array, NSInteger key) {
  id result = array[key];
  return (result == [NSNull null]) ? nil : result;
}

@interface FLTToggleMessage ()
+ (FLTToggleMessage *)fromList:(NSArray *)list;
+ (nullable FLTToggleMessage *)nullableFromList:(NSArray *)list;
- (NSArray *)toList;
@end

@interface FLTIsEnabledMessage ()
+ (FLTIsEnabledMessage *)fromList:(NSArray *)list;
+ (nullable FLTIsEnabledMessage *)nullableFromList:(NSArray *)list;
- (NSArray *)toList;
@end

@implementation FLTToggleMessage
+ (instancetype)makeWithEnable:(nullable NSNumber *)enable {
  FLTToggleMessage* pigeonResult = [[FLTToggleMessage alloc] init];
  pigeonResult.enable = enable;
  return pigeonResult;
}
+ (FLTToggleMessage *)fromList:(NSArray *)list {
  FLTToggleMessage *pigeonResult = [[FLTToggleMessage alloc] init];
  pigeonResult.enable = GetNullableObjectAtIndex(list, 0);
  return pigeonResult;
}
+ (nullable FLTToggleMessage *)nullableFromList:(NSArray *)list {
  return (list) ? [FLTToggleMessage fromList:list] : nil;
}
- (NSArray *)toList {
  return @[
    (self.enable ?: [NSNull null]),
  ];
}
@end

@implementation FLTIsEnabledMessage
+ (instancetype)makeWithEnabled:(nullable NSNumber *)enabled {
  FLTIsEnabledMessage* pigeonResult = [[FLTIsEnabledMessage alloc] init];
  pigeonResult.enabled = enabled;
  return pigeonResult;
}
+ (FLTIsEnabledMessage *)fromList:(NSArray *)list {
  FLTIsEnabledMessage *pigeonResult = [[FLTIsEnabledMessage alloc] init];
  pigeonResult.enabled = GetNullableObjectAtIndex(list, 0);
  return pigeonResult;
}
+ (nullable FLTIsEnabledMessage *)nullableFromList:(NSArray *)list {
  return (list) ? [FLTIsEnabledMessage fromList:list] : nil;
}
- (NSArray *)toList {
  return @[
    (self.enabled ?: [NSNull null]),
  ];
}
@end

@interface FLTWakelockApiCodecReader : FlutterStandardReader
@end
@implementation FLTWakelockApiCodecReader
- (nullable id)readValueOfType:(UInt8)type {
  switch (type) {
    case 128: 
      return [FLTIsEnabledMessage fromList:[self readValue]];
    case 129: 
      return [FLTToggleMessage fromList:[self readValue]];
    default:
      return [super readValueOfType:type];
  }
}
@end

@interface FLTWakelockApiCodecWriter : FlutterStandardWriter
@end
@implementation FLTWakelockApiCodecWriter
- (void)writeValue:(id)value {
  if ([value isKindOfClass:[FLTIsEnabledMessage class]]) {
    [self writeByte:128];
    [self writeValue:[value toList]];
  } else if ([value isKindOfClass:[FLTToggleMessage class]]) {
    [self writeByte:129];
    [self writeValue:[value toList]];
  } else {
    [super writeValue:value];
  }
}
@end

@interface FLTWakelockApiCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation FLTWakelockApiCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[FLTWakelockApiCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[FLTWakelockApiCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *FLTWakelockApiGetCodec(void) {
  static FlutterStandardMessageCodec *sSharedObject = nil;
  static dispatch_once_t sPred = 0;
  dispatch_once(&sPred, ^{
    FLTWakelockApiCodecReaderWriter *readerWriter = [[FLTWakelockApiCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}

void FLTWakelockApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<FLTWakelockApi> *api) {
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.wakelock_platform_interface.WakelockApi.toggle"
        binaryMessenger:binaryMessenger
        codec:FLTWakelockApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(toggleMsg:error:)], @"FLTWakelockApi api (%@) doesn't respond to @selector(toggleMsg:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        FLTToggleMessage *arg_msg = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        [api toggleMsg:arg_msg error:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.wakelock_platform_interface.WakelockApi.isEnabled"
        binaryMessenger:binaryMessenger
        codec:FLTWakelockApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(isEnabledWithError:)], @"FLTWakelockApi api (%@) doesn't respond to @selector(isEnabledWithError:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        FLTIsEnabledMessage *output = [api isEnabledWithError:&error];
        callback(wrapResult(output, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
}
