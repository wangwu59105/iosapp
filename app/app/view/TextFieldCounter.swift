//
//  TextFieldCounter.swift
//  TextFieldCounter
//
//  Created by Fabricio Serralvo on 12/7/16.
//  Copyright © 2016 Fabricio Serralvo. All rights reserved.
//

import Foundation
import UIKit

open class TextFieldCounter: UITextField, UITextFieldDelegate {
    
    lazy internal var counterLabel: UILabel = UILabel()
    
    weak var counterDelegate: TextFieldCounterDelegate?
    
    // MARK: IBInspectable: Limits and behaviors
    
    @IBInspectable public dynamic var animate : Bool = true
    @IBInspectable public dynamic var ascending : Bool = true
    @IBInspectable public var maxLength : Int = TextFieldCounter.defaultLength {
        didSet {
            if (!isValidMaxLength(max: maxLength)) {
                maxLength = TextFieldCounter.defaultLength
            }
        }
    }
    
   
    
    enum MnumberType : Int{
        case m4d2 = 1,m4d3
    }
    
    //IBInspectable 在stroyboard里面没有找到[]类型
    @IBInspectable public var numberTypeInt : Int = MnumberType.m4d3.rawValue {
        didSet {
            keyboardType = UIKeyboardType.decimalPad
            switch numberTypeInt {
            case MnumberType.m4d2.rawValue:
                //按照输入循序允许输入1234.01 或者 1-4位正数   或者1234.   或者1234.0   或者1234.00
                regexsContinue.append("^(([1-9]{1}\\d{0,3})|0{1})(\\.\\d{0,2})?$")
                //0.00无效
                regexsReturn.append("^0{1}\\.0{2}$")
                
            case MnumberType.m4d3.rawValue:
                
                regexsContinue.append("^(([1-9]{1}\\d{0,3})|0{1})(\\.\\d{0,3})?$")
                //0.000无效
                regexsReturn.append("^0{1}\\.0{3}$")
                
                break
            default:
                break
            }
        }
    }
    ///正则  不能输入的正则
    //可以输入的所有情况
    var regexsContinue : [String] = [String]()
    //不能输入的作为补充
    var regexsReturn : [String] = [String]()

    @IBInspectable public var regexsReturnToast : String = ""
    @IBInspectable public dynamic var counterColor : UIColor = .lightGray
    @IBInspectable public dynamic var limitColor: UIColor = .red
    @IBInspectable public dynamic var uppercased: Bool = false

    // MARK: Enumerations and Constants
    
    enum AnimationType {
        case basic
        case didReachLimit
        case unknown
    }
    
    static let defaultLength = 30
    
    // MARK: Init
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        super.delegate = self
        counterLabel = setupCounterLabel()
    }
    
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        rightView = counterLabel
        rightViewMode = .whileEditing
    }
    
    // MARK: Public Methods
    
    /**
     Initializes a new beautiful *TextFieldCounter*.
     
     - parameter frame: The frame of view.
     - parameter animate: Default is `true`.
     - parameter ascending: Default is `true`.
     - parameter limit: By default, if the number is not greater than 0, the limit will be `30`.
     - parameter counterColor: Default color is `UIColor.lightGray`.
     - parameter limitColor: Default color is `UIColor.red`.
     */
    
    public init(frame: CGRect, limit: Int, animate: Bool = true, ascending: Bool = true, counterColor: UIColor = .lightGray, limitColor: UIColor = .red ,uppercased : Bool = false) {
        
        super.init(frame: frame)
        
        if !isValidMaxLength(max: limit) {
            maxLength = TextFieldCounter.defaultLength
        } else {
            maxLength = limit
        }
        
        self.animate = animate
        self.ascending = ascending
        self.counterColor = counterColor
        self.limitColor = limitColor
        self.uppercased = uppercased
        
        self.backgroundColor = .white
        self.layer.borderWidth = 0.35
        self.layer.cornerRadius = 5.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        
        
        super.delegate = self
        counterLabel = setupCounterLabel()
    }
    
    // MARK: Private Methods
    
    private func isValidMaxLength(max: Int) -> Bool {
        return max > 0
    }
    
    private func setupCounterLabel() -> UILabel {
        
        let fontFrame : CGRect = CGRect(x: 0, y: 0, width: counterLabelWidth(), height: Int(frame.height))
        let label : UILabel = UILabel(frame: fontFrame)
        
        if let currentFont : UIFont = font {
            label.font = currentFont
            label.textColor = counterColor
            label.textAlignment = label.userInterfaceLayoutDirection == .rightToLeft ? .right : .left
            label.lineBreakMode = .byWordWrapping
            label.numberOfLines = 1
        }
        
        return label
    }
    
    
    
    
    
    private func localizedString(of number: Int) -> String {
        return String.localizedStringWithFormat("%i", number)
    }
    
    private func counterLabelWidth() -> Int {
        let biggestText = localizedString(of: maxLength)
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .left
        paragraph.lineBreakMode = .byWordWrapping
        
        var size : CGSize = CGSize()
        
        if let currentFont = font {
            size = biggestText.ts_sizeWithConstrainedWidth(size.width, font: currentFont)
        }
        
        return Int(size.width) + 15
    }
    
    private func updateCounterLabel(count: Int) {
        if count <= maxLength {
            if (ascending) {
                counterLabel.text = localizedString(of: count)
            } else {
                counterLabel.text = localizedString(of: maxLength - count)
            }
        }
        
        prepareToAnimateCounterLabel(count: count)
    }
    
    private func textFieldCharactersCount(textField: UITextField, string: String, changeCharactersIn range: NSRange) -> Int {
        
        var textFieldCharactersCount = 0
        
        if let textFieldText = textField.text {
            
            if !string.isEmpty {
                textFieldCharactersCount = textFieldText.characters.count + string.characters.count - range.length
            } else {
                textFieldCharactersCount = textFieldText.characters.count - range.length
            }
        }
        
        return textFieldCharactersCount
    }
    
    private func checkIfNeedsCallDidReachMaxLengthDelegate(count: Int) {
        if (count >= maxLength) {
            counterDelegate?.didReachMaxLength(textField: self)
        }
    }
    
    // MARK: - Animations
    
    private func prepareToAnimateCounterLabel(count: Int) {
        
        var animationType : AnimationType = .unknown
        
        if (count >= maxLength) {
            animationType = .didReachLimit
        } else if (count <= maxLength) {
            animationType = .basic
        }
        
        animateTo(type: animationType)
    }
    
    private func animateTo(type: AnimationType) {
        
        switch type {
        case .basic:
            animateCounterLabelColor(color: counterColor)
        case .didReachLimit:
            animateCounterLabelColor(color: limitColor)
            
            if #available(iOS 10.0, *) {
                fireHapticFeedback()
            }
            
            if (animate) {
                counterLabel.shakeTo(transform: CGAffineTransform(translationX: 5, y: 0), duration: 0.3)
            }
        default:
            break
        }
    }
    
    private func animateCounterLabelColor(color: UIColor) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.counterLabel.textColor = color
        }, completion: nil)
    }
    
    // MARK: - Haptic Feedback
    
    private func fireHapticFeedback() {
        if #available(iOS 10.0, *) {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
        }
    }
    
    // MARK: - UITextFieldDelegate
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var shouldChange = false
        let charactersCount = textFieldCharactersCount(textField: textField, string: string, changeCharactersIn: range)
        
        if string.isEmpty {
            shouldChange = true
        } else {
            shouldChange = charactersCount <= maxLength
        }
        
        updateCounterLabel(count: charactersCount)
        checkIfNeedsCallDidReachMaxLengthDelegate(count: charactersCount)
        //
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        //let regexsReturns = regexsReturn.components(separatedBy: "#")
        if(!newText.isEmpty){
            for regc in regexsContinue{
                    if(!RegexUtils.isRegex(newText, regex: regc)){
                        shouldChange = false
                        break
                    }
            }
            //过滤补充不能输入的
            if(shouldChange){
                for regr in regexsReturn{
                    if(RegexUtils.isRegex(newText, regex: regr)){
                        shouldChange = false
                        break
                    }
                }
            }
            if(!shouldChange){
                ToastView.showMessage(regexsReturnToast)
            }
        }
        
        if(shouldChange&&uppercased){
            textField.text = newText.uppercased()
            return false;
        }
        return shouldChange
    }
    
    
    
    
    
//    var beforeString : String = ""
//    
//    
//    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        beforeString = textField.text!
//        return true
//
//    }
//    
//    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        let endString   =  textField.text
//        if(RegexUtils.isRegex(endString!, regex: regexsReturn)){
//            ToastView.showMessage(regexsReturnToast)
//            textField.text = beforeString
//        }
//        
//
//        return false
//    }
    
   
}






// MARK: - TextFieldCounterDelegate

protocol TextFieldCounterDelegate : class {
    func didReachMaxLength(textField: TextFieldCounter)
}

// MARK: - Extensions

extension UIView {
    
    public func shakeTo(transform: CGAffineTransform, duration: TimeInterval) {
        
        self.transform = transform
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    var userInterfaceLayoutDirection: UIUserInterfaceLayoutDirection {
        if #available(iOS 9.0, *) {
            return UIView.userInterfaceLayoutDirection(for: self.semanticContentAttribute)
        } else {
            return UIApplication.shared.userInterfaceLayoutDirection
        }
    }
    
}
