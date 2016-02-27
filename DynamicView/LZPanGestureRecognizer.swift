//
//  LZPanGestureRecognizer.swift
//  DynamicView
//
//  Created by YiLun Zhao on 2016-01-25.
//  Copyright © 2016 lkzhao. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass


class LZPanGestureRecognizer: UIPanGestureRecognizer {
  
  var startViewCenterPoint:CGPoint?
  
  var translatedViewCenterPoint:CGPoint{
    if let startViewCenterPoint = startViewCenterPoint{
      var p = startViewCenterPoint + translationInView(self.view!.superview!)
      p.x = clamp(p.x, range:xRange, overflowScale:xOverflowScale)
      p.y = clamp(p.y, range:yRange, overflowScale:yOverflowScale)
      return p
    }else{
      return self.view?.center ?? CGPointZero
    }
  }

  func clamp(element: CGFloat, range:ClosedInterval<CGFloat>, overflowScale:CGFloat = 0) -> CGFloat {
    if element < range.start{
      return range.start - (range.start - element)*overflowScale
    } else if element > range.end{
      return range.end + (element - range.end)*overflowScale
    }
    return element
  }

  var xOverflowScale:CGFloat = 0.3
  var yOverflowScale:CGFloat = 0.3
  var xRange:ClosedInterval<CGFloat> = CGFloat.min...CGFloat.max
  var yRange:ClosedInterval<CGFloat> = CGFloat.min...CGFloat.max
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent) {
    super.touchesBegan(touches, withEvent: event)
    
    if state == .Failed{
      return
    }

    startViewCenterPoint = self.view?.center
  }
  
}