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
                                location:(NSString * _Nullable)location
                                repeatOptions:(NSDictionary * _Nullable)options)
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
      
        if(options){
          [self applyRecurrence:options toEvent:event];
        }

        self.eventController = [[EKEventEditViewController alloc] init];
        self.eventController.eventStore = self.eventStore;
        self.eventController.event = event;
        self.eventController.editViewDelegate = self;

        UIViewController *root = RCTPresentedViewController();
        [root presentViewController:self.eventController animated:YES completion:nil];
    });
}

#pragma mark - Recurrence

- (void)applyRecurrence:(NSDictionary *)repeat toEvent:(EKEvent *)event
{
  NSString *frequencyString = repeat[@"frequency"];
  NSNumber *interval = repeat[@"interval"] ?: @1;
  NSNumber *untilMs = repeat[@"until"];
  
  EKRecurrenceFrequency frequency = [ self recurrenceFrequencyFromString:frequencyString];
  
  EKRecurrenceEnd *end = nil;
  if(untilMs){
    NSDate *untilDate = [NSDate dateWithTimeIntervalSince1970:untilMs.doubleValue / 1000.0];
    end = [EKRecurrenceEnd recurrenceEndWithEndDate:untilDate];
  }
  
  EKRecurrenceRule *rule = [[EKRecurrenceRule alloc] initRecurrenceWithFrequency:frequency interval:interval.integerValue end:end];
  
  event.recurrenceRules = @[rule];
}

- (EKRecurrenceFrequency)recurrenceFrequencyFromString:(NSString *)value
{
  static NSDictionary<NSString *, NSNumber *> *map;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    map = @{
     @"daily": @(EKRecurrenceFrequencyDaily),
     @"weekly": @(EKRecurrenceFrequencyWeekly),
     @"monthly": @(EKRecurrenceFrequencyMonthly),
     @"yearly": @(EKRecurrenceFrequencyYearly),
    };
  });
  
  NSNumber *frequency = map[value];
  return frequency ? (EKRecurrenceFrequency)frequency.integerValue : EKRecurrenceFrequencyDaily;
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
