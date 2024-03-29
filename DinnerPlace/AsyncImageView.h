//
//  AsyncImageView.h
//
//  Version 1.3
//
//  Created by Nick Lockwood on 03/04/2011.
//  Copyright (c) 2011 Charcoal Design
//
//  Distributed under the permissive zlib License
//  Get the latest version from either of these locations:
//
//  http://charcoaldesign.co.uk/source/cocoa#asyncimageview
//  https://github.com/nicklockwood/AsyncImageView
//
//  This software is provided 'as-is', without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//  claim that you wrote the original software. If you use this software
//  in a product, an acknowledgment in the product documentation would be
//  appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//  misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.
//

//
//  ARC Helper
//
//  Version 2.1
//
//  Created by Nick Lockwood on 05/01/2012.
//  Copyright 2012 Charcoal Design
//
//  Distributed under the permissive zlib license
//  Get the latest version from here:
//
//  https://gist.github.com/1563325
//

#ifndef ah_retain
#if __has_feature(objc_arc)
#define ah_retain self
#define ah_dealloc self
#define release self
#define autorelease self
#else
#define ah_retain retain
#define ah_dealloc dealloc
#define __bridge
#endif
#endif

//  ARC Helper ends


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


#pragma mark Const Object

extern NSString *const AsyncImageLoadDidFinish;
extern NSString *const AsyncImageLoadDidFail;

extern NSString *const AsyncImageImageKey;
extern NSString *const AsyncImageURLKey;
extern NSString *const AsyncImageCacheKey;
extern NSString *const AsyncImageErrorKey;

#pragma mark AsyncImageCache

@interface AsyncImageCache : NSObject

+ (AsyncImageCache *)sharedCache;

@property (nonatomic, assign) BOOL       useImageNamed;
@property (nonatomic, assign) NSUInteger countLimit;

- (UIImage *)imageForURL:(NSURL *)URL;
- (void)setImage:(UIImage *)image forURL:(NSURL *)URL;
- (void)removeImageForURL:(NSURL *)URL;
- (void)clearCache;

@end

#pragma mark AsyncImageLoader

@interface AsyncImageLoader : NSObject

+ (AsyncImageLoader *)sharedLoader;

@property (nonatomic, strong) AsyncImageCache *cache;

@property (nonatomic, assign) NSUInteger     concurrentLoads;
@property (nonatomic, assign) NSTimeInterval loadingTimeout;

- (void)loadImageWithURL:(NSURL *)URL target:(id)target success:(SEL)success failure:(SEL)failure;
- (void)loadImageWithURL:(NSURL *)URL target:(id)target action:(SEL)action;
- (void)loadImageWithURL:(NSURL *)URL;
- (void)cancelLoadingURL:(NSURL *)URL target:(id)target action:(SEL)action;
- (void)cancelLoadingURL:(NSURL *)URL target:(id)target;
- (void)cancelLoadingURL:(NSURL *)URL;

- (void)cancelLoadingImagesForTarget:(id)target action:(SEL)action;
- (void)cancelLoadingImagesForTarget:(id)target;
- (NSURL *)URLForTarget:(id)target action:(SEL)action;
- (NSURL *)URLForTarget:(id)target;

@end

#pragma mark UIImageView(AsyncImageView)

@interface UIImageView(AsyncImageView)

@property (nonatomic, strong) NSURL *imageURL;

@end


@interface AsyncImageView : UIImageView

@property (nonatomic, assign) BOOL showActivityIndicator;
@property (nonatomic, assign) BOOL crossfadeImages;

@property (nonatomic, assign) NSTimeInterval               crossfadeDuration;
@property (nonatomic, assign) UIActivityIndicatorViewStyle activityIndicatorStyle;

@end
