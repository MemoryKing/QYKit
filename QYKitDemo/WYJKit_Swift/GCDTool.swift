//
//  Countdown.swift
//  Express
//
//  Created by 祎 on 2019/7/22.
//  Copyright © 2019 祎. All rights reserved.
//

import UIKit

public class GCDTool: NSObject {
    var timer : DispatchSourceTimer!
    
    public class var shared : GCDTool {
        return GCDTool()
    }
    
    /// GCD timer
    /// - Parameter timeCount: total time
    /// - Parameter repeating: repeating time
    /// - Parameter eventHadndler: event handler
    /// - Parameter cancelHadndler: cancet handler
    public func GCDTimer(timeCount : NSInteger ,
                         repeating : Double,
                         eventHadndler : ((NSInteger) -> Void)?,
                         cancelHadndler : ((NSInteger) -> Void)?) {
        
        var timeCount = timeCount
        
        // 自定义并发队列
        let concurrentQ = DispatchQueue(label: "com.timer", attributes: .concurrent)
        // 在自定义队列的定时器
        timer = DispatchSource.makeTimerSource(flags: [], queue: concurrentQ)
        // 设置立即开始几秒循环一次
        timer.schedule(deadline: .now() + 3, repeating: repeating)
        // 触发回调事件
        timer.setEventHandler { [weak self] in
            timeCount = timeCount - 1
            if timeCount <= 0 {
                if let strongSelf = self {
                    strongSelf.timer.cancel()
                }
            }
            DispatchQueue.main.async {
                print("主线程更新UI \(timeCount)")
                eventHadndler?(timeCount)
            }
        }
        
        // cancel事件回调
        timer.setCancelHandler {
            DispatchQueue.main.async {
                print("已结束 \(timeCount)")
                cancelHadndler?(timeCount)
            }
        }
        
        // 启动定时器
        timer.resume()
    }
    
    ///cancel timer
    public func cancelTimer () {
        timer.cancel()
    }
}
