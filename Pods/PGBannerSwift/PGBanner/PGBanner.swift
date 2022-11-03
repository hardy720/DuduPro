//
//  PGBanner.swift
//
//  Created by piggybear on 2017/7/6.
//  Copyright © 2017年 piggybear. All rights reserved.
//

import UIKit

struct Size {
    var width: CGFloat = 0
    var height: CGFloat = 0
}

public protocol PGBannerDelegate: NSObjectProtocol {
    func selectAction(didselectAtIndex index: NSInteger, didSelectView view: Any);
}

public class PGBanner: UIView, UIScrollViewDelegate {
    //MARK: - public property
    public lazy var pageControl: UIPageControl = {
        let width = 15 * self.numberOfPages
        let frame = CGRect(x: self.size.width / 2 - CGFloat(width / 2), y: self.size.height - 20, width: CGFloat(width), height: 20)
        let pageControl = UIPageControl(frame: frame)
        pageControl.numberOfPages = self.numberOfPages
        return pageControl
    }()
    public weak var delegate: PGBannerDelegate?
    
    //MARK: - private property
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    fileprivate var timeInterval: Double = 0
    fileprivate var viewList: Array<Any>?
    fileprivate var timer: Timer?
    fileprivate var size: Size = Size()
    fileprivate var numberOfPages: NSInteger = 0
    fileprivate var placeholder: UIImage?
    //MARK: - init
    public init(frame: CGRect, viewList: Array<Any>, timeInterval: Double) {
        super.init(frame: frame)
        self.numberOfPages = viewList.count - 2
        self.timeInterval = timeInterval
        self.viewList = viewList
        size.width = frame.size.width
        size.height = frame.size.height
        self.addView()
        self.setupContentWithView()
        self.logic()
    }
    
    public init(frame: CGRect, imageNameList: Array<String>, timeInterval: Double) {
        super.init(frame: frame)
        self.numberOfPages = imageNameList.count
        self.timeInterval = timeInterval
        size.width = frame.size.width
        size.height = frame.size.height
        self.addView()
        self.setupContentWithImageView(imageNameList: imageNameList)
        self.logic()
    }
    
    public init(frame: CGRect, imageNameList: Array<String>, placeholderImage placeholder: UIImage?, timeInterval: Double) {
        super.init(frame: frame)
        self.placeholder = placeholder
        self.numberOfPages = imageNameList.count
        self.timeInterval = timeInterval
        size.width = frame.size.width
        size.height = frame.size.height
        self.addView()
        self.setupContentWithImageView(imageNameList: imageNameList)
        self.logic()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


// MARK: - UIScrollViewDelegate
public extension PGBanner {
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = NSInteger((scrollView.contentOffset.x + size.width * 0.5) / size.width)
        if page == self.numberOfPages + 1 {
            self.pageControl.currentPage = 0
        }else if page == 0 {
            self.pageControl.currentPage = self.numberOfPages - 1
        }else {
            self.pageControl.currentPage = page - 1
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.removeTimer()
        self.offsetLogic()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let page = NSInteger((scrollView.contentOffset.x + size.width * 0.5) / size.width)
        if page == self.numberOfPages + 1 {
            self.scrollView.contentOffset = CGPoint(x: size.width, y: 0)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.offsetLogic()
        self.addTimer()
    }
}

//MARK: - custom method
extension PGBanner {
    fileprivate func addView() {
        self.addSubview(scrollView)
        self.addSubview(pageControl)
    }
    
    fileprivate func logic() {
        self.addTimer()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        self.addGestureRecognizer(tap)
    }
    
    // tap gesture recognizer monitor
    @objc fileprivate func tapAction() {
        let index = self.pageControl.currentPage
        var selectView: Any?
        if index + 1 < (self.viewList?.count)! {
            selectView = self.viewList?[index + 1]
        }else {
            selectView = nil
        }
        delegate?.selectAction(didselectAtIndex: index, didSelectView: selectView!)
    }
    
    fileprivate func setupContentWithView() {
        for (index, item) in self.viewList!.enumerated() {
            let frame = CGRect(x: CGFloat(index) * size.width, y: 0, width: size.width, height: size.height)
            let view: UIView = item as! UIView
            view.frame = frame
            self.scrollView.addSubview(view)
        }
        setupScrollView(count: (self.viewList?.count)!)
    }
    
    fileprivate func setupContentWithImageView(imageNameList: Array<String>) {
        var tempArray = Array<Any>()
        let count = imageNameList.count + 2
        var index = 0
        while index < count {
            var tempIndex = index - 1
            if index == count - 1 {
                tempIndex = 0
            }else if index == 0 {
                tempIndex = count - 3;
            }
            let frame = CGRect(x: CGFloat(index) * size.width, y: 0, width: size.width, height: size.height)
            let imageView = UIImageView(frame: frame)
            imageView.contentMode = .scaleAspectFill
            if imageNameList[tempIndex].hasPrefix("http") {
                
             imageView.imageWithURL(url:URL(string: imageNameList[tempIndex])!, placeholderImage: self.placeholder)
            }else {
                imageView.image = UIImage(named: imageNameList[tempIndex])
            }
            self.scrollView.addSubview(imageView)
            tempArray.append(imageView)
            index += 1
        }
        
        self.viewList = tempArray
        setupScrollView(count: count)
    }
    
    fileprivate func setupScrollView(count: NSInteger) {
        self.scrollView.contentSize = CGSize(width: size.width * CGFloat(count), height: 0)
        self.scrollView.contentOffset = CGPoint(x: size.width, y: 0)
    }
    
    fileprivate func offsetLogic() {
        if self.pageControl.currentPage == 0 {
            self.scrollView.contentOffset = CGPoint(x: size.width, y: 0)
        }else if self.pageControl.currentPage == self.numberOfPages - 1 {
            self.scrollView.contentOffset = CGPoint(x: size.width * CGFloat(self.numberOfPages), y: 0)
        }
    }
}


// MARK: - timer logic
extension PGBanner {
    fileprivate func addTimer() {
        self.timer = Timer(timeInterval: self.timeInterval, target: self, selector: #selector(nextImage), userInfo: nil, repeats: true)
        RunLoop.main.add(self.timer!, forMode: .common)
    }
    
    @objc fileprivate func nextImage() {
        let page = self.pageControl.currentPage + 2
        self.scrollView.setContentOffset(CGPoint(x: CGFloat(page) * size.width, y: 0), animated: true)
    }
    
    fileprivate func removeTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
}
