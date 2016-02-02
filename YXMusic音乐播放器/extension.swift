//
//  extension.swift
//  XY微博
//
//  Created by paul-y on 16/1/5.
//  Copyright © 2016年 YX. All rights reserved.
//
//MARK:--系统API扩展--

import Foundation
import UIKit


//MARK:
extension String{
    /**
     返回字符串的CGsiae
     
     */
//MARK: 返回字符串的CGsiae
    func sizeWithFont(font textFont:UIFont,maxSize:CGSize)->CGSize{
        let attrs = [NSFontAttributeName : textFont]

        return     (self as NSString).boundingRectWithSize(maxSize, options: .UsesLineFragmentOrigin, attributes: attrs, context: nil ).size
    }
    
    
    
}
//MARK:
extension UIView {
    var x : CGFloat {
        get {
            return self.frame.origin.x
        }
        set{
            
            self.frame.origin.x = newValue
        }
    }
    var y : CGFloat {
        get {
            return self.frame.origin.y
        }
        set{
            self.frame.origin.y = newValue
        }
    }
    
    var width : CGFloat {
        get {
            return self.frame.size.width
        }
        set{
            self.frame.size.width = newValue
        }
    }
    var height : CGFloat {
        get {
            return self.frame.size.height
        }
        set{
            self.frame.size.height = newValue
        }
    }
    var centerX : CGFloat {
        get {
            return self.center.x
        }
        set{
            self.center.x = newValue
        }
    }
    var centerY : CGFloat {
        get {
            return self.center.y
        }
        set{
            self.center.y = newValue
        }
    }
}
//MARK:
extension NSDate{
    /**
     判断时间是否为今年
     
     - returns: 如果是今年，返回true，反之，返回false
     */
    func isThisYear()->Bool{
        let calendar = NSCalendar.currentCalendar()
        let  year =   calendar.component(.Year, fromDate: self)
        let nowYear = calendar.component(.Year, fromDate: NSDate())
        return year == nowYear
        
    }
    /**
     判断时间是否为昨天
     
     - returns: 如果是昨天，返回true，反之，返回false
     */
    func isYesterday()->Bool{
        let fm = NSDateFormatter()
        fm.dateFormat = "yyyy-mm-dd"
        let dateStr = fm.stringFromDate(self)
        var now = NSDate()
        let nowStr = fm.stringFromDate(now)
        
        let date = fm.dateFromString(dateStr)!
            now = fm.dateFromString(nowStr)!

        let calendar = NSCalendar.currentCalendar()
        let comp =   calendar.components([.Year,.Month,.Day], fromDate: date, toDate: now, options: NSCalendarOptions.WrapComponents)
        return  comp.year == 0 && comp.month == 0 && comp.day == 1
        
    }
    /**
     判断时间是否为今天
     
     - returns: 如果是今天，返回true，反之，返回false
     */
    func isToday()->Bool{
        let fm = NSDateFormatter()
        fm.dateFormat = "yyyy-mm-dd"
        let dateStr = fm.stringFromDate(self)
        let now = NSDate()
        let nowStr = fm.stringFromDate(now)
        return dateStr == nowStr
        
    }


}

extension UIImage{
   //MARK:获得圆形的剪裁图片
/// 根据网络图片的地址下载图片并且返回圆形的剪裁图片
class    func circleImageWithImageURL(image_url:String)->UIImage?{
        //下载网络图片
        let data = NSData(contentsOfURL: NSURL(string: image_url)!)
        let olderImage = UIImage(data: data!)
        //开启图片上下文
        let contextW = olderImage?.size.width
        let contextH = olderImage?.size.height
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(contextW!,contextH! ), false, 0.0);
        //画小圆
        let ctx=UIGraphicsGetCurrentContext()
        CGContextAddEllipseInRect(ctx, CGRect(x: 0, y: 0, width: contextW!, height: contextH!))
        CGContextClip(ctx)
        olderImage?.drawInRect(CGRect(x: 0, y: 0, width: contextW!, height: contextH!))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    /// 根据图片名字返回剪裁成圆形的图片
    class    func circleImageWithImageName(imageName:String)->UIImage?{
       
        if let olderImage = UIImage(named: imageName){
            //开启图片上下文
            let contextW = olderImage.size.width
            let contextH = olderImage.size.height
            UIGraphicsBeginImageContextWithOptions(CGSizeMake(contextW,contextH), false, 0.0);
            //画小圆
            let ctx=UIGraphicsGetCurrentContext()
            CGContextAddEllipseInRect(ctx, CGRect(x: 0, y: 0, width: contextW, height: contextH))
            CGContextClip(ctx)
            olderImage.drawInRect(CGRect(x: 0, y: 0, width: contextW, height: contextH))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage

        }else{
            return nil
        }
    }
    /// 根据图片名字返回剪裁成圆形并且有边界效果的图片
    class func circleImageWithBoder(imageName:String,borderWidth:CGFloat,borderColor:UIColor)->UIImage?{
        
        if let olderImage = UIImage(named:imageName){
            //开启图片上下文
            let contextW = olderImage.size.width + CGFloat(2) * borderWidth
            let contextH = olderImage.size.height + CGFloat(2) * borderWidth

            UIGraphicsBeginImageContextWithOptions(CGSizeMake(contextW,contextH ), false, 0.0);
            //取得图片上下文
             let ctx=UIGraphicsGetCurrentContext()
            //画大圆（边框）
            borderColor.set()
          
           let bigRadius:CGFloat = contextW * CGFloat(0.5) // 大圆半径
             let centerX: CGFloat = bigRadius // 圆心
             let centerY: CGFloat = bigRadius
            
            CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, CGFloat(M_PI * Double(2)), 0);
            CGContextFillPath(ctx); // 画圆
            //画小圆
           
            CGContextAddEllipseInRect(ctx, CGRect(x: borderWidth, y: borderWidth, width: olderImage.size.width, height: olderImage.size.height))
            //剪裁
            CGContextClip(ctx)
            olderImage.drawInRect(CGRect(x: borderWidth, y: borderWidth, width: contextW, height: contextH))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage

        }else{
            return nil
        }
    }

}

