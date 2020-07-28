//: A UIKit based Playground for presenting user interface
  
import UIKit
import Foundation
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let tf = UITextField()
        tf.frame = CGRect(x: 50, y: 200, width: 200, height: 20)
        tf.textColor = .black
        tf.maxCount = 10
        tf.backgroundColor = .lightGray
        tf.placeholder = "213213213"
//        tf.placeholderColor = .blue
        tf.yi_leftTile(title: "断开连接",titleWidth: 80, .blue,10)
        view.addSubview(tf)
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()

extension UITextField {
    /// 文本距离左右侧的距离
    ///
    /// - Parameters:
    ///   - leftWidth: 左侧距离
    ///   - rightWidth: 右侧距离
    func yi_distanceSides(_ leftWidth:CGFloat,
                          _ rightWidth:CGFloat? = 0)  {
        //左侧view
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: leftWidth, height: 5))
        leftViewMode = .always
        //右侧view
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: rightWidth!, height: 5))
        rightViewMode = .always
    }
    
    /// 添加标题
    ///
    /// - Parameters:
    ///   - titleLabel: titleLabel
    ///   - titleWidth: titleWidth
    ///   - padding: 距离右侧输入框的距离
    func yi_leftTile(title: String,
                     titleWidth: CGFloat,
                     _ color: UIColor = .lightGray,
                     _ font: CGFloat = 14,
                     _ textAlignment: NSTextAlignment = .center,
                     _ padding: CGFloat = 0)  {
        let label = UILabel()
        label.text = title
        label.textColor = color
        label.font = UIFont.systemFont(ofSize: font)
        label.textAlignment = .center
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: titleWidth + padding + CGFloat(5), height: 30))
        label.frame = CGRect(x: 5, y: 0, width: titleWidth, height: 30)
        leftView?.addSubview(label)
        self.leftViewMode = .always
    }
    
    /// 添加左侧icon
    ///
    /// - Parameters:
    ///   - image: image
    ///   - size: icon的size
    ///   - padding: 距离文本距离
    func yi_leftIcon(_ image: UIImage,size:CGSize,padding: CGFloat)  {
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: size.width + 2 * padding - 3, height: size.height))
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: padding, y: 0, width: size.width, height: size.height)
        self.leftView?.addSubview(imageView)
        self.leftViewMode = .always
    }
    
    /// 添加右侧icon
    ///
    /// - Parameters:
    ///   - image: image
    ///   - size: size
    ///   - padding: padding
    func yi_rightIcon(_ image: UIImage,size:CGSize,padding: CGFloat)  {
        self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: size.width + 2 * padding, height: size.height))
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: padding, y: 0, width: size.width, height: size.height)
        self.rightView?.addSubview(imageView)
        rightViewMode = .always
    }
}

extension UITextField {
    @objc func textFieldDidChange() {
        if self.maxCount > 0 {
            self.setMaxCount()
        }
    }
    ///设置最大值
    private func setMaxCount() {
        let textCount = self.text?.count ?? 0
        if textCount > self.maxCount {
            self.text = String(self.text?.prefix(self.maxCount) ?? "")
        }
    }
    
}
extension UITextField {
    private struct QYRuntimeKey {
        static let maxCount = UnsafeRawPointer.init(bitPattern: "maxCount".hashValue)
        static let placeholderColor = UnsafeRawPointer.init(bitPattern: "placeholderColor".hashValue)
    }
    ///最大字数
    var maxCount: Int {
        set {
            objc_setAssociatedObject(self, QYRuntimeKey.maxCount!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
        get {
            return objc_getAssociatedObject(self, QYRuntimeKey.maxCount!) as! Int
        }
    }
    ///占位字颜色
    var placeholderColor: UIColor {
        set {
            guard let holder = self.placeholder, !holder.isEmpty else { return }
            self.attributedPlaceholder = NSAttributedString(string: holder, attributes: [.foregroundColor: newValue])
            objc_setAssociatedObject(self, QYRuntimeKey.placeholderColor!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, QYRuntimeKey.placeholderColor!) as! UIColor
        }
    }
}
