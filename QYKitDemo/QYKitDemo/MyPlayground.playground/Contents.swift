//: A UIKit based Playground for presenting user interface
  
import UIKit
import Foundation
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white


        self.view = view
        
    }
}
PlaygroundPage.current.liveView = MyViewController()


open class HUD: UIView {
    
    static let share = HUD()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
