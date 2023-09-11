//
//  SpinnerLoadingView.swift
//  CommonUI
//
//  Created by Mohammad reza on 11.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public class SpinnerLoadingView: UIView {
    
    private var spinnerLayer: CAShapeLayer!
    private let spinnerColor: UIColor
    
    public init(spinnerColor: UIColor = CommonUIAsset.actionPrimary.color) {
        self.spinnerColor = spinnerColor
        super.init(frame: .zero)
        createSpinner()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is called, this view should not instantiate from Interface Builder")
    }
    
    private func createSpinner() {
        let radius: CGFloat = 20.0
        let strokeWidth: CGFloat = 4.0
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        
        let path = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: -(.pi / 2),
            endAngle: 3 * .pi / 2,
            clockwise: true
        )
        
        spinnerLayer = CAShapeLayer()
        spinnerLayer.path = path.cgPath
        spinnerLayer.strokeColor = spinnerColor.cgColor
        spinnerLayer.fillColor = UIColor.clear.cgColor
        spinnerLayer.lineWidth = strokeWidth
        spinnerLayer.strokeEnd = 0.8
        spinnerLayer.lineCap = .round
        spinnerLayer.position = center
        
        layer.addSublayer(spinnerLayer)
        alpha = 0
        
        animateSpinner()
    }
    
    private func animateSpinner() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = 2.0 * .pi
        rotationAnimation.duration = 1.0
        rotationAnimation.repeatCount = .infinity
        spinnerLayer.add(rotationAnimation, forKey: "rotation")
    }
    
    public func show() {
        animateSpinner()
        UIView.animate(withDuration: 0.3) { [self] in
            alpha = 1
        }
    }
    
    public func hide() {
        UIView.animate(withDuration: 0.3) { [self] in
            alpha = 0
        } completion: { [self] isCompleted in
            guard isCompleted else { return }
            spinnerLayer.removeAllAnimations()
        }
    }
}

public extension Reactive where Base: SpinnerLoadingView {
    
    var isLoading: Binder<Bool> {
        Binder(base) { base, isLoading in
            isLoading ? base.show() : base.hide()
        }
    }
}
