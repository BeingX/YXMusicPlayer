//
//  HomeTabViewController.swift
//  YXMusic音乐播放器
//
//  Created by paul-y on 16/2/2.
//  Copyright © 2016年 YinQiXing. All rights reserved.
//首页控制器

import UIKit
import MJExtension
class HomeTabViewController: UITableViewController {
   private let playingVc = YXPlayingViewController()
   private lazy var musics = MusicModal.mj_objectArrayWithFilename("Musics.plist")
    /*************************数据源方法**************************/
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.musics.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellID = "music"
          var cell = tableView.dequeueReusableCellWithIdentifier(cellID)
        if cell == nil{
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: cellID)
        }
        //取出这一行的模型
        let modal:MusicModal = musics[indexPath.row] as! MusicModal
        //设置cell
        cell!.imageView?.image = UIImage.circleImageWithBoder(modal.singerIcon!, borderWidth: 2, borderColor: UIColor.blueColor())
        cell!.textLabel!.text = modal.name
        cell!.detailTextLabel!.text = modal.singer
        return cell!
    }
    //监听cell的点击
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //取消选中状态
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//        //取出这一行的模型
//        let modal:MusicModal = musics[indexPath.row] as! MusicModal
//        print(indexPath.row)
//        YXMusicTool.playingMusic = modal
        
        playingVc.rowSelected = indexPath.row
        playingVc.show()
        
    }
    //设置cell的高度
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
}
