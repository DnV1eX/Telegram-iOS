import Foundation
import UIKit
import AsyncDisplayKit
import LiquidGlassKit

//private final class SwitchNodeViewLayer: CALayer {
//    override func setNeedsDisplay() {
//    }
//}

//private final class SwitchNodeView: UISwitch {
//    override class var layerClass: AnyClass {
//        if #available(iOS 26.0, *) {
//            return super.layerClass
//        } else {
//            return SwitchNodeViewLayer.self
//        }
//    }
//}

open class SwitchNode: ASDisplayNode {
    public var valueUpdated: ((Bool) -> Void)?
    
    public var frameColor = UIColor(rgb: 0xe0e0e0) {
        didSet {
            if self.isNodeLoaded {
                if oldValue != self.frameColor {
                    (self.view as! AnySwitch).tintColor = self.frameColor
                }
            }
        }
    }
    public var handleColor = UIColor(rgb: 0xffffff) {
        didSet {
            if self.isNodeLoaded {
                //(self.view as! AnySwitch).thumbTintColor = self.handleColor
            }
        }
    }
    public var contentColor = UIColor(rgb: 0x42d451) {
        didSet {
            if self.isNodeLoaded {
                if oldValue != self.contentColor {
                    (self.view as! AnySwitch).onTintColor = self.contentColor
                }
            }
        }
    }
    
    private var _isOn: Bool = false
    public var isOn: Bool {
        get {
            return self._isOn
        } set(value) {
            if (value != self._isOn) {
                self._isOn = value
                if self.isNodeLoaded {
                    (self.view as! AnySwitch).setOn(value, animated: false)
                }
            }
        }
    }
    
    override public init() {
        super.init()
        
        self.setViewBlock({
            return LiquidGlassSwitch.make()
        })
    }
    
    override open func didLoad() {
        super.didLoad()
        
        self.view.isAccessibilityElement = false
        
        (self.view as! AnySwitch).backgroundColor = self.backgroundColor
        (self.view as! AnySwitch).tintColor = self.frameColor
        (self.view as! AnySwitch).onTintColor = self.contentColor
        
        (self.view as! AnySwitch).setOn(self._isOn, animated: false)
        
        (self.view as! UIControl).addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
    }
    
    public func setOn(_ value: Bool, animated: Bool) {
        self._isOn = value
        if self.isNodeLoaded {
            (self.view as! AnySwitch).setOn(value, animated: animated)
        }
    }
    
    override open func calculateSizeThatFits(_ constrainedSize: CGSize) -> CGSize {
        if #available(iOS 26.0, *) {
            return CGSize(width: 63.0, height: 28.0)
        } else {
            return CGSize(width: 51.0, height: 31.0)
        }
    }
    
    @objc func switchValueChanged(_ view: UIControl) {
        self._isOn = (view as! AnySwitch).isOn
        self.valueUpdated?((view as! AnySwitch).isOn)
    }
}
