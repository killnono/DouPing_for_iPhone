//
//  EGORefreshTableHeaderView.m
//  Demo
//
//  Created by Devin Doty on 10/14/09October14.
//  Copyright 2009 enormego. All rights reserved.
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

#import "EGORefreshTableHeaderView.h"


//#define TEXT_COLOR	 [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]
#define TEXT_COLOR   [UIColor blackColor]
#define FLIP_ANIMATION_DURATION 0.18f

//私有方法
@interface EGORefreshTableHeaderView (Private)
- (void)setState:(EGOPullRefreshState)aState;
@end

@implementation EGORefreshTableHeaderView

@synthesize delegate=_delegate;


- (id)initWithFrame:(CGRect)frame 
{
    if (self = [super initWithFrame:frame]) 
    {
		
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		//self.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0];
        self.backgroundColor=[UIColor clearColor];
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 30.0f, self.frame.size.width, 20.0f)];
		label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		label.font = [UIFont systemFontOfSize:12.0f];
		label.textColor = TEXT_COLOR;
		label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		label.shadowOffset = CGSizeMake(0.0f, 1.0f);
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = NSTextAlignmentCenter;
		[self addSubview:label];
		_lastUpdatedLabel=label;
        [label release];
       
		
		label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 48.0f, self.frame.size.width, 20.0f)];
		label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		label.font = [UIFont boldSystemFontOfSize:13.0f];
		label.textColor = TEXT_COLOR;
		label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		label.shadowOffset = CGSizeMake(0.0f, 1.0f);
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = NSTextAlignmentCenter;
		[self addSubview:label];
		_statusLabel=label;
		[label release];
		CALayer *layer = [CALayer layer];
		layer.frame = CGRectMake(25.0f, frame.size.height - 65.0f, 30.0f, 55.0f);
		layer.contentsGravity = kCAGravityResizeAspect;
		layer.contents = (id)[UIImage imageNamed:@"blackArrow.png"].CGImage;
		
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
		if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) 
        {
			layer.contentsScale = [[UIScreen mainScreen] scale];
		}
#endif
		
		[[self layer] addSublayer:layer];
		_arrowImage=layer;
		
		UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		view.frame = CGRectMake(25.0f, frame.size.height - 38.0f, 20.0f, 20.0f);
		[self addSubview:view];
		_activityView = view;
		
		
		[self setState:EGOOPullRefreshNormal];
	
    }
	
    return self;
	
}


#pragma mark -
#pragma mark Setters
//返回时间的一个方法
- (void)refreshLastUpdatedDate 
{
	
	if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceLastUpdated:)]) 
    {
		//一定要用代理方法吗？直接创建一个data不行吗？
        //经过实验证明，直接创建不行，没有返回值，时间无法显示，为什么？
        //NSDate *date = [NSData data];
		NSDate *date = [_delegate egoRefreshTableHeaderDataSourceLastUpdated:self];
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setAMSymbol:@"AM"];
		[formatter setPMSymbol:@"PM"];
		[formatter setDateFormat:@"MM/dd/yyyy hh:mm:a"];
		_lastUpdatedLabel.text = [NSString stringWithFormat:@"上次刷新时间: %@", [formatter stringFromDate:date]];
        //这两句什么意思？
        //一个单例？
		[[NSUserDefaults standardUserDefaults] setObject:_lastUpdatedLabel.text forKey:@"EGORefreshTableView_LastRefresh"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		[formatter release];
	} else 
    {
		
		_lastUpdatedLabel.text = nil;
		
	}

}

//设置状态
- (void)setState:(EGOPullRefreshState)aState
{
	
	switch (aState) 
    {
		case EGOOPullRefreshPulling:
			
			_statusLabel.text = NSLocalizedString(@"松手刷新", @"Release to refresh status");
            //这应该是个动画
			[CATransaction begin];
			[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
			_arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
			[CATransaction commit];			
			break;
            
		case EGOOPullRefreshNormal:
			
			if (_state == EGOOPullRefreshPulling) 
            {
				[CATransaction begin];
				[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
				_arrowImage.transform = CATransform3DIdentity;
				[CATransaction commit];
			}
			
			_statusLabel.text = NSLocalizedString(@"下拉刷新", @"Pull down to refresh status");
			[_activityView stopAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
			_arrowImage.hidden = NO;
			_arrowImage.transform = CATransform3DIdentity;
			[CATransaction commit];
			
            //加载时间
			[self refreshLastUpdatedDate];			
			break;
            
		case EGOOPullRefreshLoading:
			
			_statusLabel.text = NSLocalizedString(@"正在刷新", @"Loading Status");
			[_activityView startAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
			_arrowImage.hidden = YES;
			[CATransaction commit];			
			break;
            
		default:
			break;
	}
	
	_state = aState;
}


#pragma mark -
#pragma mark ScrollView Methods

//这个方法个由RootVC在他自己的代理方法中调用
//方法的具体实现有本Contrtoller来实现
- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView 
{	
	//当正在拖动屏幕是，检查state的状态
    //如果是正在刷新状态，这个if里面的东西没看懂.....
	if (_state == EGOOPullRefreshLoading)
    {
		CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
		offset = MIN(offset, 60);
		scrollView.contentInset = UIEdgeInsetsMake(offset, 0.0f, 0.0f, 0.0f);
		
	} 
    //如果不是正在刷新状态，并且是正在正在拖动状态
    //后面的if条件可用不用，这里用是为了再次确认是刷新状态
    else if (scrollView.isDragging) 
    {
		//定义一个loading变量
		BOOL _loading = NO;
        //检查代理方法可用
		if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceIsLoading:)])
        {
            //查询当前loading状态，此为代理方法，返回值在RootVC中给出
            //此处的_delegate就是RootVC的对象
            //egoRefreshTableHeaderDataSourceIsLoading是RootVC的方法
            //此处用代理方法主要是为了获得RootVC里面的loading值，这种传值实现的方法很多
			_loading = [_delegate egoRefreshTableHeaderDataSourceIsLoading:self];
		}
		
        //如果在EGOOPullRefreshPulling状态下，拖动距离小于预订距离，即返回正常状态
		if (_state == EGOOPullRefreshPulling && scrollView.contentOffset.y > -65.0f && scrollView.contentOffset.y < 0.0f && _loading == NO)
        {
			[self setState:EGOOPullRefreshNormal];
		} 
        //当拉这往下到一定的距离时，变成正在刷新状态
        //也有的应用设置为松手开始刷新，自己实现一下
        else if (_state == EGOOPullRefreshNormal && scrollView.contentOffset.y < -65.0f && !_loading)
        {
            //设置状态为 正在拖动屏幕，且拖动已经超过预定距离，松手即可进入刷新状态
			[self setState:EGOOPullRefreshPulling];
		}
		
        //这个判断的功能没看懂，
        //好像是对于边界的一个判断
        //用于边界的对齐？
		if (scrollView.contentInset.top != 0) 
        {
			scrollView.contentInset = UIEdgeInsetsZero;
		}
		
	}
	
}
//这个方法个由RootVC在他自己的代理方法中调用
//方法的具体实现有本Contrtoller来实现
- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView 
{
	
	BOOL _loading = NO;
	if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceIsLoading:)])
    {
        //查询当前loading状态
		_loading = [_delegate egoRefreshTableHeaderDataSourceIsLoading:self];
	}
	//如果拖动超过预定距离并且 没有在loading状态
	if (scrollView.contentOffset.y <= - 65.0f && !_loading)
    {
		
		if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDidTriggerRefresh:)]) 
        {
            //代理方法实现在RootVC，功能为刷新tableview
            //延迟10秒钟 收回TableHeaderView的动画
			[_delegate egoRefreshTableHeaderDidTriggerRefresh:self];
		}
		//设置为正在刷新状态
		[self setState:EGOOPullRefreshLoading];
        
        //此处为 将拖拽超出的地方向上升起的动画
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3];
		scrollView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
		[UIView commitAnimations];
		
	}
	
}
//延迟10秒钟 收回TableHeaderView的动画
//需要延迟的一些效果或者方法可用单独写，然后用代理方法来调用
- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView 
{	
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	[scrollView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
	[UIView commitAnimations];
	
	[self setState:EGOOPullRefreshNormal];

}


#pragma mark -
#pragma mark Dealloc

- (void)dealloc 
{
	
	_delegate=nil;
	_activityView = nil;
	_statusLabel = nil;
	_arrowImage = nil;
	_lastUpdatedLabel = nil;
    [super dealloc];
}


@end
