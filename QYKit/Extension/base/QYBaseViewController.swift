/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/MemoryKing
********************************************************************************/


import UIKit
import SnapKit

open class QYBaseViewController: UIViewController, UIGestureRecognizerDelegate {
    //MARK: --- 状态栏
    private var _barStyle: UIStatusBarStyle?
    ///状态栏
    public var yi_barStyle: UIStatusBarStyle {
        set {
            _barStyle = newValue
            setNeedsStatusBarAppearanceUpdate()
        }
        get {
            return _barStyle ?? UIStatusBarStyle.default
        }
    }
    
    //MARK: --- 返回手势
    private var _interactivePop: Bool?
    ///返回手势
    public var yi_interactivePop: Bool {
        set {
            _interactivePop = newValue
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = newValue
        }
        get {
            return _interactivePop ?? false
        }
    }
    
    public var baseTableView: QYBaseTableView?
    public var baseCollection: QYBaseCollectionView?
    //MARK: --- viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()

        //防止自动下移64
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.extendedLayoutIncludesOpaqueBars = true
        
        self.yi_interactivePop = true
        
        self.view.backgroundColor = QYF5Color
    }
    
    //MARK: --- 添加表视图
    ///添加表视图
    public func yi_addTableView(_ block: ((QYBaseTableView) -> Void)? = nil) {
        if self.baseCollection != nil {
            self.baseCollection?.removeFromSuperview()
            self.baseCollection = nil
        }
        
        self.baseTableView = QYBaseTableView()
        self.baseTableView!.showsVerticalScrollIndicator = false
        self.baseTableView!.showsHorizontalScrollIndicator = false
        self.baseTableView!.backgroundColor = QYF5Color
        self.baseTableView!.separatorStyle = .none
        self.baseTableView!.estimatedRowHeight = 0
        self.baseTableView!.estimatedSectionFooterHeight = 0
        self.baseTableView!.estimatedSectionHeaderHeight = 0
        self.view.addSubview(self.baseTableView!)
        self.baseTableView!.snp.makeConstraints {
            $0.top.equalTo(QYStatusAndNavHeight)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalTo(-QYBottomHeight)
        }
        block?(self.baseTableView!)
    }
    
    //MARK:-注册表视图cell
    ///注册表视图cell
    public func yi_registerCell(cells:[AnyClass],cellName:[String]) {
        for index in 0..<cells.count {
            self.baseTableView?.register(cells[index], forCellReuseIdentifier: cellName[index])
        }
    }
    
    //MARK: --- 添加集合视图
    ///添加集合视图
    public func yi_addCollectionView(_ block: ((UICollectionViewFlowLayout,QYBaseCollectionView) -> Void)? = nil) {
        if self.baseTableView != nil {
            self.baseTableView?.removeFromSuperview()
            self.baseTableView = nil
        }
        
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = CGSize.init(width: 100, height: 100)
        self.baseCollection = QYBaseCollectionView.init(frame: .init(), collectionViewLayout: layout)
        self.baseCollection!.showsVerticalScrollIndicator = false
        self.baseCollection!.showsHorizontalScrollIndicator = false
        self.baseCollection!.backgroundColor = QYF5Color
        self.view.addSubview(self.baseCollection!)
        self.baseCollection!.snp.makeConstraints {
            $0.top.equalTo(QYStatusAndNavHeight)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalTo(-QYBottomHeight)
        }
        block?(layout,self.baseCollection!)
    }
    
    //MARK:-注册集合视图cell
    ///注册集合视图cell
    public func yi_registerCollectionCell(cell:AnyClass,cellName:String) {
        self.baseCollection?.register(cell, forCellWithReuseIdentifier: cellName)
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.yi_barStyle
    }

}
