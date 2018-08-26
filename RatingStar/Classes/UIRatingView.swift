//
//  RatingStarsView.swift
//  Smares
//
//  Created by Haytham Katby on 28/7/17.
//  Copyright © 2017 Swazer. All rights reserved.
//

import UIKit

public protocol UIRatingViewDelegate {
    func ratingChanged(newValue: Int)
}

public class UIRatingView: UIView {
    private var canvas: CGRect! // The main square - used to draw the star
    private var petalCanvas: CGRect! // The inner square - used to draw the 5th petal of the star
    private var textCanvas: CGRect! // The text square - used to draw the numbers on the petals
    private var spacing: CGFloat! // The value of the space between the petals of the star
    private var petals = [CAShapeLayer]()

    public var delegate: UIRatingViewDelegate?

    @IBInspectable public var value: Int = 0 {
        didSet {
            updateColors()
        }
    }
    @IBInspectable public var selectedColor: UIColor = UIColor(red: 1, green: 175 / 255, blue: 0, alpha: 1) {
        didSet {
            updateColors()
        }
    }
    @IBInspectable public var unselectedColor: UIColor = UIColor(red: 0, green: 122 / 255, blue: 1, alpha: 1) {
        didSet {
            updateColors()
        }
    }

    private func updateColors() {
        guard petals.count != 0 else { return }

        for index in value..<petals.count {
            petals[index].fillColor = unselectedColor.cgColor
        }

        for index in 0..<value {
            petals[index].fillColor = selectedColor.cgColor
        }
    }

    override public func awakeFromNib() {
        super.awakeFromNib()

        let height = bounds.height
        let width = bounds.width
        let length = width >= height ? height : width

        canvas = CGRect(x: (width - length) / 2, y: (height - length) / 2, width: length, height: length)
        spacing = length / 22

        let petalSide = (length / 2) - spacing
        petalCanvas = CGRect(x: bounds.midX - petalSide / 2, y: canvas.origin.y, width: petalSide, height: petalSide)

        let textSide = petalSide / 3
        textCanvas = CGRect(x: bounds.midX - textSide / 2, y: canvas.origin.y + textSide * 1.3, width: textSide, height: textSide)

        initPetals()
    }

    func initPetals() {
        let rotationOrigin = CGPoint(x: canvas.midX, y: canvas.midY)
        let distance = CGPoint(x: canvas.midX - textCanvas.midX, y: canvas.midY - textCanvas.midY)
        let path = self.petalPath(in: petalCanvas)

        for index in 1...5 {
            let angle = Double(index * 72)
            let petalPath = rotate(path: path, to: angle, arround: rotationOrigin)

            let petal = CAShapeLayer()
            petal.path = petalPath.cgPath
            petals.append(petal)

            let number = textLayer(String(index), in: textCanvas)
            rotate(layer: number, to: angle, distance: distance)

            self.layer.addSublayer(petal)
            self.layer.addSublayer(number)
        }

        updateColors()
    }

    func petalPath(in square: CGRect) -> UIBezierPath {
        let reVal = UIBezierPath()

        let startX = square.minX
        let startY = square.minY
        let side = square.height

        let topControlPoint = CGPoint(x: startX + side * 0.5, y: startY - side * 0.055)
        let bottomControlPoint = CGPoint(x: startX + side * 0.5, y: startY + side * 1.03)

        let topRightPoint = CGPoint(x: (startX + side * 0.5) + side * 0.06, y: startY + side * 0.05)
        let topLeftPoint = CGPoint(x: (startX + side * 0.5) - side * 0.06, y: startY + side * 0.05)

        let bottomRightPoint = CGPoint(x: (startX + side * 0.5) + side * 0.04, y: startY + side * 0.97)
        let bottomLeftPoint = CGPoint(x: (startX + side * 0.5) - side * 0.04, y: startY + side * 0.97)

        let rightSidePoint = CGPoint(x: startX + side * 0.82, y: startY + side * 0.59)
        let leftSidePoint = CGPoint(x: startX + side * 0.18, y: startY + side * 0.59)

        reVal.move(to: topLeftPoint)
        reVal.addQuadCurve(to: topRightPoint, controlPoint: topControlPoint)
        reVal.addLine(to: rightSidePoint)
        reVal.addLine(to: bottomRightPoint)
        reVal.addQuadCurve(to: bottomLeftPoint, controlPoint: bottomControlPoint)
        reVal.addLine(to: leftSidePoint)
        reVal.close()

        return reVal
    }

    func textLayer(_ text: String, in square: CGRect) -> CATextLayer {
        let font = UIFont.boldSystemFont(ofSize: square.height / 1.4)
        let color = UIColor.white

        let strAttributes: [NSAttributedStringKey: Any] = [.foregroundColor: color, .font: font]
        let attributedStr = NSAttributedString(string: text, attributes: strAttributes)

        let reVal = CATextLayer()
        reVal.frame = square
        reVal.string = attributedStr
        reVal.alignmentMode = "center"
        reVal.contentsScale = UIScreen.main.scale
        reVal.isWrapped = true
        reVal.opacity = 0.8

        return reVal
    }

    func rotate(path: UIBezierPath, to angle: Double, arround origin: CGPoint) -> UIBezierPath {
        guard Int(angle) % 360 != 0 else { return path }

        let radianAngle = CGFloat(angle * Double.pi / 180)

        let toOrigin = CGAffineTransform(translationX: -origin.x, y: -origin.y)
        let rotation = CGAffineTransform(rotationAngle: radianAngle)
        let fromOrigin = CGAffineTransform(translationX: origin.x, y: origin.y)

        let reVal = path.copy() as! UIBezierPath
        reVal.apply(toOrigin)
        reVal.apply(rotation)
        reVal.apply(fromOrigin)
        return reVal
    }

    func rotate(layer: CATextLayer, to angle: Double, distance: CGPoint) {
        guard Int(angle) % 360 != 0 else { return }

        let radianAngle = CGFloat(angle * Double.pi / 180)

        var transform = CATransform3DMakeTranslation(distance.x, distance.y, 0.0)
        transform = CATransform3DRotate(transform, radianAngle, 0.0, 0.0, 1.0)
        transform = CATransform3DTranslate(transform, -distance.x, -distance.y, 0.0)
        transform = CATransform3DRotate(transform, -radianAngle, 0.0, 0.0, 1.0)

        layer.transform = transform
    }

    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        detectLayer(touches: touches)
    }

    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        detectLayer(touches: touches)
    }

    func detectLayer(touches: Set<UITouch>) {
        let point = (touches.first?.location(in: self))!
        var newVal = 0

        for (index, petal) in petals.enumerated() {
            if petal.path!.contains(point) {
                newVal = index + 1
                break
            }

            newVal = 0
        }

        if newVal != value {
            value = newVal
            delegate?.ratingChanged(newValue: newVal)
        }
    }
}
