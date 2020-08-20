//: A UIKit based Playground for presenting user interface
  
import UIKit
import Foundation
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let tf = UITextField()
        tf.yi_leftTile("2132131", 100)
        self.view = view
        
    }
}
PlaygroundPage.current.liveView = MyViewController()


//open class HUD: UIView {
    
//    static let share = HUD()
//
//    public override init(frame: CGRect) {
//        super.init(frame: frame)
//        backgroundColor = .lightGray
//
//    }
//
//    required public init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
//}
public extension UITextField {
    /// 文本距离左右侧的距离
    ///
    /// - Parameters:
    ///   - leftWidth: 左侧距离
    ///   - rightWidth: 右侧距离
    func yi_distanceSides(_ leftWidth:CGFloat,
                          _ rightWidth:CGFloat? = nil)  {
        //左侧view
        let leftV = UIView(frame: CGRect(x: 0, y: 0, width: leftWidth, height: 5))
        self.leftViewMode = .always
        self.leftView = leftV
        //右侧view
        let rightV = UIView(frame: CGRect(x: 0, y: 0, width: rightWidth!, height: 5))
        self.rightViewMode = .always
        self.rightView = rightV
    }
    
    /// 添加标题
    ///
    /// - Parameters:
    ///   - titleLabel: titleLabel
    ///   - titleWidth: titleWidth
    ///   - padding: 距离右侧输入框的距离
    func yi_leftTile(_ title: String,
                     _ titleWidth: CGFloat,
                     _ color: UIColor? = nil,
                     _ font: UIFont? = nil,
                     _ textAlignment: NSTextAlignment? = nil,
                     _ padding: CGFloat? = nil)  {
        let label = UILabel()
        label.text = title
        label.textColor = color ?? .lightGray
        label.font = font ?? UIFont.systemFont(ofSize: 14)
        label.textAlignment = textAlignment ?? .center
        let leftV = UIView(frame: CGRect(x: 0, y: 0, width: titleWidth + (padding ?? 0), height: 30))
        label.frame = leftV.bounds
        leftV.addSubview(label)
        self.leftViewMode = .always
        self.leftView = leftV
    }
    
    /// 添加左侧icon
    ///
    /// - Parameters:
    ///   - image: image
    ///   - size: icon的size
    ///   - padding: 距离文本距离
    func yi_leftIcon(_ image: UIImage,_ size:CGSize,_ padding: CGFloat)  {
        let leftV = UIView(frame: CGRect(x: 0, y: 0, width: size.width + 2 * padding - 3, height: size.height))
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: padding, y: 0, width: size.width, height: size.height)
        leftV.addSubview(imageView)
        self.leftViewMode = .always
        self.leftView = leftV
    }
    
    /// 添加右侧icon
    ///
    /// - Parameters:
    ///   - image: image
    ///   - size: size
    ///   - padding: padding
    func yi_rightIcon(_ image: UIImage,size:CGSize,padding: CGFloat)  {
        let rightV = UIView(frame: CGRect(x: 0, y: 0, width: size.width + 2 * padding, height: size.height))
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: padding, y: 0, width: size.width, height: size.height)
        rightV.addSubview(imageView)
        self.rightViewMode = .always
        self.rightView = rightV
    }
}
