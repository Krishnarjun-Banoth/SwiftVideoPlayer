//
//  UIImagView+Extensions.swift
//  KrishnaVideoPlayer
//
//  Created by Krishnarjun Banoth on 02/02/20.
//  Copyright © 2020 Krishnarjun Banoth. All rights reserved.
//

import Foundation
import UIKit
import AVKit

let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {
    func createThumbnailOfVideoFromRemoteUrl(url: String){
        
        // check cached image
        if let cachedImage = imageCache.object(forKey: url as NSString)  {
            self.image = cachedImage
            return
        }
         DispatchQueue.global(qos: .userInitiated).async {
            let asset = AVAsset(url: URL(string: url)!)
            let assetImgGenerate = AVAssetImageGenerator(asset: asset)
            assetImgGenerate.appliesPreferredTrackTransform = true
            //Can set this to improve performance if target size is known before hand
            //assetImgGenerate.maximumSize = CGSize(width,height)
            let time = CMTimeMakeWithSeconds(1.0, preferredTimescale: 600)
            do {
                let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
                let thumbnail = UIImage(cgImage: img)
                imageCache.setObject(thumbnail, forKey: url as NSString)
                DispatchQueue.main.async {
                    self.image = thumbnail
                }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.image = UIImage.init(named: "no-image")
                }
            }
        }
        
    }
}


