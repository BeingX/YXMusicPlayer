//
//  YXPlayingViewController.swift
//  YXMusic音乐播放器
//
//  Created by paul-y on 16/2/2.
//  Copyright © 2016年 YinQiXing. All rights reserved.
//音乐详情界面

import UIKit
import MJExtension
import AVFoundation
class YXPlayingViewController: UIViewController,AVAudioPlayerDelegate {
    //当前的音乐播放器
    private var player :AVAudioPlayer?{
        didSet{
            player!.delegate = self
            //设置各个空间的属性
            // 歌曲图片
            icon_music.image = UIImage(named:playingMusic!.icon!)
            // 歌曲名字
            musicNameLabel.text = playingMusic!.name
            // 作者名字
            singernameLabel.text = playingMusic!.singer
            //歌曲总时间
            musicTotalTimeLabel.text = timeIntervalToMinute(self.player!.duration)
        }
    }
  /// 记录正在播放的音乐
    private  var playingMusic:MusicModal?
    //模型数组
    private lazy var musics = MusicModal.mj_objectArrayWithFilename("Musics.plist")
    
    var rowSelected:Int?{//属性观察器
        willSet{
            if rowSelected != nil && newValue != rowSelected{
                AudioTool.stopMusicWith(playingMusic!.filename!)
            }
        }didSet{
            //设置当前正在播放的音乐
            self.playingMusic = musics[rowSelected!] as? MusicModal
         
                    }
    }
    //播放按钮
    @IBOutlet weak private var playButton: UIButton!
    /// 滑块
   @IBOutlet weak private  var slider: UIButton!
    /// 歌曲总时间
    @IBOutlet weak private var musicTotalTimeLabel: UILabel!
    /// 进度条
    @IBOutlet weak private var progressShowBar: UIView!
    /// 歌曲图片
    @IBOutlet weak private var icon_music: UIImageView!
     /// 作者名字
    @IBOutlet weak private var singernameLabel: UILabel!
    /// 歌曲名字
    @IBOutlet weak private var musicNameLabel: UILabel!
    /**
     点击进度条执行
       let x_change = (self.view.width - slider.width) * CGFloat(mPlayer.currentTime / mPlayer.duration)
     */
    @IBAction func onTap(sender: UITapGestureRecognizer) {
        let point = sender.locationInView(sender.view)
    self.player!.currentTime = Double(point.x / (self.view.width - slider.width)) * self.player!.duration
        
        
    }
    /**
     点击歌词按钮执行
     */
    @IBAction private func lrc() {
    }
    /**
     点击返回按钮执行
     */
    @IBAction private func back() {
        //获取主窗口
        let window = UIApplication.sharedApplication().keyWindow!
      
        //设置窗口的用户交互不可用
        window.userInteractionEnabled = false
        //动画
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.view.y = window.height
            }) { (Bool) -> Void in
                //动画结束，设置窗口的用户交互可用，并设置view隐藏
                window.userInteractionEnabled = true
              self.view.hidden = true
        }
    }


    /**
     点击播放或者暂停按钮执行
     */
    @IBAction private func playOrPause(sender:UIButton) {
        if sender.selected == false{
            AudioTool.pauseMusicWith(playingMusic!.filename!)
        }else{
            AudioTool.playMusicWith(playingMusic!.filename!)
        }
        sender.selected = !sender.selected
        
    }
    /**
     点击上一首按钮执行
     */
    @IBAction private func previous() {
        if rowSelected == 0{
            rowSelected! = musics.count - 1
        }else{
             rowSelected = rowSelected! - 1
        }
     
      self.player =   AudioTool.playMusicWith(self.playingMusic!.filename!)
    }
    /**
     点击下一首按钮执行
     */
    @IBAction private func next() {
        if rowSelected == musics.count - 1{
            rowSelected! = 0
        }else{
            rowSelected = rowSelected! + 1
        }
        
        self.player =   AudioTool.playMusicWith(self.playingMusic!.filename!)
    }
    /**
     显示播放音乐的详情
     */
     func show(){
        
        self.view.hidden = false
        //获取主窗口
        let window = UIApplication.sharedApplication().keyWindow!
        self.view.frame = window.bounds
        window.addSubview(self.view)
        self.view.y = window.height
        //设置窗口的用户交互不可用
        window.userInteractionEnabled = false
        //动画
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.view.y = 0
            }) { (Bool) -> Void in
                //动画结束，设置窗口的用户交互可用，并播放音乐
                 window.userInteractionEnabled = true
                
           self.player =   AudioTool.playMusicWith(self.playingMusic!.filename!)

        }
    }
    /**
     将秒转化为分钟
     */
    private func timeIntervalToMinute(timeInterval:NSTimeInterval)->String?{
        let minute = timeInterval/60
        let second = timeInterval%60
       
        let timeStr = Int(minute).description + ":" +  Int(second).description
      
        return timeStr
    }
    //创建定时器
    override func viewWillAppear(animated: Bool) {
        let timer = NSTimer(timeInterval: 0.3, target: self, selector: "updateProhress", userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer, forMode:  NSRunLoopCommonModes)
    }
    /**
     更新滑块的位置
     */
    @objc private func updateProhress(){
        if let mPlayer = self.player{
            let x_change = (self.view.width - slider.width) * CGFloat(mPlayer.currentTime / mPlayer.duration)
            slider.x = x_change
            progressShowBar.width = slider.centerX
        }
        
    }
    /**
     AVAudioPlayerDelegate 代理方法
   
     */
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        print("11")
        playButton.selected = !playButton.selected
     
    }
}
