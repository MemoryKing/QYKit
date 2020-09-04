/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/MemoryKing
********************************************************************************/

import UIKit

///分页控制器
open class QYPageView: UIView {
    private var currentIndex: Int = 0
    public var lineColor: UIColor? {
        willSet {
            self.selectView.lineView.backgroundColor = newValue
        }
    }
    public var lineSpacing: CGFloat? {
        willSet {
            self.selectView.lineSpacing = newValue
        }
    }
    public var lineWidth: CGFloat? {
        willSet {
            self.selectView.lineWidth = newValue
        }
    }
    
    fileprivate var selectView: QYSelectView!
    public override init(frame: CGRect) {
        super.init(frame: frame)
        selectView = QYSelectView()
        addSubview(selectView)
        selectView.snp.makeConstraints({
            $0.left.right.top.equalToSuperview()
            $0.height.equalTo(QYRatio(41))
        })
        let bg = UIView()
        yi_currentController()?.addChild(pageViewController)
        bg.addSubview(pageViewController.view)
        addSubview(bg)
        bg.snp.makeConstraints({
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(selectView.snp.bottom)
        })
    }
    
    public func yi_createPage(_ titles: Array<String>,_ spacing: CGFloat? = nil,_ uniform: CGFloat? = nil,_ block: ((String,Int)->())?) {
        var uni: CGFloat?
        if titles.count < 3 && (uniform == nil) {
            uni = QYScreenWidth / titles.count
        }
        selectView.create(titles, spacing, uni)
        selectView.clickBlock = {[weak self] in
            QYLog($0 + "\($1)")
            let vc = self?.viewControllers?[$1]
            
            if $1 > self?.currentIndex ?? 0 {
                self?.pageViewController.setViewControllers([vc!], direction: .forward, animated: false, completion: nil)
            } else {
                self?.pageViewController.setViewControllers([vc!], direction: .reverse, animated: false, completion: nil)
            }
        }
    }
    
    public var viewControllers: Array<UIViewController>? {
        didSet {
            let vc = viewControllers?.first
            pageViewController.setViewControllers([vc!], direction: .reverse, animated: false, completion: nil)
        }
    }
    ///分页
    lazy var pageViewController: UIPageViewController = {
        let page = UIPageViewController.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [UIPageViewController.OptionsKey.interPageSpacing:0])
        return page.yi_then({
            $0.delegate = self
            $0.dataSource = self
            addSubview($0.view)
        })
    }()
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension QYPageView: UIPageViewControllerDelegate,UIPageViewControllerDataSource {
    ///前一页
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let vcs = self.viewControllers! as NSArray
        var index = vcs.index(of: viewController)
        if index == 0 || index == NSNotFound {
            return nil
        }
        index -= 1
        return self.viewControllers?[index] ?? nil
    }
    ///后一页
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let vcs = self.viewControllers! as NSArray
        var index = vcs.index(of: viewController)
        if index == (self.viewControllers?.count ?? 0) - 1 || index == NSNotFound {
            return nil
        }
        index += 1
        return self.viewControllers?[index] ?? nil
    }
    ///将要滑动切换的时候
    public func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
        let vc = pendingViewControllers.first
        let vcs = self.viewControllers! as NSArray
        let index = vcs.index(of: vc ?? UIViewController())
        
        currentIndex = index
    }
    /// 滑动结束后
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            DispatchQueue.main.yi_getMainAsync {
                self.selectView.allClick(self.selectView.buttons![self.currentIndex])
            }
        }
    }
}

fileprivate class QYSelectView: UIView {
    var lineWidth: CGFloat?
    var clickBlock: ((String,Int)->())?
    var buttons: Array<UIButton>?
    var lineSpacing: CGFloat?
    override init(frame: CGRect) {
        super.init(frame: frame)
        buttons = []
        addSubview(topScrollView)
        topScrollView.snp.makeConstraints({
            $0.left.right.top.bottom.equalToSuperview()
        })
        addSubview(lineView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func create(_ titles: Array<String>,_ spacing: CGFloat? = nil,_ uniform: CGFloat? = nil) {
        topScrollView.subviews.forEach { sub in
            sub.removeFromSuperview()
        }
        buttons?.removeAll()
        
        var oldButotn: UIButton?
        let initspacing = 10
        for (i,string) in titles.enumerated() {
            var titW = string.yi_getWidth(QYFont_14)
            let titH = string.yi_getHeight(QYFont_14, fixedWidth: titW)
            titW = lineWidth ?? titW
            let button = UIButton().yi_then({
                $0.yi_title = string
                $0.yi_titleColor = QY33Color
                $0.yi_titleFont = QYFont_14
                $0.yi_selectedColor = .blue
                $0.tag = i
                $0.addTarget(self, action: #selector(self.allClick(_:)), for: .touchUpInside)
                topScrollView.addSubview($0)
            })
            if (uniform != nil) {
                if i == 0 {
                    button.isSelected = true
                    button.snp.makeConstraints({
                        $0.left.equalTo(spacing ?? 5)
                        $0.top.bottom.centerY.equalToSuperview()
                        $0.width.equalTo(uniform ?? 0)
                    })
                } else {
                    if i == titles.count - 1 {
                        button.snp.makeConstraints({
                            $0.left.equalTo(oldButotn!.snp.right).offset(spacing ?? initspacing)
                            $0.right.equalTo((spacing ?? CGFloat(initspacing)) * -1)
                            $0.top.bottom.centerY.equalToSuperview()
                        })
                    } else {
                        button.snp.makeConstraints({
                            $0.left.equalTo(oldButotn!.snp.right).offset(spacing ?? initspacing)
                            $0.top.bottom.centerY.equalToSuperview()
                        })
                    }
                }
            } else {
                if i == 0 {
                    button.isSelected = true
                    button.snp.makeConstraints({
                        $0.left.equalTo(spacing ?? 5)
                        $0.top.bottom.centerY.equalToSuperview()
                    })
                } else {
                    if i == titles.count - 1 {
                        button.snp.makeConstraints({
                            $0.left.equalTo(oldButotn!.snp.right).offset(spacing ?? initspacing)
                            $0.right.equalTo((spacing ?? CGFloat(initspacing)) * -1)
                            $0.top.bottom.centerY.equalToSuperview()
                        })
                    } else {
                        button.snp.makeConstraints({
                            $0.left.equalTo(oldButotn!.snp.right).offset(spacing ?? initspacing)
                            $0.top.bottom.centerY.equalToSuperview()
                        })
                    }
                }
            }
            if i == 0 {
                lineView.snp.makeConstraints({
                    $0.centerX.equalTo(button.snp.centerX)
                    $0.centerY.equalTo(button.snp.centerY).offset(titH / 2 + (lineSpacing ?? 1.5))
                    $0.width.equalTo(titW)
                    $0.height.equalTo(1)
                })
            }
            buttons?.append(button)
            oldButotn = button
        }
        clickBlock?(titles.first ?? "",0)
    }
    @objc func allClick(_ sender: UIButton) {
        var titW = sender.titleLabel?.text!.yi_getWidth(QYFont_14)
        guard let titH = sender.titleLabel?.text?.yi_getHeight(QYFont_14, fixedWidth: titW ?? 100) else { return }
        titW = lineWidth ?? titW
        buttons?.forEach({ btn in
            btn.isSelected = false
        })
        sender.isSelected = true
        self.lineView.snp.remakeConstraints({
            $0.centerX.equalTo(sender.snp.centerX)
            $0.centerY.equalTo(sender.snp.centerY).offset(titH / 2 + (lineSpacing ?? 1.5))
            $0.width.equalTo(titW!)
            $0.height.equalTo(1)
        })
        let btnCenterX = sender.center.x
        var scrollX = btnCenterX - topScrollView.bounds.width * 0.5
        if scrollX < 0 {
            scrollX = 0
        }
        if scrollX > topScrollView.contentSize.width - topScrollView.bounds.width {
            scrollX = topScrollView.contentSize.width - topScrollView.bounds.width
        }
        topScrollView.setContentOffset(CGPoint(x: scrollX, y: 0), animated: true)
        clickBlock?(sender.titleLabel?.text ?? "",sender.tag)
    }
    ///标题
    lazy var topScrollView: UIScrollView = {
        return UIScrollView().yi_then({
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.isUserInteractionEnabled = true
            $0.backgroundColor = .green
            $0.contentSize = .init(width: QYScreenWidth * 2, height: QYRatio(41))
        })
    }()
    
    lazy var lineView: UIView = {
        return UIView().yi_then({
            $0.backgroundColor = .blue
        })
    }()
}
