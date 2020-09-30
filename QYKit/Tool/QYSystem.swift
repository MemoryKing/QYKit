/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/MemoryKing
********************************************************************************/


import Foundation
import UIKit

open class QYSystem: NSObject {
    static let shared = QYSystem()
    ///是否编辑,默认false
    public var allowsEditing: Bool? = false
    
    public var photoBlock: ((UIImage)->())?
    
    //MARK: --- 拨打电话
    ///拨打电话
    public class func yi_openPhone(_ phone: String,
                            _ completion: ((Bool) -> Void)? = nil) {
        if UIApplication.shared.canOpenURL(URL(string: "tel://" + phone)!) {
            UIApplication.shared.open(URL(string: "tel://" + phone)!, options: [:], completionHandler: completion)
        }
    }
    
    //MARK: --- 打开设置
    ///打开设置
    public class func yi_openSettings(_ completion: ((Bool) -> Void)? = nil) {
        let url = URL.init(string: UIApplication.openSettingsURLString)
        if UIApplication.shared.canOpenURL(url!){
            UIApplication.shared.open(url!, options: [:], completionHandler: completion)
        }
    }
}
//MARK: ------- 打开相机相册
extension QYSystem: UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    ///打开相机相册
    public class func yi_invokeCameraPhoto (_ blc: ((UIImage)->())?) {
        let qy = QYSystem.shared
        QYSystem.shared.photoBlock = blc
        let alertVC = UIAlertController.init(title: "", message: "请选择图片", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction.init(title: "相机", style: .default) { (action) in
            qy.yi_invokeSystemCamera()
        }
        let photoAction = UIAlertAction.init(title: "相册", style: .default) { (action) in
            qy.yi_invokeSystemPhoto()
        }
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        alertVC.addAction(cameraAction)
        alertVC.addAction(photoAction)
        alertVC.addAction(cancelAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertVC, animated: true, completion: nil)
    }
    ///打开相册
    private func yi_invokeSystemPhoto() -> Void {
        QYPermissionsDetection.yi_openAlbumServiceWithBlock { (b) in
            if b {
                let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .photoLibrary
                imagePickerController.delegate = QYSystem.shared
                imagePickerController.allowsEditing = false
                if self.allowsEditing! {
                    imagePickerController.allowsEditing = true
                }else {
                    imagePickerController.allowsEditing = false
                }
                if #available(iOS 11.0, *) {
                    UIScrollView.appearance().contentInsetAdjustmentBehavior = .automatic
                }
                UIApplication.shared.keyWindow?.rootViewController?.present(imagePickerController, animated: true, completion: nil)
            }else {
                QYPermissionsDetection.yi_OpenPermissionsSetting()
            }
        }
    }
    ///打开相机
    private func yi_invokeSystemCamera() -> Void {
        QYPermissionsDetection.yi_openCaptureDeviceServiceWithBlock { (b) in
            if b {
                let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .camera
                imagePickerController.delegate = QYSystem.shared
                imagePickerController.allowsEditing = false
                imagePickerController.cameraCaptureMode = .photo
                imagePickerController.mediaTypes = ["public.image"]
                
                if #available(iOS 11.0, *) {
                    UIScrollView.appearance().contentInsetAdjustmentBehavior = .automatic
                }
                UIApplication.shared.keyWindow?.rootViewController?.present(imagePickerController, animated: true, completion: nil)
            } else {
                print("请打开允许访问相机权限")
                QYPermissionsDetection.yi_OpenPermissionsSetting()
            }
        }
    }
    //MARK: -------UIImagePickerControllerDelegate
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        }
        ///原图
        let orignalImg = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        ///编辑后的图片
        let editedImg = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        if picker.sourceType == .camera && (orignalImg != nil) {
            UIImageWriteToSavedPhotosAlbum(orignalImg!, self, nil, nil)
        }
        picker.dismiss(animated: true) {
            DispatchQueue.main.async {
                if (self.photoBlock != nil) {
                    if let img = editedImg {
                        self.photoBlock!(img)
                    } else {
                        if let img = orignalImg {
                            self.photoBlock!(img)
                        }
                    }
                    
                }
            }
        }
    }
}
