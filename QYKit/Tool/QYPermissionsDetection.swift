/*******************************************************************************
Copyright (K), 2019 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/MemoryKing
********************************************************************************/


import Photos
import AssetsLibrary
import MediaPlayer
import CoreTelephony
import CoreLocation
import AVFoundation

public class QYPermissionsDetection {
    // MARK: - 开启媒体资料库/Apple Music 服务
    /// 开启媒体资料库/Apple Music 服务
    @available(iOS 9.3, *)
    class func yi_openMediaPlayerServiceWithBlock(action :@escaping ((Bool)->())) {
        var isOpen = false
        let authStatus = MPMediaLibrary.authorizationStatus()
        if authStatus == MPMediaLibraryAuthorizationStatus.notDetermined {
            MPMediaLibrary.requestAuthorization { (status) in
                if (status == MPMediaLibraryAuthorizationStatus.authorized) {
                    isOpen = true
                }
            }
        } else if authStatus == MPMediaLibraryAuthorizationStatus.authorized {
                isOpen = true
        } else {
            isOpen = false
        }
        DispatchQueue.main.async {
            action(isOpen)
        }
    }

    // MARK: - 检测是否开启联网
    /// 检测是否开启联网
    class func yi_openEventServiceWithBolck(action :@escaping ((Bool)->())) {
        let cellularData = CTCellularData()
        var isOpen = false
        cellularData.cellularDataRestrictionDidUpdateNotifier = { (state) in
            if !(state == CTCellularDataRestrictedState.restrictedStateUnknown ||  state == CTCellularDataRestrictedState.notRestricted) {
                isOpen = true
            }
        }
        let state = cellularData.restrictedState
        if !(state == CTCellularDataRestrictedState.restrictedStateUnknown ||  state == CTCellularDataRestrictedState.notRestricted) {
            isOpen = true
        }
        DispatchQueue.main.async {
            action(isOpen)
        }
    }

    // MARK: - 检测是否开启定位
    /// 检测是否开启定位
    class func yi_openLocationServiceWithBlock(action :@escaping ((Bool)->())) {
        var isOpen = false
        if CLLocationManager.locationServicesEnabled() || CLLocationManager.authorizationStatus() != .denied {
            isOpen = true
        }
        DispatchQueue.main.async {
            action(isOpen)
        }
    }

    // MARK: - 检测是否开启摄像头
    /// 检测是否开启摄像头 (可用)
    class func yi_openCaptureDeviceServiceWithBlock(action :@escaping ((Bool)->())) {
        var isOpen = false
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        if authStatus == AVAuthorizationStatus.notDetermined {
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { (granted) in
                isOpen = granted
            }
        } else if authStatus == AVAuthorizationStatus.restricted || authStatus == AVAuthorizationStatus.denied {
            isOpen = false
        } else {
            isOpen = true
        }
        DispatchQueue.main.async {
            action(isOpen)
        }
    }
    // MARK: - 检测是否开启相册
    /// 检测是否开启相册
    class func yi_openAlbumServiceWithBlock(action :@escaping ((Bool)->())) {
        var isOpen = true
        let authStatus = PHPhotoLibrary.authorizationStatus()
        if authStatus == PHAuthorizationStatus.restricted || authStatus == PHAuthorizationStatus.denied {
            isOpen = false;
        }
        DispatchQueue.main.async {
            action(isOpen)
        }
    }

    // MARK: - 检测是否开启麦克风
    /// 检测是否开启麦克风
    class func yi_openRecordServiceWithBlock(action :@escaping ((Bool)->())) {
        var isOpen = false
        let permissionStatus = AVAudioSession.sharedInstance().recordPermission
        if permissionStatus == AVAudioSession.RecordPermission.undetermined {
            AVAudioSession.sharedInstance().requestRecordPermission { (granted) in
                isOpen = granted
            }
        } else if permissionStatus == AVAudioSession.RecordPermission.denied || permissionStatus == AVAudioSession.RecordPermission.undetermined{
            isOpen = false
        } else {
            isOpen = true
        }
        DispatchQueue.main.async {
            action(isOpen)
        }
    }
    // MARK: - 跳转系统设置界面
    ///跳转系统设置界面
    class func yi_OpenPermissionsSetting() {
        let url = URL(string: UIApplication.openSettingsURLString)
        let alertController = UIAlertController(title: "访问受限",
                                                message: "点击“设置”，允许访问权限",
                                                preferredStyle: .alert)
        let cancelAction = UIAlertAction(title:"取消", style: .cancel, handler:nil)
        let settingsAction = UIAlertAction(title:"设置", style: .default, handler: {
            (action) -> Void in
            if  UIApplication.shared.canOpenURL(url!) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url!, options: [:],completionHandler: {(success) in})
                } else {
                    UIApplication.shared.openURL(url!)
                }
            }
        })
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }

}
