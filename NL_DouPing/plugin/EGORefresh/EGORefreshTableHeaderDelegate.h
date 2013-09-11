//
//  EGORefreshTableHeaderDelegate.h
//  TableViewPull
//
//  Created by 赢 徐 on 11-12-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EGORefreshTableHeaderView;

@protocol EGORefreshTableHeaderDelegate <NSObject>


- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view;
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view;

@optional
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view;


@end
