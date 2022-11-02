//
//  PlayVideoViewController.swift
//  DuDuSwiftPro
//
//  Created by Fangjl_Pro on 6/23/22.
//

import UIKit
import AVKit

class PlayVideoViewController: BaseViewController {
    /// 是否响应转动屏幕
    private var isRollEnable = true
    /// 音视频播放列表
    private var playerConfigArray: [HYPlayerCommonConfig]
        = [
            HYPlayerCommonConfig(title: "本地音频测试",
                                 audioUrl: Bundle.main.path(forResource: "testSong", ofType: "mp3"),
                                 placeHoldImg: "radio_bg_video"),
            HYPlayerCommonConfig(title: "网络视频测试2",
                                 videoUrl: "http://vfx.mtime.cn/Video/2019/02/04/mp4/190204084208765161.mp4",
                                 needCache: false,
                                 placeHoldImg: "radio_bg_video"),
            HYPlayerCommonConfig(title: "网络视频测试3",
                                 videoUrl: "http://vfx.mtime.cn/Video/2019/03/19/mp4/190319222227698228.mp4",
                                 needCache: true,
                                 placeHoldImg: "radio_bg_video"),
            HYPlayerCommonConfig(title: "本地视频测试",
                                 videoUrl: Bundle.main.path(forResource: "testMovie", ofType: "mp4"),
                                 placeHoldImg: "radio_bg_video"),
            HYPlayerCommonConfig(title: "网络音频测试",
                                 audioUrl: "http://downsc.chinaz.net/Files/DownLoad/sound1/201906/11582.mp3",
                                 needCache: true,
                                 placeHoldImg: "radio_bg_video")]
    
    private var videoView: HYPlayerCommonView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let playView = UIView()
        playView.backgroundColor = .white
        playView.clipsToBounds = true
        view.addSubview(playView)
        playView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(80)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.size.width / 16 * 9)
        }
        
        videoView = HYPlayerCommonView(playView)
        videoView?.delegate = self
        videoView?.updateCurrentPlayer(playerConfig: playerConfigArray[1])
    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//        videoView?.dealToDisappear()
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
        videoView?.dealToDisappear()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


//MARK: HYPlayerCommonViewDelegate
extension PlayVideoViewController: HYPlayerCommonViewDelegate {
    /** 全屏状态改变*/
    func changeFullScreen(isFull: Bool) {
        print(isFull ? "全屏" : "退出全屏")
    }
    
    
    /** 全屏锁定*/
    func fullScreenLock(isLock: Bool) {
        isRollEnable = !isLock
    }
    
    /** 展示控制台*/
    func showControlPanel() {
        print("展示控制台")
    }
    
    /** 隐藏控制台*/
    func hideControlPanel() {
        print("隐藏控制台")
    }
    
    /** 流量提醒*/
    func flowRemind() {
        print("正在使用流量")
    }
    
    /** 开始播放*/
    func startPlayer() {
        print("开始播放")
    }
    
    /** 播放暂停*/
    func pausePlayer() {
        print("暂停播放")
    }
    
    /** 结束播放*/
    func stopPlayer() {
        print("结束播放")
    }
    
    /** 缓存开始*/
    func startCache() {
        print("缓存开始")
    }
    
    /** 缓存进行中*/
    func inCaching(progress: Float) {
        print("缓存进度更新：\(progress)")
    }
    
    /** 缓存完成*/
    func completeCache() {
        print("缓存完成")
    }
    
    /** 缓存失败*/
    func faildCache() {
        print("缓存失败")
    }
}

