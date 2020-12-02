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
    public var normalColor: UIColor? {
        willSet {
            self.selectView.normalColor = newValue ?? QY33Color
        
        }
    }
    public var selectColor: UIColor? {
        willSet {
            self.selectView.selectColor = newValue
        }
    }
    public var font: UIFont? {
        willSet {
            self.selectView.font = newValue ?? QYFont(14)
        }
    }
    public var topHeight: CGFloat? {
        willSet {
            self.selectView.snp.removeConstraints()
            self.selectView.snp.makeConstraints({
                $0.left.right.top.equalToSuperview()
                $0.height.equalTo(QYRatio(newValue ?? 0))
            })
            self.backgroundView.snp.removeConstraints()
            self.backgroundView.snp.makeConstraints({
                $0.left.right.bottom.equalToSuperview()
                $0.top.equalTo(selectView.snp.bottom)
            })
        }
    }
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
    public var backgroundView: UIView!
    
    fileprivate var selectView: QYSelectView!
    public override init(frame: CGRect) {
        super.init(frame: frame)
        selectView = QYSelectView()
        addSubview(selectView)
        selectView.snp.makeConstraints({
            $0.left.right.top.equalToSuperview()
            $0.height.equalTo(QYRatio(41))
        })
        self.backgroundView = UIView()
        yi_currentController()?.addChild(pageViewController)
        self.backgroundView.addSubview(pageViewController.view)
        addSubview(self.backgroundView)
        self.backgroundView.snp.makeConstraints({
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(selectView.snp.bottom)
        })
    }
    
    public func yi_createPage(_ titles: Array<String>,_ spacing: Float? = nil,_ uniform: Bool = true,_ block: ((String,Int,UIViewController)->())?) {
        var uni: Float?
        if titles.count < 4 && uniform {
            uni = Float(QYScreenWidth / titles.count)
        }
        selectView.create(titles, spacing ?? 0, uni ?? 0)
        selectView.clickBlock = {[weak self] in
            QYLog($0 + "\($1)")
            if let vc = self?.yi_viewControllers?[$1] {
                if $1 > self?.currentIndex ?? 0 {
                    self?.pageViewController.setViewControllers([vc], direction: .forward, animated: false, completion: nil)
                } else {
                    self?.pageViewController.setViewControllers([vc], direction: .reverse, animated: false, completion: nil)
                }
                if let bl = block {
                    bl(titles[$1],$1,vc)
                }
            }
        }
    }
    
    public var yi_viewControllers: Array<UIViewController>? {
        willSet {
            if let vc = newValue?.first {
                pageViewController.setViewControllers([vc], direction: .reverse, animated: false, completion: nil)
            }
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
        
        if let vcs = self.yi_viewControllers {
            let vs = vcs as NSArray
            var index = vs.index(of: viewController)
            if index == 0 || index == NSNotFound {
                return nil
            }
            index -= 1
            return self.yi_viewControllers?[index]
        }
        return nil
    }
    
    ///后一页
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let vcs = self.yi_viewControllers {
            let vs = vcs as NSArray
            var index = vs.index(of: viewController)
            if index == vs.count - 1 || index == NSNotFound {
                return nil
            }
            index += 1
            return self.yi_viewControllers?[index]
        }
        return nil
        
    }
    
    ///将要滑动切换的时候
    public func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        if let vc = pendingViewControllers.first,let vcs = self.yi_viewControllers {
            let vs = vcs as NSArray
            let index = vs.index(of: vc)
            currentIndex = index
            if let btns = self.selectView.buttons {
                self.selectView.allClick(btns[currentIndex])
            }
        }
    }
    
    /// 滑动结束后
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
    }
}

public class QYSelectView: UIView {
    public var lineWidth: CGFloat?
    public var lineSpacing: CGFloat?
    public var normalColor: UIColor?
    public var selectColor: UIColor?
    public var font: UIFont = QYFont(14)
    public var clickBlock: ((String,Int)->())?
    public var buttons: Array<UIButton>?
    public var topHeight: CGFloat? {
        willSet {
            self.topScrollView.snp.removeConstraints()
            self.topScrollView.snp.makeConstraints({
                $0.left.right.top.equalToSuperview()
                $0.height.equalTo(QYRatio(newValue ?? 0))
            })
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buttons = []
        addSubview(topScrollView)
        topScrollView.snp.removeConstraints()
        topScrollView.snp.makeConstraints({
            $0.left.right.top.bottom.equalToSuperview()
        })
        addSubview(lineView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func create(_ titles: Array<String>,_ spacing: Float = 0,_ uniform: Float = 0) {
        topScrollView.subviews.forEach { sub in
            sub.removeFromSuperview()
        }
        buttons?.removeAll()
        
        var oldButotn: UIButton?

        for (i,string) in titles.enumerated() {
            var titW = string.yi_getWidth(QYFont(14))
            let titH = string.yi_getHeight(QYFont(14), fixedWidth: titW)
            titW = lineWidth ?? titW
            let button = UIButton().yi_then({
                $0.yi_title = string
                $0.yi_titleColor = self.normalColor ?? QY33Color
                $0.yi_titleFont = font
                $0.yi_selectedColor = selectColor
                $0.tag = i
                $0.addTarget(self, action: #selector(self.allClick(_:)), for: .touchUpInside)
                topScrollView.addSubview($0)
            })
            if i == 0 {
                button.isSelected = true
                button.snp.makeConstraints({
                    $0.left.equalTo(spacing)
                    $0.top.bottom.centerY.equalToSuperview()
                    $0.width.equalTo(uniform)
                })
            } else {
                if i == titles.count - 1 {
                    button.snp.makeConstraints({
                        $0.left.equalTo(oldButotn!.snp.right).offset(spacing)
                        $0.right.equalTo(spacing * -1)
                        $0.top.bottom.centerY.equalToSuperview()
                        $0.width.equalTo(uniform)
                    })
                } else {
                    button.snp.makeConstraints({
                        $0.left.equalTo(oldButotn!.snp.right).offset(spacing)
                        $0.top.bottom.centerY.equalToSuperview()
                        $0.width.equalTo(uniform)
                    })
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
        var titW = sender.titleLabel?.text?.yi_getWidth(QYFont(14))
        guard let titH = sender.titleLabel?.text?.yi_getHeight(QYFont(14), fixedWidth: titW ?? 100) else { return }
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
    public lazy var topScrollView: UIScrollView = {
        return UIScrollView().yi_then({
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.isUserInteractionEnabled = true
            $0.contentSize = .init(width: QYScreenWidth, height: QYRatio(41))
        })
    }()
    
    public lazy var lineView: UIView = {
        return UIView().yi_then({
            $0.backgroundColor = .blue
        })
    }()
}
