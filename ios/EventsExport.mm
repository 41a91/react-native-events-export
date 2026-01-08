#import "EventsExport.h"
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>

@interface EventsExport()
@property (nonatomic, strong) EKEventStore *eventStore;
@property (nonatomic, strong) EKEventEditViewController *eventController;
@end

@implementation EventsExport

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(addEventWithEditor:(NSString *)title
                                startDate:(nonnull NSNumber *)startTimestamp
                                endDate:(nonnull NSNumber *)endTimestamp
                                location:(NSString * _Nullable)location)
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.eventStore = [[EKEventStore alloc] init];

        EKEvent *event = [EKEvent eventWithEventStore:self.eventStore];
        event.title = title;
        event.startDate = [NSDate dateWithTimeIntervalSince1970:startTimestamp.doubleValue / 1000.0];
        event.endDate = [NSDate dateWithTimeIntervalSince1970:endTimestamp.doubleValue / 1000.0];
        if(location != nil) {
            event.location = location;
        }

        self.eventController = [[EKEventEditViewController alloc] init];
        self.eventController.eventStore = self.eventStore;
        self.eventController.event = event;
        self.eventController.editViewDelegate = self;

        UIViewController *root = RCTPresentedViewController();
        [root presentViewController:self.eventController animated:YES completion:nil];
    });
}

#pragma mark - EKEventEditViewDelegate

- (void)eventEditViewController:(EKEventEditViewController *)controller
                    didCompleteWithAction:(EKEventEditViewAction)action
{
    [controller dismissViewControllerAnimated:YES completion:nil];

    self.eventController = nil;
    self.eventStore = nil;
}

@end
