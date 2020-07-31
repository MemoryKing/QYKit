//: A UIKit based Playground for presenting user interface
  
import UIKit
import Foundation
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

//        let ui = QYCountDownButton()
//        ui.frame = CGRect(x: 50, y: 200, width: 200, height: 200)
//        ui.backgroundColor = .lightGray
//        ui.setTitle("选择租客记得", for: .normal)
//        view.addSubview(ui)
        self.view = view
        
    }
}
PlaygroundPage.current.liveView = MyViewController()


