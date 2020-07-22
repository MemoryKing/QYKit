/*******************************************************************************
 Copyright (K), 2019 - ~, ╰莪呮想好好宠Nǐつ
 
 Author:        ╰莪呮想好好宠Nǐつ (Wang Yijing)
 E-mail:        1091676312@qq.com
 GitHub:        https://github.com/MemoryKing
 ********************************************************************************/


import Foundation
import UIKit

//MARK:   -------   相册 ----------
import Photos
// 使用图片库功能
import AssetsLibrary
// 使用录制视频功能
import MobileCoreServices
public extension UIView {
    
    func showPhotosAlert (_ block : @escaping (UIImage)->()) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title:"取消", style: .cancel, handler: nil)
        let takingPictures = UIAlertAction(title:"相机", style: .default) { action in
            self.goCamera()
        }
        let localPhoto = UIAlertAction(title:"相册", style: .default) { action in
            self.imageShow()
        }
        alertController.addAction(cancel)
        alertController.addAction(takingPictures)
        alertController.addAction(localPhoto)
        photoBlock = block
        self.present(alertController, animated:true)
    }
    
    // MARK: 拍照
    func goCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let cameraPicker = UIImagePickerController()
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = .camera
            //在需要的地方present出来
            self.present(cameraPicker, animated: true)
        } else {
            print("不支持拍照")
        }
    }
    
    // MARK: 图库
    func photosShow() {
        // 是否支持图片库
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.savedPhotosAlbum) {
            // 实例化
            photosPicker = UIImagePickerController()
            // 图库类型
            photosPicker.sourceType = UIImagePickerController.SourceType.savedPhotosAlbum
            // 代理对象（注意添加协议 UIImagePickerControllerDelegate、UINavigationControllerDelegate，及实现代理方法）
            photosPicker.delegate = self
            // 设置图片可编辑
            photosPicker.allowsEditing = true
            // 弹出图库视图控制器
            self.present(photosPicker, animated: true)
        } else {
            print("读取图库失败")
        }
    }
    
    // MARK: 相册
    func imageShow() {
        // 是否支持相册
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            photosPicker = UIImagePickerController()
            photosPicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            photosPicker.delegate = self
            // 弹出图库视图控制器
            self.present(photosPicker, animated: true)
        } else {
            print("读取相册失败")
        }
    }
}

//MARK:   -------   UIImagePickerControllerDelegate ----------
extension UIView : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        NSLog("获得照片============= \(info)")
        //        UIImagePickerControllerOriginalImage
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        if image != nil {
            //显示设置的照片
            photoBlock(image!)
        }
        picker.dismiss(animated: true)
    }
}
