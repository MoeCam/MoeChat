/*!
 @header IDeviceManager.h
 @abstract DeviceManager各类协议的合集
 @author EaseMob Inc.
 @version 1.00 2014/01/01 Creation (1.00)
 */
#import <Foundation/Foundation.h>
#import "internal/IDeviceManagerProximitySensor.h"
#import "internal/IDeviceManagerLocation.h"
#import "internal/IDeviceManagerDevice.h"
#import "internal/IDeviceManagerCamera.h"
#import "internal/IDeviceManagerAudio.h"

/*!
 @protocol
 @abstract DeviceManager各类协议的合集
 @discussion
 */
@protocol IDeviceManager <IDeviceManagerAudio,
                        IDeviceManagerCamera,
                        IDeviceManagerDevice,
                        IDeviceManagerLocation,
                        IDeviceManagerProximitySensor>

@required

#pragma mark - base

/*!
 @method
 @abstract 注册一个监听对象到监听列表中
 @discussion 把监听对象添加到监听列表中准备接收相应的事件
 @param delegate 需要注册的监听对象
 @param aQueue 通知监听对象时的线程
 @result
 */
- (void)addDelegate:(id<IDeviceManagerDelegate>)delegate onQueue:(dispatch_queue_t)aQueue;

/*!
 @method
 @abstract 从监听列表中移除一个监听对象
 @discussion 把监听对象从监听列表中移除,取消接收相应的事件
 @param delegate 需要移除的监听对象
 @result
 */
- (void)removeDelegate:(id<IDeviceManagerDelegate>)delegate;

#pragma mark - Audio

/*!
 @method
 @abstract 切换音频播放模式
 @param mode 音频播放模式
 @discussion
 @result 是否切换成功
 */
- (BOOL)chooseAudioPlaybackMode:(EMAudioPlaybackMode)mode;

/*!
 @method
 @abstract 在耳机和扩音器之间切换音频播放模式
 @param outputDevice 音频播放模式
 @discussion
 @result 是否切换成功
 */
- (BOOL)switchAudioOutputDevice:(EMAudioOutputDevice)outputDevice;

/*!
 @property
 @abstract 当前音频的播放模式
 */
@property (nonatomic, readonly) EMAudioPlaybackMode currentPlaybackMode;

// flag to indicate if it is playing audio.
/*!
 @property
 @abstract 当前是否正在播放音频
 */
@property (nonatomic, readonly) BOOL isPlayingAudio;

/*!
 @method
 @abstract 收到新消息时, 播放声音
 @discussion
 */
- (void)playNewMessageSound;

/*!
 @method
 @abstract 收到新消息时, 异步播放音频
 @discussion
 @result
 */
- (void)asyncPlayNewMessageSound;

/*!
 @method
 @abstract 收到新消息时, 异步播放音频
 @param completion 播放完成时的回调block
 @param aQueue 回调block时的线程
 @discussion
 @result
 */
- (void)asyncPlayNewMessageWithCompletion:(void (^)(SystemSoundID soundId))completion
                                  onQueue:(dispatch_queue_t)aQueue;

/*!
 @method
 @abstract 新消息到来时, 震动设备
 @discussion
 @result
 */
- (void)playVibration;

/*!
 @method
 @abstract 新消息到来时, 震动设备(异步方法)
 @discussion
 @result
 */
- (void)asyncPlayVibration;

/*!
 @method
 @abstract 新消息到来时, 震动设备(异步方法)
 @param completion 震动完成后的回调block
 @param aQueue 回调block时的线程
 @discussion
 @result
 */
- (void)asyncPlayVibrationWithCompletion:(void (^)(SystemSoundID soundId))completion
                                 onQueue:(dispatch_queue_t)aQueue;

/*!
 @method
 @abstract 检查是否正在播放此语音文件
 @param aFilePath 语音文件的绝对路径
 @result 是否正在播放此语音文件
 */
- (BOOL)isPlayingAudioChat:(NSString *)aFilePath;

/*!
 @method
 @abstract 播放音频(异步线程)
 @discussion 文件应为amr编码
 @param aFilePath 需要播放的音频的完整路径
 @result
 */
- (void)asyncPlayAudio:(NSString *)aFilePath;

/*!
 @method
 @abstract 播放音频(异步线程)
 @param aFilePath 需要播放的音频的完整路径.
 @param completion 震动完成后的回调block
 @param aQueue 回调block时的线程
 @result
 */
- (void)asyncPlayAudio:(NSString *)aFilePath
            completion:(void (^)(EMError *error))completion
               onQueue:(dispatch_queue_t)aQueue;

/*!
 @method
 @abstract 停止当前正在播放的音频
 @discussion
 @result 是否成功停止播放
 */
- (BOOL)stopPlayingAudio;

/*!
 @method
 @abstract 开始录制音频
 @param aFilePath 录制完成后的音频文件保存路径
 @param pError 录制过程中的错误信息
 @discussion
 @result
 */
- (void)startRecordingAudio:(NSString *)aFilePath error:(EMError **)pError;

/*!
 @method
 @abstract 停止录制音频(异步方法),停止后会发送 didRecordAudio 广播,同时会附带录制后保存的文件路径和录制的音频时长
 @discussion
 @result
 */
- (void)asyncStopRecordingAudio;

/*!
 @method
 @abstract 停止录制音频(异步方法),停止后会调用completion block
 @param completion 录制音频完成后的回调block
 @param aQueue 回调block时的线程
 @discussion
 @result
 */
- (void)asyncStopRecordingAudioWithCompletion:(void (^)(NSString *aFilePath,
                                                        NSInteger duration,
                                                        EMError *error))completion
                                      onQueue:(dispatch_queue_t)aQueue;

/*!
 @method
 @abstract 取消录制音频(异步线程), 完成后, 会发送didCancelRecordAudio广播
 @discussion
 @result
 */
- (void)asyncCancelRecordingAudio;

/*!
 @method
 @abstract 取消录制音频(异步线程)
 @param completion 录制音频完成后的回调block
 @param aQueue 回调block时的线程
 @discussion
 @result
 */
- (void)asyncCancelRecordingAudioWithCompletion:(void (^)(NSString *filePath, EMError *error))completion
                                        onQueue:(dispatch_queue_t)aQueue;

/*!
 @method
 @abstract 获取最后一次录音的时长
 @discussion
 @result 音频时长
 */
- (double)peekRecorderVoiceMeter;

/*!
 @method
 @abstract 判断麦克风是否可用
 @return 麦克风是否可用
 */
- (BOOL)checkMicrophoneAvailability;

#pragma mark - proximity sensor

/*!
 @property
 @abstract 当前设备是否支持距离传感器功能
 */
@property (nonatomic, readonly) BOOL isSupportProximitySensor;

/*!
 @property
 @abstract 设备是否正接近用户
 */
@property (nonatomic, readonly) BOOL isCloseToUser;

/*!
 @property
 @abstract 当前设备距离传感器功能是否处于打开状态
 */
@property (nonatomic, readonly) BOOL isProximitySensorEnabled;

/*!
 @method
 @abstract 打开
 @discussion 若设备不支持, 返回NO
 @result 是否成功打开
 */
- (BOOL)enableProximitySensor;

/*!
 @method
 @abstract 关闭
 @discussion 若设备不支持, 返回NO
 @result 是否成功关闭
 */
- (BOOL)disableProximitySensor;

#pragma mark - location

/*!
 @property
 @abstract GPS服务是否可用
 */
@property (nonatomic, readonly) BOOL isLocationServicesEnabled;

/*!
 @property
 @abstract GPS返回的最后一次位置信息
 */
@property (nonatomic, readonly) CLLocation *lastLocation;

/*!
 @method
 @abstract 开始GPS定位
 @discussion
 @result
 */
- (void)startUpdatingLocation;

/*!
 @method
 @abstract 停止GPS定位
 @discussion
 @result
 */
- (void)stopUpdatingLocation;

/*!
 @method
 @abstract 刷新用户的当前位置信息(重新通过GPS去获取)
 @discussion
 @result
 */
- (void)refreshLocation;

/*!
 @method
 @abstract 将经纬度信息解码为城市街道信息(同步方法, 如果在主线程中使用, 会阻塞主线程)暂时只支持中国的火星坐标, 你懂的
 @param latitude 经度
 @param longitude 纬度
 @param pError 错误信息
 @discussion
 @result 解码后的城市街道信息(eg: 中国北京市海淀区中关村彩和坊路)
 */
- (NSString *)decodeAddressFromLatitude:(double)latitude
                           andLongitude:(double)longitude
                                  error:(EMError **)pError;

/*!
 @method
 @abstract 将经纬度信息解码为城市街道信息(异步方法, 解码完成后, 会调用didDecodeAddress 回调方法)暂时只支持中国的火星坐标, 你懂的
 @param latitude 经度
 @param longitude 纬度
 @discussion
 @result
 */
- (void)asyncDecodeAddressFromLatitude:(double)latitude
                          andLongitude:(double)longitude;

/*!
 @method
 @abstract 将经纬度信息解码为城市街道信息(异步方法)暂时只支持中国的火星坐标, 你懂的
 @param latitude 经度
 @param longitude 纬度
 @param completion 解码完成后的回调block
 @param queue 回调block时的线程
 @discussion
 @result
 */
- (void)asyncDecodeAddressFromLatitude:(double)latitude
                          andLongitude:(double)longitude
                            completion:(void (^)(NSString *address, EMError *))completion
                               onQueue:(dispatch_queue_t)queue;

/**
 *	@brief	世界标准地理坐标(WGS-84) 转换成 中国国测局地理坐标（GCJ-02）<火星坐标>
 *
 *  ####只在中国大陆的范围的坐标有效，以外直接返回世界标准坐标
 *
 *	@param 	location 	世界标准地理坐标(WGS-84)
 *
 *	@return	中国国测局地理坐标（GCJ-02）<火星坐标>
 */
+ (CLLocationCoordinate2D)wgs84ToGcj02:(CLLocationCoordinate2D)location;

/**
 *	@brief	中国国测局地理坐标（GCJ-02） 转换成 世界标准地理坐标（WGS-84）
 *
 *  ####此接口有1－2米左右的误差，需要精确定位情景慎用
 *
 *	@param 	location 	中国国测局地理坐标（GCJ-02）
 *
 *	@return	世界标准地理坐标（WGS-84）
 */
+ (CLLocationCoordinate2D)gcj02ToWgs84:(CLLocationCoordinate2D)location;

/**
 *	@brief	世界标准地理坐标(WGS-84) 转换成 百度地理坐标（BD-09)
 *
 *	@param 	location 	世界标准地理坐标(WGS-84)
 *
 *	@return	百度地理坐标（BD-09)
 */
+ (CLLocationCoordinate2D)wgs84ToBd09:(CLLocationCoordinate2D)location;

/**
 *	@brief	中国国测局地理坐标（GCJ-02）<火星坐标> 转换成 百度地理坐标（BD-09)
 *
 *	@param 	location 	中国国测局地理坐标（GCJ-02）<火星坐标>
 *
 *	@return	百度地理坐标（BD-09)
 */
+ (CLLocationCoordinate2D)gcj02ToBd09:(CLLocationCoordinate2D)location;

/**
 *	@brief	百度地理坐标（BD-09) 转换成 中国国测局地理坐标（GCJ-02）<火星坐标>
 *
 *	@param 	location 	百度地理坐标（BD-09)
 *
 *	@return	中国国测局地理坐标（GCJ-02）<火星坐标>
 */
+ (CLLocationCoordinate2D)bd09ToGcj02:(CLLocationCoordinate2D)location;

/**
 *	@brief	百度地理坐标（BD-09) 转换成 世界标准地理坐标（WGS-84）
 *
 *  ####此接口有1－2米左右的误差，需要精确定位情景慎用
 *
 *	@param 	location 	百度地理坐标（BD-09)
 *
 *	@return	世界标准地理坐标（WGS-84）
 */
+ (CLLocationCoordinate2D)bd09ToWgs84:(CLLocationCoordinate2D)location;

#pragma mark - device

/*!
 @property
 @abstract 当前系统的版本号(eg: 7.0)
 */
@property (nonatomic, readonly) float deviceVersion;

/*!
 @property
 @abstract 当前设备的唯一标识
 */
@property (nonatomic, readonly) NSString *uniqueId;

/*!
 @property
 @abstract
 */
@property (nonatomic, readonly) NSString *compactUniqueId;

#pragma mark - camera

/*!
 @method
 @abstract 检查摄像头是否可用
 @return 摄像头是否可用
 */
- (BOOL)checkCameraAvailability;

@end
