//
//  ARC Helper
//
//  Version 2.2
//
//  Created by Nick Lockwood on 05/01/2012.
//  Copyright 2012 Charcoal Design
//
//  Distributed under the permissive zlib license
//  Get the latest version from here:
//
//  https://gist.github.com/1563325
//

#import <Availability.h>
#undef ah_retain
#undef ah_dealloc
#undef ah_autorelease           // autorelease
#undef ah_dealloc               // dealloc
#if __has_feature(objc_arc)
#define ah_retain self
#define ah_release self
#define ah_autorelease self
#define ah_dealloc self
#else
#define ah_retain retain
#define ah_release release
#define ah_autorelease autorelease
#define ah_dealloc dealloc
#undef __bridge
#define __bridge
#undef __bridge_transfer
#define __bridge_transfer
#endif

//  Weak reference support

#import <Availability.h>
#if !__has_feature(objc_arc_weak)
#undef ah_weak
#define ah_weak unsafe_unretained
#undef __ah_weak
#define __ah_weak __unsafe_unretained
#endif

//  Weak delegate support

#import <Availability.h>
#undef ah_weak_delegate
#undef __ah_weak_delegate
#if __has_feature(objc_arc_weak) && \
(!(defined __MAC_OS_X_VERSION_MIN_REQUIRED) || \
__MAC_OS_X_VERSION_MIN_REQUIRED >= __MAC_10_8)
#define ah_weak_delegate weak
#define __ah_weak_delegate __weak
#else
#define ah_weak_delegate unsafe_unretained
#define __ah_weak_delegate __unsafe_unretained
#endif

//  ARC Helper ends