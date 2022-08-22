//
//  UIImage+Extensions.swift
//  RickAndMortyGuide
//
//  
//

import UIKit
import AVFoundation

extension UIImage {

    func colorImage(with color: UIColor) -> UIImage? {
        guard let cgImage = self.cgImage else { return nil }
        UIGraphicsBeginImageContext(self.size)
        let contextRef = UIGraphicsGetCurrentContext()

        contextRef?.translateBy(x: 0, y: self.size.height)
        contextRef?.scaleBy(x: 1.0, y: -1.0)
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)

        contextRef?.setBlendMode(CGBlendMode.normal)
        contextRef?.draw(cgImage, in: rect)
        contextRef?.setBlendMode(CGBlendMode.sourceIn)
        color.setFill()
        contextRef?.fill(rect)

        let coloredImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return coloredImage
    }

    func resizedImage(Size sizeImage: CGSize) -> UIImage? {
        let frame = CGRect(origin: CGPoint.zero, size: CGSize(width: sizeImage.width, height: sizeImage.height))
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
        self.draw(in: frame)
        let resizedImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.withRenderingMode(.alwaysOriginal)
        return resizedImage
    }

}

extension UIImage {

    var squared: UIImage {
        let originalWidth = size.width
        let originalHeight = size.height
        var x: CGFloat = 0.0
        var y: CGFloat = 0.0
        var edge: CGFloat = 0.0

        if (originalWidth > originalHeight) {
            // landscape
            edge = originalHeight
            x = (originalWidth - edge) / 2.0
            y = 0.0

        } else if (originalHeight > originalWidth) {
            // portrait
            edge = originalWidth
            x = 0.0
            y = (originalHeight - originalWidth) / 2.0
        } else {
            // square
            edge = originalWidth
        }

        let cropSquare = CGRect(x: x, y: y, width: edge, height: edge)
        guard let imageRef = cgImage?.cropping(to: cropSquare) else { return self }

        return UIImage(cgImage: imageRef, scale: scale, orientation: imageOrientation)
    }

    func resized(maxSize: CGFloat) -> UIImage? {
        let scale: CGFloat
        if size.width > size.height {
            scale = maxSize / size.width
        }
        else {
            scale = maxSize / size.height
        }

        let newWidth = size.width * scale
        let newHeight = size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}



extension UIImage {    
    func getCompressedData(withCompressionQuality compressionQuality: CGFloat, completion: (Data)->Void) {
        let compressedData = self.getJpgData(withCompressionQuality: compressionQuality)
        completion(compressedData)
    }
    
    func getImageResized(withSizeReduceAmount sizeReduceAmount: CGFloat) -> UIImage {
        let sizeOriginal = self.size
        let widthOriginal = sizeOriginal.width
        let heightOriginal = sizeOriginal.height
        
        let widthNew = widthOriginal * sizeReduceAmount
        let heightNew = heightOriginal * (widthNew / widthOriginal)
        let sizeNew = CGSize(width: widthNew, height: heightNew)
        
        let image = UIGraphicsImageRenderer(size: sizeNew).image { _ in
            draw(in: CGRect(origin: .zero, size: sizeNew))
        }
        
        let imageRendered = image.withRenderingMode(renderingMode)
        
        return imageRendered
    }
    
    func getImageResized(toFitInSize sizeMax:CGSize) -> UIImage {
        let sizeOriginal = self.size
        
        if sizeOriginal >= sizeMax {
            let sizeNew = AVMakeRect(aspectRatio: sizeOriginal, insideRect: CGRect(x: 0,
                                                                                   y: 0,
                                                                                   width: sizeMax.width,
                                                                                   height: sizeMax.height)).size
            
            let image = UIGraphicsImageRenderer(size: sizeNew).image { _ in
                draw(in: CGRect(origin: .zero, size: sizeNew))
            }
            
            let imageRendered = image.withRenderingMode(renderingMode)
            
            return imageRendered
        }
        else if sizeOriginal.isLandscape && sizeOriginal.width >= sizeMax.width  {
            let widthNew = floor(sizeMax.width)
            let heightNew = sizeOriginal.height * (widthNew / sizeOriginal.width)
            let sizeNew = CGSize(width: widthNew, height: heightNew)
            let image = UIGraphicsImageRenderer(size: sizeNew).image { _ in
                draw(in: CGRect(origin: .zero, size: sizeNew))
            }
            let imageRendered = image.withRenderingMode(renderingMode)
            return imageRendered
        }
        else if sizeOriginal.isPortrait && sizeOriginal.height >= sizeMax.height  {
            let heightNew = floor(sizeMax.height)
            let widthNew = sizeOriginal.width * (heightNew / sizeOriginal.height)
            let sizeNew = CGSize(width: widthNew, height: heightNew)
            let image = UIGraphicsImageRenderer(size: sizeNew).image { _ in
                draw(in: CGRect(origin: .zero, size: sizeNew))
            }
            let imageRendered = image.withRenderingMode(renderingMode)
            return imageRendered
        }
        return self
    }
    
    func getJpgData(withCompressionQuality compressionQuality: CGFloat) -> Data {
        let jpgData = self.jpegData(compressionQuality: compressionQuality) ?? Data()
        return jpgData
    }
    
    func getJpgDataSizeInBytes(forCompressionQuality compressionQuality:CGFloat) -> Int{
        guard let data = self.jpegData(compressionQuality: compressionQuality) else {
            return 0
        }
        let dataSize = data.sizeInBytes
        return dataSize
    }
    
    func getJpgDataSizeInBits(forCompressionQuality compressionQuality:CGFloat) -> Int{
        let dataSize = (getJpgDataSizeInBytes(forCompressionQuality: compressionQuality) * 8)
        return dataSize
    }
}

extension UIImage {
    func suitableSize(maxHeightLimit: CGFloat, widthLimit: CGFloat) -> CGSize {
        let height = (widthLimit / self.size.width) * self.size.height
        if height <= maxHeightLimit {
            return CGSize(width: widthLimit, height: height)
        } else {
            let newWidth = (maxHeightLimit/self.size.height) * self.size.width
            return CGSize(width: newWidth, height: maxHeightLimit)
        }
    }
    
    func heightRequired(widthLimit: CGFloat )-> CGFloat {
        let value = (widthLimit / self.size.width) * self.size.height
        return value
    }
}


extension UIImage {
    
    static var emptyFavorite: UIImage { .init(named: "ic_favorite_empty")!}
    static var fillFavorite: UIImage { .init(named: "ic_favorite_fill")!}
    
    static var iconCross: UIImage { .init(systemName: "ic_cross_white")!}
}
