#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface SBStatusBarDataManager : NSObject
+(id)sharedDataManager;
-(id)init;
-(void)dealloc;
-(void)beginUpdateBlock;
-(void)endUpdateBlock;
-(void)setStatusBarItem:(int)arg1 enabled:(BOOL)arg2;
-(void)setStatusBarItem:(int)arg1 cloaked:(BOOL)arg2;
-(void)updateStatusBarItem:(int)arg1;
-(void)sendStatusBarActions:(int)arg1;
-(void)enableLock:(BOOL)arg1 time:(BOOL)arg2;
-(void)setShowsActivityIndicatorOnHomeScreen:(BOOL)arg1;
-(void)setTelephonyAndBluetoothItemsCloaked:(BOOL)arg1;
-(void)setAllItemsExceptBatteryCloaked:(BOOL)arg1;
-(void)setThermalColor:(int)arg1 sunlightMode:(BOOL)arg2;
-(void)_initializeData;
-(void)_dataChanged;
-(void)_postData;
-(void)_updateTimeString;
-(void)_updateTimeItem;
-(void)_updateAirplaneMode;
-(void)_updateSignalStrengthItem;
-(void)_updateServiceItem;
-(void)_updateDataNetworkItem;
-(void)_updateBatteryItem;
-(void)_updateBatteryPercentItem;
-(void)_updateNotChargingItem;
-(void)_updateBluetoothItem;
-(void)_updateBluetoothBatteryItem;
-(void)_updateTTYItem;
-(void)_updateVPNItem;
-(void)_updateCallForwardingItem;
-(void)_updateActivityItem;
-(void)_updatePlayItem;
-(void)_updateLocationItem;
-(void)_updateRotationLockItem;
-(void)_updateThermalColorItem;
-(void)_registerForNotifications;
-(void)_significantTimeOrLocaleChange;
-(void)_didWakeFromSleep;
-(void)_batteryStatusChange;
-(void)_notChargingStatusChange;
-(void)_operatorChange;
-(void)_signalStrengthChange;
-(void)_ttyChange;
-(void)_callForwardingChange;
-(void)_vpnChange;
-(void)_dataNetworkChange;
-(void)airplaneModeChanged;
-(void)_bluetoothChange;
-(void)_bluetoothBatteryChange;
-(void)_locationStatusChange;
-(void)_rotationLockChange;
-(void)_configureTimeItemDateFormatter;
-(void)_stopTimeItemTimer;
-(void)_restartTimeItemTimer;
-(BOOL)_shouldShowNotChargingItem;
-(void)_updateNotChargingItemAfterDelay;
-(void)_updateTelephonyState;
-(void)toggleSimulatesInCallStatusBar;
-(id)_displayStringForSIMStatus:(id)arg1;
-(id)_displayStringForRegistrationStatus:(int)arg1;
@end

// fixed: now works as SBStatusBarDataManager updates percentage
%hook SBStatusBarDataManager

-(void)_updateBatteryPercentItem
{
    %log;
    
    UIDevice *dev = [UIDevice currentDevice]; 
    
    [dev setBatteryMonitoringEnabled:YES]; 
    
    int batLeft = (int)([dev batteryLevel]*100); 
    
    NSLog(@"battery Left: %d", batLeft);
    
    if (batLeft < 20)
    {
        [self setThermalColor:2 sunlightMode:NO];
    }
    
    %orig;
}


%end
