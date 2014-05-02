//
//  XDSendLocationViewController.m
//  leCar
//
//  Created by dujiepeng on 14-4-15.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "SendLocationViewController.h"
#import "UIViewController+HUD.h"
#import "BMapKit.h"

@interface SendLocationViewController () <BMKMapViewDelegate,BMKSearchDelegate>{
    BMKMapView *_mapView;
    BMKSearch *_search;
}

@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic, strong) NSString * currentAddress;

@end

@implementation SendLocationViewController

+(instancetype)sendLocation{
    SendLocationViewController *locationVC = [[SendLocationViewController alloc] init];
    return locationVC;
}

+(instancetype)readLocation:(CLLocation *)location
                    address:(NSString *)address{
    SendLocationViewController *locationVC = [[SendLocationViewController alloc] init];
    locationVC.currentAddress = address;
    locationVC.latitude = location.coordinate.latitude;
    locationVC.longitude = location.coordinate.longitude;
    return locationVC;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"位置信息";
    _mapView = [[BMKMapView alloc] initWithFrame:self.view.bounds];
    _mapView.zoomLevel = 19;
    [self.view addSubview:_mapView];
    
    if (_currentAddress && _latitude == 0 && _longitude == 0)
    { // 读取位置使用
        
    }else
    { // 发送位置使用
        _search = [[BMKSearch alloc] init];
        _search.delegate = self;
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                                  initWithTitle:@"发送"
                                                  style:UIBarButtonItemStylePlain
                                                  target:self
                                                  action:@selector(sendLocation)];
        self.navigationItem.rightBarButtonItem.enabled = NO;
        [self startLocation];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    _mapView.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    _search.delegate = nil;
}

#pragma mark - actions
-(void)startLocation
{
    NSLog(@"进入普通定位态");
    [self showHudInView:self.view hint:@"正在定位..."];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
}

-(void)sendLocation{
    if (_delegate && [_delegate respondsToSelector:@selector(sendLocationLatitude:longitude:andAddress:)]) {
        [_delegate sendLocationLatitude:_latitude
                              longitude:_longitude
                             andAddress:_currentAddress];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - BMKMapViewDelegate
/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)mapViewWillStartLocatingUser:(BMKMapView *)mapView
{
	NSLog(@"start locate");
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)mapViewDidStopLocatingUser:(BMKMapView *)mapView
{
    NSLog(@"stop locate");
}

/**
 *用户位置更新后，会调用此函数
 *@param mapView 地图View
 *@param userLocation 新的用户位置
 */

- (void)mapView:(BMKMapView *)mapView
didUpdateUserLocation:(BMKUserLocation *)userLocation{
    [self hideHud];
    if (userLocation) {
        CLLocationCoordinate2D pt = (CLLocationCoordinate2D)
        {userLocation.location.coordinate.latitude,
            userLocation.location.coordinate.longitude};
        [_search reverseGeocode:pt];
    }
}

#pragma mark - BMKSearchDelegate
- (void)onGetAddrResult:(BMKSearch*)searcher
                 result:(BMKAddrInfo*)result
              errorCode:(int)error
{
    _latitude = result.geoPt.latitude;
    _longitude = result.geoPt.longitude;
    _currentAddress = result.strAddr;
    self.navigationItem.rightBarButtonItem.enabled = YES;
}


/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)mapView:(BMKMapView *)mapView
didFailToLocateUserWithError:(NSError *)error{
    // 定位失败提示
//    TTAlertNoTitle(@"定位失败，请重试");
}

-(void)dealloc{
    _mapView = nil;
    _search = nil;
}

@end
