//
//  UIDevice+WTADeviceHelpers.m
//  WTADeviceHelpers
//
//  Copyright (c) 2015 WillowTree, Inc.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "UIDevice+WTADeviceHelpers.h"
#import <AVFoundation/AVFoundation.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <net/if.h>

NSString * const WTANetworkInterfaceWiFi = @"en0";
NSString * const WTANetworkInterfaceCellular = @"pdp_ip0";
NSString * const WTANetworkAddressTypeIPv4 = @"ipv4";
NSString * const WTANetworkAddressTypeIPv6 = @"ipv6";

@implementation UIDevice (WTADeviceHelpers)

- (NSDictionary *)wta_deviceSummary
{
    NSMutableDictionary *summary = [NSMutableDictionary dictionary];
    [summary addEntriesFromDictionary:[[NSBundle mainBundle] wta_bundleSummary]];
    [summary addEntriesFromDictionary:[self wta_deviceModel]];
    [summary addEntriesFromDictionary:[self wta_deviceSystemVersion]];
    return summary;
}

- (NSDictionary *)wta_deviceModel
{
    NSString *label = NSLocalizedStringWithDefaultValue(@"DEVICE_MODEL_LABEL_KEY",
                                                        @"DeviceSummary",
                                                        [NSBundle mainBundle],
                                                        @"Model",
                                                        @"Device model summary label");
    
    NSString *value = [self model];
    return [NSDictionary dictionaryWithObject:value forKey:label];
}

- (NSDictionary *)wta_deviceSystemVersion
{
    NSString *label = NSLocalizedStringWithDefaultValue(@"SYSTEM_VERSION_LABEL_KEY",
                                                        @"DeviceSummary",
                                                        [NSBundle mainBundle],
                                                        @"System Version",
                                                        @"System version summary label");
    
    NSString *value = [self systemVersion];
    return [NSDictionary dictionaryWithObject:value forKey:label];
}

- (NSString *)wta_HTMLDeviceSummary
{
    NSMutableString *string = [NSMutableString stringWithString:@"<br/><br/><hr><blockquote>"];
    
    [[self wta_deviceSummary] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [string appendFormat:@"<strong>%@:</strong> %@<br/>",key , obj];
    }];
    
    [string appendString:@"</blockquote>"];
    
    return string;
}

- (NSString *)wta_userAgent
{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *bundleIdentifier = [bundle wta_bundleIdentifier];
    NSString *bundleVersion = [bundle wta_bundleVersion];
    NSNumber *scale = @(UIScreen.mainScreen.scale);
    
    return [NSString stringWithFormat:@"%@/%@ (%@; iOS %@; Scale/%@)",
            bundleIdentifier,
            bundleVersion,
            self.model,
            self.systemVersion,
            scale];
}

+ (NSDictionary *)wta_currentNetworkInfo
{
    NSArray *interfaces = (__bridge_transfer id)CNCopySupportedInterfaces();
    NSMutableDictionary *networkInfo = [NSMutableDictionary dictionaryWithCapacity:interfaces.count];
    for (NSString *interfaceName in interfaces)
    {
        CFStringRef interfaceRef = (__bridge_retained CFStringRef)interfaceName;
        NSDictionary *info = (__bridge_transfer NSDictionary *)CNCopyCurrentNetworkInfo(interfaceRef);
        [networkInfo setValue:info forKey:interfaceName];
    }
    return networkInfo;
}

+ (NSDictionary *)wta_currentIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary new];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(getifaddrs(&interfaces) == 0)
    {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface = interfaces; interface; interface = interface->ifa_next)
        {
            // Move on to next interface if current is not up
            if(!(interface->ifa_flags & IFF_UP))
            {
                continue;
            }
            
            const struct sockaddr_in *addressRaw = (const struct sockaddr_in*)interface->ifa_addr;
            char addressBuffer[MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN)];
            if(addressRaw)
            {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type = nil;
                if(addressRaw->sin_family == AF_INET)
                {
                    if(inet_ntop(AF_INET, &addressRaw->sin_addr, addressBuffer, INET_ADDRSTRLEN))
                    {
                        type = WTANetworkAddressTypeIPv4;
                    }
                }
                else if (addressRaw->sin_family == AF_INET6)
                {
                    const struct sockaddr_in6 *address6Raw = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &address6Raw->sin6_addr, addressBuffer, INET6_ADDRSTRLEN))
                    {
                        type = WTANetworkAddressTypeIPv6;
                    }
                }
                
                NSString *address = [NSString stringWithUTF8String:addressBuffer];
                if(type.length && address.length)
                {
                    NSDictionary *interfaceAddress = @{type: address};
                    [addresses setValue:interfaceAddress forKey:name];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return addresses.count ? addresses : nil;
}

+ (BOOL)wta_supportsRearFacingCamera
{
    NSArray *videoDevices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    BOOL rearFacing = NO;
    
    for (AVCaptureDevice *device in videoDevices)
    {
        if (device.position == AVCaptureDevicePositionBack)
        {
            rearFacing = YES;
        }
    }
    
    return rearFacing;
}

+ (BOOL)wta_supportsAutoFocus
{
    NSArray *videoDevices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    BOOL autoFocus = NO;
    
    for (AVCaptureDevice *device in videoDevices)
    {
        if ([device isFocusModeSupported:AVCaptureFocusModeAutoFocus])
        {
            autoFocus = YES;
        }
    }
    
    return autoFocus;
}

@end


@implementation NSBundle (AMEXWallet_BundleSummary)

- (NSString *)wta_bundleIdentifier;
{
    return self.infoDictionary[(__bridge NSString *)kCFBundleIdentifierKey];
}

- (NSString *)wta_bundleVersion;
{
    return self.infoDictionary[(__bridge NSString *)kCFBundleVersionKey];
}

- (NSDictionary *)wta_bundleSummary
{
    NSMutableDictionary *summary = [NSMutableDictionary new];
    [summary addEntriesFromDictionary:[self wta_applicationVersion]];
    [summary addEntriesFromDictionary:[self wta_applicationBundleName]];
    return summary;
}

- (NSDictionary *)wta_applicationVersion
{
    NSString *label = NSLocalizedStringWithDefaultValue(@"APP_VERSION_LABEL_KEY",
                                                        @"BundleSummary",
                                                        [NSBundle mainBundle],
                                                        @"App Version",
                                                        @"Application version summary label");
    
    NSString *value = [self wta_bundleVersion];
    return [NSDictionary dictionaryWithObject:value forKey:label];
}

- (NSDictionary *)wta_applicationBundleName
{
    NSString *label = NSLocalizedStringWithDefaultValue(@"APP_NAME_LABEL_KEY",
                                                        @"BundleSummary",
                                                        [NSBundle mainBundle],
                                                        @"App Name",
                                                        @"Application name summary label");
    
    NSString *value = [self wta_bundleIdentifier];
    return [NSDictionary dictionaryWithObject:value forKey:label];
}

@end
