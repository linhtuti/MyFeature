//
//  UIImageViewExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/25/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

#if os(iOS) || os(tvOS)
import UIKit
import PINRemoteImage

// MARK: - Methods
public extension UIImageView {
	
	/// SwifterSwift: Make image view blurry
	///
	/// - Parameter style: UIBlurEffectStyle (default is .light).
	public func blur(withStyle style: UIBlurEffectStyle = .light) {
		let blurEffect = UIBlurEffect(style: style)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		blurEffectView.frame = bounds
		blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
		addSubview(blurEffectView)
		clipsToBounds = true
	}
	
	/// SwifterSwift: Blurred version of an image view
	///
	/// - Parameter style: UIBlurEffectStyle (default is .light).
	/// - Returns: blurred version of self.
	public func blurred(withStyle style: UIBlurEffectStyle = .light) -> UIImageView {
		let imgView = self
		imgView.blur(withStyle: style)
		return imgView
	}

    public func flyAnimation() {
        let startPoint = randomStartPosision()
        frame = CGRect(x: startPoint.x, y: startPoint.y, width: 0, height: 0)
        center = startPoint

        guard let image = image else {
            return
        }
        var minDimension = image.size.width > image.size.height ? image.size.height : image.size.width
        if minDimension > 100 {
            minDimension = 100
        }
        
        alpha = 0
        UIView.animate(withDuration: 1,
                       animations: {
                        self.alpha = 1
                        self.frame.size = CGSize(width: minDimension * 0.4, height: minDimension * 0.4)
                        self.center = startPoint
        }) { _ in
            UIView.animate(withDuration: 4,
                           delay: 0.01,
                           options: [.allowAnimatedContent, .curveEaseOut],
                           animations: {
                            self.alpha = 0
                            self.frame.size = CGSize(width: minDimension, height: minDimension)

                            let screenHeight = UIScreen.main.bounds.height
                            self.center = CGPoint(x: startPoint.x, y: startPoint.y - screenHeight / 2)
            }) { finish in
                self.removeFromSuperview()
            }
        }
    }

    private func randomStartPosision() -> CGPoint {
        let screenSize = UIScreen.main.bounds
        let x = screenSize.width - CGFloat(arc4random_uniform(UInt32(screenSize.width / 4))) - screenSize.width / 8
        let y = screenSize.height - CGFloat(arc4random_uniform(UInt32(screenSize.height / 8))) - screenSize.height / 16

        return CGPoint(x: x, y: y)
    }
    
    /**
     Set the image from the given URL.
     
     @param url NSURL to fetch from.
     */
    func setImage(url: URL?){
        self.pin_setImage(from: url)
    }
    
    /**
     Set the image from the given URL and set placeholder image while image at URL is being retrieved.
     
     @param url NSURL to fetch from.
     @param placeholderImage PINImage to set on the view while the image at URL is being retrieved.
     */
    func setImage(from url: URL?, placeholderImage: UIImage?){
        self.pin_setImage(from: url, placeholderImage: placeholderImage)
    }
    
    
	
}
#endif
