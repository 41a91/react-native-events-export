//
//  EventsExportModule.m
//  React-Native-Events-Export
//
//  Created by phelpsandrew on 12/22/25.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(EventsExportModule, NSObject)
  RCT_EXTERN_METHOD(
                    addEventWithEditor:(NSString *)title
                    startDate:(double)startDate
                    endDate:(double)endDate
                    location:(NSString * _Nullable)location
                    resolver:(RCTPromiseResolveBlock)resolve
                    rejecter:(RCTPromiseRejectBlock)reject
                    )
@end
