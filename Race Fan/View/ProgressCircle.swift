//
//  ProgressCircle.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/6/23.
//

import UIKit

class ProgressCircle: UIView {
    
    //MARK: - Variables
    
    private let OUTER_CIRCLE_PADDING = 5.0
    var progress: CGFloat = 0
    let backgroundCircleColor: UIColor
    let progressCircleColor: UIColor
    
    private var circleLayer: CAShapeLayer = CAShapeLayer()
    var progressLayer: CAShapeLayer = CAShapeLayer()

    private var startRadianValue: CGFloat = CGFloat(-Double.pi / 2) 
    private var endRadianValue: CGFloat = CGFloat(3 * Double.pi / 2)
    

    //MARK: - Initializers
    
    init(backgroundCircleColor: UIColor, progressCircleColor: UIColor) {
        self.backgroundCircleColor = backgroundCircleColor
        self.progressCircleColor = progressCircleColor
        
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Functions
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        createCircularPath()
    }

    private func createCircularPath() {
        
        let viewCenterPoint = CGPoint(x: bounds.width / 2.0, y: bounds.height / 2.0)
        let radius: CGFloat = (min(bounds.height, bounds.width) / 2.0) - OUTER_CIRCLE_PADDING
        
        let circularPath = UIBezierPath(arcCenter: viewCenterPoint, radius: radius, startAngle: startRadianValue, endAngle: endRadianValue, clockwise: true)

        circleLayer.path = circularPath.cgPath
        progressLayer.path = circularPath.cgPath
        
        setCircleLayerAttributes()
        setProgressLayerAttributes()

        layer.addSublayer(circleLayer)
        layer.addSublayer(progressLayer)
    }

    private func setCircleLayerAttributes() {
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 10.0
        circleLayer.strokeEnd = 1.0
        circleLayer.strokeColor = self.backgroundCircleColor.cgColor
    }

    private func setProgressLayerAttributes() {
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 5.0
        progressLayer.strokeEnd = self.progress
        progressLayer.strokeColor = progressCircleColor.cgColor
    }
    
    func setProgressRemaining(progress: CGFloat) {
        progressLayer.strokeEnd = progress
    }
}
