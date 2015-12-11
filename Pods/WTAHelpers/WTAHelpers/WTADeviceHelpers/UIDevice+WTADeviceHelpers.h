//
//  UIDevice+WTADeviceHelpers.h
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

#import <UIKit/UIKit.h>

extern NSString * const WTANetworkInterfaceWiFi;
extern NSString * const WTANetworkInterfaceCellular;
extern NSString * const WTANetworkAddressTypeIPv4;
extern NSString * const WTANetworkAddressTypeIPv6;

@interface UIDevice (WTADeviceHelpers)

/**
 *  Provides a summary of the current device
 *
 *  @return the device summary
 */
- (NSDictionary *)wta_deviceSummary;

/**
 *  Provides and HTML version of the device
 *  summary dictionary for use in support
 *  emails.
 *
 *  @return the HTML device summary
 */
- (NSString *)wta_HTMLDeviceSummary;

/**
 *  Provides a user agent string for use
 *  in HTTP requests.
 *
 *  @return the user agent string
 */
- (NSString *)wta_userAgent;

/**
 *  Provides the SSID, BSSID and SSIDData
 *  for all supported network interfaces.
 *
 *  @return the network info
 */
+ (NSDictionary *)wta_currentNetworkInfo;

/**
 *  Provides a dictionary of all IP address
 *  discovered for both WiFi and cellular
 *  hardware interfaces.
 *
 *  @return ip address for all hardware interfaces
 */
+ (NSDictionary *)wta_currentIPAddresses;

/**
 *  Returns support status for a rear
 *  facing camera.
 *
 *  @return camera support status
 */
+ (BOOL)wta_supportsRearFacingCamera;

/**
 *  Returns support status for auto-focus
 *  camera.
 *
 *  @return camera support status
 */
+ (BOOL)wta_supportsAutoFocus;

@end

@interface NSBundle (WTADeviceHelpers)

/**
 *  Provides the bundle identifier
 *
 *  @return the bundle identifier
 */
- (NSString *)wta_bundleIdentifier;

/**
 *  Provides the bundle version
 *
 *  @return the bundle version
 */
- (NSString *)wta_bundleVersion;

/**
 *  Provides a summary of the bundle
 *
 *  @return the bundle summary
 */
- (NSDictionary *)wta_bundleSummary;

@end
