//
//  HLSNotifications.m
//  CoconutKit
//
//  Created by Samuel DEFAGO on 09.06.10.
//  Copyright 2010 Hortis. All rights reserved.
//

#import "HLSNotifications.h"

#import "HLSLogger.h"

#pragma mark -
#pragma mark NotificationSender class interface

/**
 * Class encapsulation information related to the sender of a notification (i.e. sender's identity
 * and notification)
 *
 * Designated initializer: -initWithObject:forNotificationName:
 */
@interface NotificationSender : NSObject {
@private
    NSString *m_notificationName;
    id m_object;
}

- (id)initWithNotificationName:(NSString *)notificationName forObject:(id)object;

@property (nonatomic, retain) NSString *notificationName;
@property (nonatomic, assign) id object;

@end

#pragma mark -
#pragma mark HLSNotificationConverter class interface extension

@interface HLSNotificationConverter ()

@property (nonatomic, retain) NSMutableDictionary *objectToNotificationMap;

- (NSString *)buildIdentifierForObject:(id)object;

- (void)convertNotification:(NSNotification *)notification;

@end

#pragma mark -
#pragma mark HLSNotificationManager class implementation

@implementation HLSNotificationManager

#pragma mark Class methods

+ (HLSNotificationManager *)sharedNotificationManager
{
    static HLSNotificationManager *s_instance = nil;
    
    if (! s_instance) {
        s_instance = [[HLSNotificationManager alloc] init];
    }
    return s_instance;
}

#pragma mark Object creation and destruction

- (id)init
{
    if ((self = [super init])) {
        m_networkActivityCount = 0;
    }
    return self;
}

#pragma mark Activity notification

- (void)notifyBeginNetworkActivity
{
    ++m_networkActivityCount;
    
    HLSLoggerDebug(@"Network activity counter is now %d", m_networkActivityCount);
    
    if (m_networkActivityCount == 1) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
}

- (void)notifyEndNetworkActivity
{
    if (m_networkActivityCount == 0) {
        HLSLoggerWarn(@"Warning: Notifying the end of a network activity which has not been started");
        return;
    }
    
    --m_networkActivityCount;
    
    HLSLoggerDebug(@"Network activity counter is now %d", m_networkActivityCount);
    
    if (m_networkActivityCount == 0) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;        
    }
}

@end

#pragma mark -
#pragma mark NotificationSender class implementation

@implementation NotificationSender

#pragma mark Object creation and destruction

- (id)initWithNotificationName:(NSString *)notificationName forObject:(id)object
{
    if ((self = [super init])) {
        self.notificationName = notificationName;
        self.object = object;
    }
    return self;
}

- (void)dealloc
{
    self.notificationName = nil;
    self.object = nil;
    [super dealloc];
}

#pragma mark Accessors and mutators

@synthesize notificationName = m_notificationName;

@synthesize object = m_object;

@end

#pragma mark -
#pragma mark HLSNotificationConverter class implementation

@implementation HLSNotificationConverter

#pragma mark Class methods

+ (HLSNotificationConverter *)sharedNotificationConverter
{
    static HLSNotificationConverter *s_instance = nil;
    
    if (! s_instance) {
        s_instance = [[HLSNotificationConverter alloc] init];
    }
    return s_instance;
}

#pragma mark Object creation and destruction

- (id)init
{
    if ((self = [super init])) {
        self.objectToNotificationMap = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)dealloc
{
    self.objectToNotificationMap = nil;
    [super dealloc];
}

#pragma mark Accessors and mutators

@synthesize objectToNotificationMap = m_objectToNotificationMap;

#pragma mark (Un)registering conversion rules

- (void)convertNotificationWithName:(NSString *)notificationNameFrom
                       sentByObject:(id)objectFrom
           intoNotificationWithName:(NSString *)notificationNameTo
                       sentByObject:(id)objectTo
{
    // If no object, nothing to do
    if (! objectFrom) {
        return;
    }
    
    // Build the emitter identifier
    NSString *fromIdentifier = [self buildIdentifierForObject:objectFrom];
    
    // Get the associated notification map, or create it if it does not exist
    NSMutableDictionary *notificationMap = [self.objectToNotificationMap objectForKey:fromIdentifier];
    if (! notificationMap) {
        notificationMap = [[[NSMutableDictionary alloc] initWithCapacity:1] autorelease];
        [self.objectToNotificationMap setObject:notificationMap forKey:fromIdentifier];
    }
    
    // If the rule already exists, nothing to do
    if ([notificationMap objectForKey:notificationNameFrom]) {
        return;
    }
    
    // Create the rule object describing the new receiver
    NotificationSender *toSender = [[[NotificationSender alloc] initWithNotificationName:notificationNameTo
                                                                               forObject:objectTo]
                                    autorelease];
    
    // Add the new rule
    [notificationMap setObject:toSender forKey:notificationNameFrom];
    
    // Register the converter to trap the notification sent by objectFrom and to convert it into the
    // notification sent by objectTo
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(convertNotification:)
                                                 name:notificationNameFrom 
                                               object:objectFrom];
    
    HLSLoggerDebug(@"Added conversion rule for (%@, %p) into (%@, %p)", notificationNameFrom,
                   objectFrom, notificationNameTo, objectTo);
}

// TODO: Warning! Does not work correctly for dictionaries (should iterate over the values, not the keys, which is the default
//       for each behavior for dictionaries)
- (void)convertNotificationWithName:(NSString *)notificationNameFrom
           sentByObjectInCollection:(id<NSFastEnumeration>)collectionFrom
           intoNotificationWithName:(NSString *)notificationNameTo
                       sentByObject:(id)objectTo
{
    for (id objectFrom in collectionFrom) {
        [[HLSNotificationConverter sharedNotificationConverter] convertNotificationWithName:notificationNameFrom 
                                                                               sentByObject:objectFrom
                                                                   intoNotificationWithName:notificationNameTo 
                                                                               sentByObject:objectTo];
    }
}

- (void)removeConversionsFromObject:(id)objectFrom
{
    // If no object, nothing to do
    if (! objectFrom) {
        return;
    }
    
    // Build the emitter identifier
    NSString *fromIdentifier = [self buildIdentifierForObject:objectFrom];
    
    // Get all associated rules
    NSMutableDictionary *notificationMap = [self.objectToNotificationMap objectForKey:fromIdentifier];
    
    // If no rules, nothing to do
    if (! notificationMap) {
        return;
    }
    
    // Unregister the converter completely for this object notifications
    NSArray *notificationNames = [notificationMap allKeys];
    for (NSString *notificationName in notificationNames) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:notificationName object:objectFrom];
    }
    
    // Remove all rules
    [self.objectToNotificationMap removeObjectForKey:fromIdentifier];
    
    HLSLoggerDebug(@"Removed all conversions for object %p", objectFrom);
}

- (void)removeConversionsFromObjectsInCollection:(id<NSFastEnumeration>)collectionFrom
{
    for (id objectFrom in collectionFrom) {
        [[HLSNotificationConverter sharedNotificationConverter] removeConversionsFromObject:objectFrom];
    } 
}

#pragma mark Creating a unique string identifier for indexing the dictionary

- (NSString *)buildIdentifierForObject:(id)object
{
    // Since a pointer is unique, this is guaranteed to be unique
    return [NSString stringWithFormat:@"%p", object];
}

#pragma mark Notification conversion callback

- (void)convertNotification:(NSNotification *)notification
{
    // Build the emitter identifier
    NSString *fromIdentifier = [self buildIdentifierForObject:notification.object];
    
    // Locate the conversion rule to apply
    NotificationSender *sender = [[self.objectToNotificationMap objectForKey:fromIdentifier] 
                                  objectForKey:notification.name];
    
    // We should never be trapped here if no conversion rule exists; but stay defensive anyway
    if (! sender) {
        HLSLoggerWarn(@"Notification conversion remains registered with NSNotificationCenter for object %@ "
                      "and notification %@, but should not be", fromIdentifier, notification.name);
        return;
    }
    
    // As given by the rule, emit another notification on behalf of another object
    NSNotification *newNotification = [NSNotification notificationWithName:sender.notificationName 
                                                                    object:sender.object
                                                                  userInfo:notification.userInfo];
    [[NSNotificationQueue defaultQueue] enqueueNotification:newNotification
                                               postingStyle:NSPostNow
                                               coalesceMask:NSNotificationCoalescingOnName | NSNotificationCoalescingOnSender
                                                   forModes:nil];
}

@end

#pragma mark -
#pragma mark NSObject extensions

@implementation NSObject (HLSNotificationExtensions)

- (void)postCoalescingNotificationWithName:(NSString *)name userInfo:(NSDictionary *)userInfo
{
    NSNotification *notification = [NSNotification notificationWithName:name 
                                                                 object:self
                                                               userInfo:userInfo];
    [[NSNotificationQueue defaultQueue] enqueueNotification:notification
                                               postingStyle:NSPostNow
                                               coalesceMask:NSNotificationCoalescingOnName | NSNotificationCoalescingOnSender
                                                   forModes:nil];
}

- (void)postCoalescingNotificationWithName:(NSString *)name
{
    [self postCoalescingNotificationWithName:name userInfo:nil];
}

@end

#pragma mark -
#pragma mark NSNotificationCenter extensions

@implementation NSNotificationCenter (HLSNotificationExtensions)

- (void)addObserver:(id)observer selector:(SEL)selector name:(NSString *)name objectsInCollection:(id<NSFastEnumeration>)collection
{
    for (id object in collection) {
        [self addObserver:observer selector:selector name:name object:object];
    }
}

// TODO: Warning! Does not work correctly for dictionaries (should iterate over the values, not the keys, which is the default
//       for each behavior for dictionaries)
- (void)removeObserver:(id)observer name:(NSString *)name objectsInCollection:(id<NSFastEnumeration>)collection
{
    for (id object in collection) {
        [self removeObserver:observer name:name object:object];
    }
}

@end
