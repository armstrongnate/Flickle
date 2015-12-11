//
//  NSArray+FunctionalHelpers.h
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

#import <Foundation/Foundation.h>


@interface NSArray (WTAFunctionalHelpers)

-(NSMutableArray*)wta_mapWithBlock:(id (^)(id))block;

-(void)wta_enumerateWithBlock:(id (^)(id))block;

-(id)wta_reduceWithBlock:(id (^)(id memo, id element))block
                    startValue:(id)memo;

-(id)wta_reduceRightWithBlock:(id (^)(id memo, id element))block
                         startValue:(id)memo;

-(NSMutableArray*)wta_pluckAtKeyPath:(NSString*)keyPath;

-(NSArray*)wta_makeUnique;

-(NSMutableArray*)wta_shuffle;

-(NSArray*)wta_flatten;

-(id)wta_findWithTest:(BOOL (^)(id))test;

-(id)wta_findWithMaximumValue:(NSInteger (^)(id))test;

-(NSMutableArray*)wta_filterWithTest:(BOOL (^)(id))test;

-(NSMutableArray*)wta_rejectWithTest:(BOOL (^)(id))test;

-(BOOL)wta_allPassTest:(BOOL (^)(id))test;

-(BOOL)wta_anyPassTest:(BOOL (^)(id))test;

-(NSDictionary*)wta_groupByKeyFromElement:(id (^)(id))keyFromElement;

-(NSDictionary*)wta_groupByKeyPath:(NSString*)keyPath;

- (NSArray*)wta_arrayByInsertingObject:(id)object atIndex:(NSInteger)index;

@end
