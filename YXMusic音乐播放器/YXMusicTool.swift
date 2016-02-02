//
//  YXMusicTool.swift
//  YXMusic音乐播放器
//
//  Created by paul-y on 16/2/2.
//  Copyright © 2016年 YinQiXing. All rights reserved.
//管理并记录播放的音乐

import UIKit

class YXMusicTool: NSObject {
    static var playingMusic:MusicModal?{//属性观察器
        willSet{
            if playingMusic != nil && newValue != playingMusic{
                AudioTool.stopMusicWith(playingMusic!.filename!)
            }
           
        }
    }
}
