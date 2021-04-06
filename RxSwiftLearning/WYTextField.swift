//
//  WYTextField.swift
//  RxSwiftLearning
//
//  Created by lovechocolate on 2021/3/31.
//  Copyright © 2021 WR. All rights reserved.
//

import UIKit

let padding = 5
let heightSpaceing = 2
let lineWidth: CGFloat = 1

class WYTextField: UIView, UITextFieldDelegate {
    var _placeholder: String?
    var _text: String?
    //光标颜色
    var _cursorColor: UIColor?
    //注释普通状态下颜色
    var _placeholderNormalStateColor: UIColor?
    //注释选中状态下颜色
    var _placeholderSelectStateColor: UIColor?
    //文本框
    var textField: UITextField?
    //注释
    private var placeholderLabel: UILabel?
    //线
    private var lineView: UIView?
    //填充线
    private var lineLayer: CALayer?
    //移动一次
    private var moved = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        textField = UITextField(frame: CGRect.zero)
        textField?.borderStyle = .none
        textField?.font = UIFont.systemFont(ofSize: 15.0)
        textField?.textColor = UIColor.white
        textField?.delegate = self
        textField?.tintColor = UIColor.white
        addSubview(textField!)

        placeholderLabel = UILabel(frame: CGRect.zero)
        placeholderLabel?.font = UIFont.systemFont(ofSize: 13.0)
        placeholderLabel?.textColor = UIColor.lightGray
        addSubview(placeholderLabel!)

        lineView = UIView(frame: CGRect.zero)
        lineView?.backgroundColor = UIColor.lightGray
        addSubview(lineView!)

        lineLayer = CALayer()
        lineLayer?.frame = CGRect(x: 0, y: 0, width: 0, height: lineWidth)
        lineLayer?.anchorPoint = CGPoint(x: 0, y: 0.5)
        lineLayer?.backgroundColor = UIColor.white.cgColor
        if let lineLayer = lineLayer {
            lineView?.layer.addSublayer(lineLayer)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(obserValue(_:)), name: UITextField.textDidChangeNotification, object: textField)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

   @objc func obserValue(_ obj: Notification?) {
        changeFrameOfPlaceholder()
    }

    func changeFrameOfPlaceholder() {
        let y = placeholderLabel!.center.y
        let x = placeholderLabel!.center.x
        if textField!.text?.count != 0 && !moved {
            moveAnimation(x, y: y)
        } else if textField!.text?.count == 0 && moved {
            backAnimation(x, y: y)
        }
    }

    func moveAnimation(_ x: CGFloat, y: CGFloat) {
        var moveX = x
        var moveY = y
        placeholderLabel!.font = UIFont.systemFont(ofSize: 10.0)
        placeholderLabel!.textColor = _placeholderSelectStateColor
        UIView.animate(withDuration: 0.15, animations: { [self] in
            moveY -= self.placeholderLabel!.frame.size.height / 2 + CGFloat(heightSpaceing)
            moveX -= CGFloat(padding)
            self.placeholderLabel?.center = CGPoint(x: moveX, y: moveY)
            self.placeholderLabel!.alpha = 1
            self.moved = true
            self.lineLayer!.bounds = CGRect(x: 0, y: 0, width: self.frame.width, height: lineWidth)
        })
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        textField?.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height - lineWidth)
        placeholderLabel?.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height - lineWidth)
        lineView?.frame = CGRect(x: 0, y: frame.height - lineWidth, width: frame.width, height: lineWidth)
    }

    func backAnimation(_ x: CGFloat, y: CGFloat) {
        var moveX = x
        var moveY = y
        placeholderLabel!.font = UIFont.systemFont(ofSize: 13.0)
        placeholderLabel!.textColor = _placeholderSelectStateColor
        UIView.animate(withDuration: 0.15, animations: {
            moveY += self.placeholderLabel!.frame.size.height / 2 + CGFloat(heightSpaceing)
            moveX += CGFloat(padding)
            self.placeholderLabel!.center = CGPoint(x: moveX, y: moveY)
            self.placeholderLabel!.alpha = 1
            self.moved = false
            self.lineLayer!.bounds = CGRect(x: 0, y: 0, width: 0, height: lineWidth)
        })
    }

    var placeholder:String?{
        get {
            return _placeholder
        }
        set {
            _placeholder = newValue
            placeholderLabel!.text = _placeholder
        }
    }

    var text:String?{
        get {
            return _text
        }
        set {
            _text = newValue
            textField!.text = _text
        }
    }

    var cursorColor:UIColor?{
        get {
            return _cursorColor
        }
        set {
            setCursorColor(newValue)
        }
    }

    var placeholderNormalStateColor:UIColor?{
        get {
            return _placeholderNormalStateColor
        }
        set {
            setPlaceholderNormalStateColor(newValue)
        }
    }

    var placeholderSelectStateColor:UIColor?{
        get {
            return _placeholderSelectStateColor
        }
        set {
            setPlaceholderSelectStateColor(newValue)
        }
    }

    func setCursorColor(_ cursorColor: UIColor?) {
        _cursorColor = cursorColor
        textField!.tintColor = cursorColor
    }

    func setPlaceholderNormalStateColor(_ placeholderNormalStateColor: UIColor?) {
        _placeholderNormalStateColor = placeholderNormalStateColor
        if placeholderNormalStateColor == nil {
            _placeholderNormalStateColor = UIColor.lightGray
        }
        placeholderLabel!.textColor = _placeholderNormalStateColor
    }

    func setPlaceholderSelectStateColor(_ placeholderSelectStateColor: UIColor?) {
        _placeholderSelectStateColor = placeholderSelectStateColor
        if placeholderSelectStateColor == nil {
            _placeholderSelectStateColor = UIColor.white
        }
    }
}
