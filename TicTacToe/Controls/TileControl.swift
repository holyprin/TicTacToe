//
//  TileControl.swift
//  TicTacToe
//
//  Created by Alicia Tams on 4/6/23.
//

import UIKit

class TileControl: UIControl {

    var index: GridIndex!
    
    var tapCallback: ((_ tile: TileControl) -> Void)?
    
    private var originalTintColor: UIColor!
    
    override var tintColor: UIColor!
    {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var player: Player? {
        didSet {
            setNeedsDisplay()
        }
    }

    init(row: Int, column: Int) {
        self.index = GridIndex(row: row, column: column)
        super.init(frame: CGRect.zero)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        isUserInteractionEnabled = true
        backgroundColor = .clear
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tileTapped))
        addGestureRecognizer(tapGesture)
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        switch player {
        case .x:
            drawX(in: rect, context: context)
        case .o:
            drawO(in: rect, context: context)
        default:
            break
        }
    }

    private func drawX(in rect: CGRect, context: CGContext) {
        let lineWidth: CGFloat = rect.width/9.5
        let padding: CGFloat = rect.width/3.5
        context.setLineWidth(lineWidth)
        context.setStrokeColor(tintColor.cgColor)

        context.beginPath()
        context.move(to: CGPoint(x: rect.minX + padding, y: rect.minY + padding))
        context.addLine(to: CGPoint(x: rect.maxX - padding, y: rect.maxY - padding))
        context.move(to: CGPoint(x: rect.maxX - padding, y: rect.minY + padding))
        context.addLine(to: CGPoint(x: rect.minX + padding, y: rect.maxY - padding))
        context.strokePath()
    }

    private func drawO(in rect: CGRect, context: CGContext) {
        let lineWidth: CGFloat = rect.width/9.5
        let padding: CGFloat = rect.width/3.5
        context.setLineWidth(lineWidth)
        context.setStrokeColor(tintColor.cgColor)

        let circleRect = rect.insetBy(dx: padding, dy: padding)
        context.strokeEllipse(in: circleRect)
    }
    
    func highlight() {
        originalTintColor = tintColor
        tintColor = .white
        backgroundColor = .systemMint // or any other color you prefer
    }
    
    func clearHighlight() {
        tintColor = originalTintColor ?? tintColor
        backgroundColor = .clear // or any other color you prefer
    }
    
    @objc private func tileTapped() {
        tapCallback?(self)
    }
}
