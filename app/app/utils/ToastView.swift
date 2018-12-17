import UIKit

class ToastView: UIView {
    
    fileprivate var tipLabel = UILabel()
    
    override  init(frame: CGRect) {
        super.init(frame: frame)
      
        
    }
    public let NavigationH: CGFloat = 64
    public let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.size.width
    public let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.size.height
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(tips:String)
    {
        self.init()
        self.createMain(tips)
    }
    func createMain(_ tips:String)
    {
        tipLabel = UILabel()
        tipLabel.font = UIFont.systemFont(ofSize: 15.0)
        tipLabel.text = tips
        tipLabel.textColor = UIColor.white
        tipLabel.sizeToFit()
        tipLabel.frame = CGRect(x: 4, y: 4, width: tipLabel.frame.size.width, height: tipLabel.frame.size.height)
        
        self.frame = CGRect(x: 0, y: 0, width: tipLabel.frame.size.width+8, height: tipLabel.frame.size.height+8)
        self.layer.cornerRadius = 3.0
        self.center = CGPoint(x: SCREEN_WIDTH/2, y: SCREEN_HEIGHT/2)
        self.backgroundColor = UIColor.init(ts_hexString: "333333", alpha: 0.7)
        self.addSubview(tipLabel)
    }
    
    func show(_ duration: Double?)
    {
        var durationTime: Double = 0.0
        if duration == nil {
            durationTime = 0.6
        }else{
            durationTime = duration!
        }
        //添加到keyWindow上
        let keyWindow = UIApplication.shared.keyWindow
        keyWindow?.addSubview(self)
        
        weak var weakSelf = self
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(1.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: { () -> Void in
            
            UIView.animate(withDuration: durationTime, animations: { () -> Void in
                weakSelf?.alpha = 0.0
            }, completion: { (finished:Bool) -> Void in
                if(finished)
                {
                    weakSelf?.removeFromSuperview()
                }
            })
            
        })
    }
    
    
    
    //调用类方法 即可 省略初始化方法
    class func showMessage(_ tips:String)
    {
        let tipView = ToastView(tips: tips)
        tipView.show(nil)
    }
    
    class func showMessage(_ tips: String,duration: Double) {
        let tipView = ToastView(tips: tips)
        tipView.show(duration)
    }
    
    
}
