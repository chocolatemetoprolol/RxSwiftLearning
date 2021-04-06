//
//  WYButton.swift
//  RxSwiftLearning
//
//  Created by lovechocolate on 2021/3/31.
//  Copyright © 2021 WR. All rights reserved.
//

import UIKit

typealias finishBlock = () -> Void

class WYButton: UIView {
    var translateBlock: finishBlock?
    var maskLayer: CAShapeLayer?
    var shapeLayer: CAShapeLayer?
    var loadingLayer: CAShapeLayer?
    var clickCicrleLayer: CAShapeLayer?
    var button: UIButton?

    override init(frame: CGRect) {

        super.init(frame: frame)

        shapeLayer = drawMask(frame.size.height / 2)
        shapeLayer!.fillColor = UIColor.clear.cgColor
        shapeLayer!.strokeColor = UIColor.white.cgColor
        shapeLayer!.lineWidth = 2
        layer.addSublayer(shapeLayer!)

        maskLayer = CAShapeLayer()
        maskLayer!.opacity = 0
        maskLayer!.fillColor = UIColor.white.cgColor
        maskLayer!.path = drawBezierPath(frame.size.width / 2)?.cgPath
        layer.addSublayer(maskLayer!)
        
        button = UIButton(type: .custom)
        button!.frame = bounds
        button!.setTitle("SIGN IN", for: .normal)
        button!.setTitleColor(UIColor.white, for: .normal)
        button?.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
        addSubview(button!)
        button!.addTarget(self, action: #selector(clickBtn), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func clickBtn() {
        clickAnimation()
    }

    func clickAnimation() {
        clickCicrleLayer = CAShapeLayer()
        clickCicrleLayer!.position = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        clickCicrleLayer!.fillColor = UIColor.white.cgColor
        clickCicrleLayer!.path = drawclickCircleBezierPath(0)?.cgPath
        layer.addSublayer(clickCicrleLayer!)
        let basicAnimation = CABasicAnimation(keyPath: "path")
        basicAnimation.duration = 0.15
        basicAnimation.toValue = drawclickCircleBezierPath((bounds.size.height - 10 * 2) / 2)?.cgPath
        basicAnimation.isRemovedOnCompletion = false
        basicAnimation.fillMode = .forwards
        clickCicrleLayer!.add(basicAnimation, forKey: "clickCicrleAnimation")

        perform(#selector(clickNextAnimation), with: self, afterDelay: basicAnimation.duration)
    }

    @objc func clickNextAnimation() -> Void {
        clickCicrleLayer!.fillColor = UIColor.clear.cgColor
        clickCicrleLayer!.strokeColor = UIColor.white.cgColor
        clickCicrleLayer!.lineWidth = 10
        let animationGroup = CAAnimationGroup()
        let basicAnimation = CABasicAnimation(keyPath: "path")
        basicAnimation.duration = 0.15
        basicAnimation.toValue = drawclickCircleBezierPath((bounds.size.height - 10 * 2))?.cgPath
        basicAnimation.isRemovedOnCompletion = false
        basicAnimation.fillMode = .forwards

        let basicAnimation1 = CABasicAnimation(keyPath: "opacity")
        basicAnimation1.beginTime = 0.10
        basicAnimation1.duration = 0.15
        basicAnimation1.toValue = NSNumber(value: 0)
        basicAnimation1.isRemovedOnCompletion = false
        basicAnimation1.fillMode = .forwards
        animationGroup.duration = basicAnimation1.beginTime + basicAnimation1.duration
        animationGroup.isRemovedOnCompletion = false
        animationGroup.fillMode = .forwards
        animationGroup.animations = [basicAnimation, basicAnimation1]
        clickCicrleLayer!.add(animationGroup, forKey: "clickCicrleAnimation1")
        perform(#selector(startMaskAnimation), with: self, afterDelay: animationGroup.duration)
    }

    func drawclickCircleBezierPath(_ radius: CGFloat) -> UIBezierPath? {
        let bezierPath = UIBezierPath()
        bezierPath.addArc(withCenter: CGPoint(x: 0, y: 0), radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        return bezierPath
    }

    func drawMask(_ x: CGFloat) -> CAShapeLayer? {
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = bounds
        shapeLayer.path = drawBezierPath(x)?.cgPath
        return shapeLayer
    }

    func drawBezierPath(_ x: CGFloat) -> UIBezierPath? {
         let radius: CGFloat = bounds.size.height / 2 - 3
         let right = bounds.size.width - x
         let left = x
         let bezierPath = UIBezierPath()
         bezierPath.lineJoinStyle = .round
         bezierPath.lineCapStyle = .round
         bezierPath.addArc(withCenter: CGPoint(x: right, y: bounds.size.height / 2), radius: radius, startAngle: -.pi / 2, endAngle: .pi / 2, clockwise: true)
        bezierPath.addArc(withCenter: CGPoint(x: left, y: bounds.size.height / 2), radius: radius, startAngle: .pi / 2, endAngle: -.pi / 2, clockwise: true)
        bezierPath.close()
        return bezierPath
    }

    @objc func startMaskAnimation() {
        maskLayer!.opacity = 0.15
        let basicAnimation = CABasicAnimation(keyPath: "path")
        basicAnimation.duration = 0.25
        basicAnimation.toValue = drawBezierPath(frame.size.height / 2)?.cgPath
        basicAnimation.isRemovedOnCompletion = false
        basicAnimation.fillMode = .forwards
        maskLayer!.add(basicAnimation, forKey: "maskAnimation")
        perform(#selector(dismissAnimation), with: self, afterDelay: basicAnimation.duration + 0.2)
    }

    @objc func dismissAnimation() -> Void {
        removeSubViews()
        let animationGroup = CAAnimationGroup()
        let basicAnimation = CABasicAnimation(keyPath: "path")
        basicAnimation.duration = 0.15
        basicAnimation.toValue = drawBezierPath(frame.size.width / 2)?.cgPath
        basicAnimation.isRemovedOnCompletion = false
        basicAnimation.fillMode = .forwards

        let basicAnimation1 = CABasicAnimation(keyPath: "opacity")
        basicAnimation1.beginTime = 0.10
        basicAnimation1.duration = 0.15
        basicAnimation1.toValue = NSNumber(value: 0)
        basicAnimation1.isRemovedOnCompletion = false
        basicAnimation1.fillMode = .forwards

        animationGroup.animations = [basicAnimation, basicAnimation1]
        animationGroup.duration = basicAnimation1.beginTime + basicAnimation1.duration
        animationGroup.isRemovedOnCompletion = false
        animationGroup.fillMode = .forwards
        shapeLayer!.add(animationGroup, forKey: "dismissAnimation")
        perform(#selector(loadingAnimation), with: self, afterDelay: animationGroup.duration)
    }

    @objc func loadingAnimation() -> Void {
        loadingLayer = CAShapeLayer()
        loadingLayer!.position = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        loadingLayer!.fillColor = UIColor.clear.cgColor
        loadingLayer!.strokeColor = UIColor.white.cgColor
        loadingLayer!.lineWidth = 2
        loadingLayer!.path = drawLoadingBezierPath()?.cgPath
        layer.addSublayer(loadingLayer!)

        let basicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        basicAnimation.fromValue = NSNumber(value: 0)
        basicAnimation.toValue = NSNumber(value: Double.pi * 2)
        basicAnimation.duration = 0.5
        basicAnimation.repeatCount = Float(LONG_MAX)
        loadingLayer!.add(basicAnimation, forKey: "loadingAnimation")

        perform(#selector(removeAllAnimation), with: self, afterDelay: 3)
    }

    func drawLoadingBezierPath() -> UIBezierPath? {
        let radius: CGFloat = bounds.size.height / 2 - 3
        let bezierPath = UIBezierPath()
        bezierPath.addArc(withCenter: CGPoint(x: 0, y: 0), radius: radius, startAngle: .pi / 2, endAngle: .pi / 2 + .pi / 2, clockwise: true)
        return bezierPath
    }

    func removeSubViews() {
        button?.removeFromSuperview()
        maskLayer?.removeFromSuperlayer()
        loadingLayer?.removeFromSuperlayer()
        clickCicrleLayer?.removeFromSuperlayer()
    }

   @objc  func removeAllAnimation() {
        removeSubViews()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
            self.resetAn()
        })
        if (translateBlock != nil) {
            translateBlock!()
        }
    }

    func resetAn() {
        shapeLayer = drawMask(frame.size.height / 2)
        shapeLayer!.fillColor = UIColor.clear.cgColor
        shapeLayer!.strokeColor = UIColor.white.cgColor
        shapeLayer!.lineWidth = 2
        layer.addSublayer(shapeLayer!)
        layer.addSublayer(maskLayer!)
        button = UIButton(type: .custom)
        button!.frame = bounds
        button!.setTitle("SIGN IN", for: .normal)
        button!.setTitleColor(UIColor.white, for: .normal)
        button?.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
        addSubview(button!)
        button!.addTarget(self, action: #selector(clickBtn), for: .touchUpInside)
    }
}
