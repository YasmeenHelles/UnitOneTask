//
//  Extension.swift
//



import Foundation
import UIKit
import SystemConfiguration
import MediaPlayer
import AVFoundation


var vSpinner :UIView?


extension UINavigationBar {
    
    func setBottomBorderColor(color: UIColor, height: CGFloat) {
        let bottomBorderRect = CGRect(x: 0, y: frame.height, width: frame.width, height: height)
        let bottomBorderView = UIView(frame: bottomBorderRect)
        bottomBorderView.backgroundColor = color
        addSubview(bottomBorderView)
    }
    
    var shadow: Bool {
        get {
            return false
        }
        set {
            if newValue {
                self.layer.shadowOffset = CGSize(width: 0, height: 2)
                self.layer.shadowColor = UIColor.lightGray.cgColor
                self.layer.shadowRadius = 3
                self.layer.shadowOpacity = 0.5;
            }
        }
    }
    
    func setNavClear() {
        self.setBackgroundImage(UIImage(), for: .default)
    }
    
    func setNavUNClear() {
        self.setBackgroundImage("22A2A5".color.colorToImage(), for: .default)
    }
}

extension UIColor {
    
    func colorToImage() -> UIImage
    {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        let ctx = UIGraphicsGetCurrentContext()
        self.setFill()
        ctx!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    //random color
    static func getRandomColor() -> UIColor{
        
        let randomRed:CGFloat = CGFloat(drand48())
        
        let randomGreen:CGFloat = CGFloat(drand48())
        
        let randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }
}

extension UIView {
    func setRounded() {
        let radius = self.frame.height / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func removeRounded() {
        self.layer.cornerRadius = 0
        self.layer.masksToBounds = true
    }
    
    func setRounded(radius:CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func setBorderGray() {
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
    }
    
    func setBorder(width:CGFloat,color:UIColor) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
   
    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], gradientOrientation orientation: GradientOrientation) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = orientation.startPoint
        gradient.endPoint = orientation.endPoint
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    
    // OUTPUT 1
    func dropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 2
        
    }
    
    func dropShadowLigh() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: -5)
        self.layer.shadowRadius = 5
        
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
        self.layer.borderWidth = 0.0
    }
    
    func addShadowView(color:CGColor,width:Int,height:Int,Opacity:Float,radius:CGFloat,cornerRadius:CGFloat) {
        self.layer.shadowColor = color
        self.layer.shadowOffset = CGSize(width: width, height: height)
        self.layer.shadowOpacity = Opacity
        self.layer.shadowRadius = radius
        self.layer.masksToBounds = false
        self.layer.cornerRadius = cornerRadius
    }
    
    func func_addGernalShadow(_ height:Int = 4){
        let color = "455B63".color.withAlphaComponent(0.1).cgColor
        self.addShadowView(color: color, width: 0, height: height, Opacity: 16, radius: 16, cornerRadius: 12)
    }
    
    func func_addSubGernalShadow(_ height:Int = 4){
        let color = "000000".color.withAlphaComponent(0.1).cgColor
        self.addShadowView(color: color, width: 0, height: height, Opacity: 2, radius: 4, cornerRadius: 2)
    }
    
    
    func func_setBlurView(){
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
    
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    
    func toPngImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let pngImageData: Data? = image!.pngData()
        let finalImage = UIImage(data: pngImageData!)
        return finalImage!
    }
      func fadeIn(_ duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
                 self.alpha = 1.0
                 }, completion: completion)  }
     
        func fadeOut(_ duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
            UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
                self.alpha = 0.0
                }, completion: completion)
        }

}

extension UIViewController {
    
    func showSpinner(onView : UIView) {
        
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
            self.view.isUserInteractionEnabled = false
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            self.view.isUserInteractionEnabled = true
            vSpinner = nil
        }
    }
    

       
//    func showIndicator() {
//           let myFont = MyTools.tool.appFont(size: 15)
//           SKActivityIndicator.statusLabelFont(myFont)
//           SKActivityIndicator.setDarkMode()
//           SKActivityIndicator.spinnerStyle(.spinningFadeCircle)
//           SKActivityIndicator.show("".localized ,userInteractionStatus: false)
//       }
//
//       func hideIndicator() {
//           SKActivityIndicator.dismiss()
//       }
    func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
 



    func popVC(_ animated:Bool = true) {
        self.navigationController?.pop(animated: animated)
    }
    func popToRootVC(_ animated:Bool = true) {
        self.navigationController?.popToRoot(animated: animated)
    }
    
    func pushVC(_ vc:UIViewController,_ animated:Bool = true) {
        self.navigationController?.pushViewController(vc, animated: animated)
    }

    func presentVC(_ vc:UIViewController,_ animated:Bool = true) {
        self.present(vc, animated: animated, completion: nil)
    }
    
    func dismissVC(_ animated:Bool = true,_ completion: (() -> Void)? = nil) {
        self.dismiss(animated: animated, completion: completion)
    }
    
    func dismissAllVC(_ animated:Bool = true,_ completion: (() -> Void)? = nil) {
        self.view.window!.rootViewController?.dismissVC(animated, completion)
    }

 
}

extension UIAlertController {
    func supportIpad(_ view:UIView){
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
        {
            // Ipad
            self.popoverPresentationController?.sourceView = view
            self.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
        }
    }
}

extension UIStoryboard {
    func instanceVC<T: UIViewController>() -> T {
        guard let vc = instantiateViewController(withIdentifier: String(describing: T.self)) as? T else {
            fatalError("Could not locate viewcontroller with with identifier \(String(describing: T.self)) in storyboard.")
        }
        return vc
    }
}

extension UITableView {
    func dequeueTVCell<T: UITableViewCell>() -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self)) as? T else {
            fatalError("Could not locate viewcontroller with with identifier \(String(describing: T.self)) in storyboard.")
        }
        return cell
    }
    func registerCell(id: String) {
        self.register(UINib(nibName: id, bundle: nil), forCellReuseIdentifier: id)
    }
}

extension UICollectionView {
    func dequeueCVCell<T: UICollectionViewCell>(indexPath:IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("Could not locate viewcontroller with with identifier \(String(describing: T.self)) in storyboard.")
        }
        return cell
    }
    
    func registerCell(id: String) {
        self.register(UINib(nibName: id, bundle: nil), forCellWithReuseIdentifier: id)
    }
}

extension String
{
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }

    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    var containsWhitespace : Bool {
        return (self.rangeOfCharacter(from: .whitespacesAndNewlines) != nil)
    }
    
    var containtSpecialCharacter : Bool {
        let characterset = CharacterSet(charactersIn: "!@#$%^&*()=<>?/\';~`٫±§")
        //"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.-_")
        return self.rangeOfCharacter(from: characterset) != nil ?  true : false
    }
 
    //cut first caracters from full names
    public func getAcronyms(separator: String = "") -> String {
        let acronyms = self.components(separatedBy: " ").map({ String($0.first!) }).joined(separator: separator);
        return acronyms;
    }
    
    //remove spaces from text
    var trimmed:String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var prepareFilterFirstString : String {
        return self.trimmed.first?.description ?? ""
    }
    private var convertHtmlToNSAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else {
            return nil
        }
        do {
            return try NSAttributedString(data: data,options: [.documentType: NSAttributedString.DocumentType.html,.characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }
    public func convertHtmlToAttributedStringWithCSS(font: UIFont? , csscolor: String , csstextalign: String) -> NSAttributedString? {
           guard let font = font else {
               return convertHtmlToNSAttributedString
           }
           let modifiedString = "<style>body{font-family: '\(font.fontName)'; font-size:\(font.pointSize)px; color: \(csscolor); text-align: \(csstextalign); }</style>\(self)";
           guard let data = modifiedString.data(using: .utf8) else {
               return nil
           }
           do {
               return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
           }
           catch {
               print(error)
               return nil
           }
       }
    var htmlToAttributedString: NSAttributedString? {
           guard let data = data(using: .utf8) else { return NSAttributedString() }
           do {
               return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
           } catch {
               return NSAttributedString()
           }
       }
       var htmlToString: String {
           return htmlToAttributedString?.string ?? ""
       }
    var isEmailValid: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    
    var isMobileValid: Bool {
//        do {
//            let regStr2 =  "^(1)?[0-9]{3}?[0-9]{3}?[0-9]{4}$"
//            let regex = try NSRegularExpression(pattern: regStr2, options: .caseInsensitive)
//            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
//        } catch {
//            return false
//        }
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
            if let res = matches.first { return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count } else { return false } } catch { return false }
    }
    
    var isUrlValid : Bool {
        if let url = URL.init(string: self){
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    
    var isEmptyStr:Bool{
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces).isEmpty
    }
    
    var color: UIColor {
        let hex = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            return UIColor.clear
        }
        return UIColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    var cgColor: CGColor {
        return self.color.cgColor
    }
    
    var TrimAllSpaces:String {
        return self.components(separatedBy: .whitespacesAndNewlines).joined()
    }
    
    var TrimWhiteSpaces:String {
        return self.trimmingCharacters(in: .whitespaces)
    }
    
    func height(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.height
    }
    
    func width(height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.width
    }
    
    
    var removeHtmlTags:String {
//        return   self.replacingOccurrences(of: "<div*></div>", with: "")
        let regex:NSRegularExpression  = try! NSRegularExpression(  pattern: "<.*?>", options: .caseInsensitive)
        let range = NSMakeRange(0, self.count)
        let htmlLessString :String = regex.stringByReplacingMatches(in: self, options: NSRegularExpression.MatchingOptions(), range:range , withTemplate: "")
        
        return htmlLessString.replacingOccurrences(of: "&amp;", with: "")
    }

    var toImage: UIImage {
        if self == "" {
            return UIImage()
        }else{
            return UIImage(named: self)!
        }
    }
    
   
    
    func func_ArNumberToEn() -> String {
        let Formatter: NumberFormatter = NumberFormatter()
        Formatter.locale = NSLocale(localeIdentifier: "EN") as Locale?
        let finaltxtNo = Formatter.number(from: self)
        return "00\(finaltxtNo!)"
    }
    func func_TrimCharacters() -> String {
        let result = self.trimmingCharacters(in: CharacterSet(charactersIn: "01234567890.").inverted)
        return  "\(result)"
    }
    
    func func_replacePlusInCountruCode() -> String {
        let result = self.replacingOccurrences(of: "+", with: "00")
        return  "\(result)"
    }
    
    var func_replaceZerosInCountruCode : String {
        let result = self.dropFirst(2).description
        return  "+\(result)"
    }
    
    func replacingCharacter(newStr:String,range:NSRange) -> String {
        let str = NSString(string: self).replacingCharacters(in: range, with : newStr) as NSString
        return String(str)
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
 
    func func_setUpFontawsomeIconOld() -> String {
        let icon = self.dropFirst(6).description.capitalizingFirstLetter()
        return icon
    }
    func func_setUpFontawsomeIcon() -> String {
        let icon = self.dropFirst(3).description
        return icon
    }
}

extension UITextField
{
    //@Change placeholder color
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
    func setLeftView(width:Int){
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: width, height: Int(self.frame.size.height))
        self.leftView = leftView
        self.leftViewMode = .always
    }
    
    func setRightView(width:Int) {
        let rightView = UIView()
        rightView.frame = CGRect(x: 0, y: 0, width: width, height: Int(self.frame.size.height))
        self.rightView = rightView
        self.rightViewMode = .always
    }
    public var substituteFontName : String {
        get {
            return self.font?.fontName ?? "";
        }
        set {
            let fontNameToTest = self.font?.fontName.lowercased() ?? "";
            var fontName = newValue;
            if fontNameToTest.range(of: "bold") != nil {
                fontName += "-Bold";
            } else if fontNameToTest.range(of: "medium") != nil {
                fontName += "-Medium";
            } else if fontNameToTest.range(of: "light") != nil {
                fontName += "-Light";
            } else if fontNameToTest.range(of: "ultralight") != nil {
                fontName += "-UltraLight";
            }
            self.font = UIFont(name: fontName, size: self.font?.pointSize ?? 17)
        }
    }
}
  extension UITextView {
      public var substituteFontName : String {
          get {
              return self.font?.fontName ?? "";
          }
          set {
              let fontNameToTest = self.font?.fontName.lowercased() ?? "";
              var fontName = newValue;
              if fontNameToTest.range(of: "bold") != nil {
                  fontName += "-Bold";
              } else if fontNameToTest.range(of: "medium") != nil {
                  fontName += "-Medium";
              } else if fontNameToTest.range(of: "light") != nil {
                  fontName += "-Light";
              } else if fontNameToTest.range(of: "ultralight") != nil {
                  fontName += "-UltraLight";
              }
              self.font = UIFont(name: fontName, size: self.font?.pointSize ?? 17)
          }
      }
  }

extension UINavigationController
{
    func pop(animated: Bool) {
        _ = self.popViewController(animated: animated)
    }
    
    func popToRoot(animated: Bool) {
        _ = self.popToRootViewController(animated: animated)
    }
    public func removePreviousController(total: Int){
        let totalViewControllers = self.viewControllers.count
        self.viewControllers.removeSubrange(totalViewControllers-total..<totalViewControllers)
    }
}

extension UINavigationItem
{
    func hideBackWord()  {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.backBarButtonItem = backItem
    }
}

extension Date {
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
    
    var nextDay : Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    var previousDay:Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
    
    func nextDays(_ day:Int = 1) -> Date {
        return Calendar.current.date(byAdding: .day, value: day, to: self)!
    }
    func previousDays(_ day:Int = -1) -> Date {
        return Calendar.current.date(byAdding: .day, value: day, to: self)!
    }
    
    func previousYaers(_ day:Int = -1) -> Date {
        return Calendar.current.date(byAdding: .year, value: day, to: self)!
    }

    func isBetween(_ start: Date,_ end: Date) -> Bool {
        return start.compare(self).rawValue * self.compare(end).rawValue >= 0
    }
    
    func func_addMinuteToDate(_ value:Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: value, to: self)!
    }
    
    func monthAsString() -> String {
        let df = DateFormatter()
        df.setLocalizedDateFormatFromTemplate("MMM")
        return df.string(from: self)
    }
    
}

extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
    
    var isKeyboardPresented: Bool {
        if let keyboardWindowClass = NSClassFromString("UIRemoteKeyboardWindow"), self.windows.contains(where: { $0.isKind(of: keyboardWindowClass) }) {
            return true
        } else {
            return false
        }
    }
}

extension UIWindow {
    
    func capture() -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(self.frame.size, self.isOpaque, UIScreen.main.scale)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}

extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    func createSelectionIndicator(color: UIColor, size: CGSize, lineWidth: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x: 11, y: 0, width: size.width - 11, height: lineWidth))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    func resizeImageWith(newSize: CGSize) -> UIImage {
        
        let horizontalRatio = newSize.width / size.width
        let verticalRatio = newSize.height / size.height
        
        let ratio = max(horizontalRatio, verticalRatio)
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
        draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }

    convenience init(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in:UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: image!.cgImage!)
    }
    
    func func_updateImageOrientionUpSide() -> UIImage? {
        if self.imageOrientation == .up {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        if let normalizedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return normalizedImage
        }
        UIGraphicsEndImageContext()
        return nil
    }
    class func imageWithColor(color: UIColor, size: CGSize) -> UIImage
    {
        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    func maskWithColor(_ color: UIColor) -> UIImage {
        let maskImage = cgImage!
        
        let width = size.width + 30
        let height = size.height + 5
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height),
                                bitsPerComponent: 8,bytesPerRow: 0,
                                space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return "placeholder".toImage
        }
    }

}


// Set Gradient To Any View

typealias GradientPoints = (startPoint: CGPoint, endPoint: CGPoint)

enum GradientOrientation {
    case topRightBottomLeft
    case topLeftBottomRight
    case horizontal
    case vertical
    
    var startPoint : CGPoint {
        get { return points.startPoint }
    }
    
    var endPoint : CGPoint {
        get { return points.endPoint }
    }
    
    var points : GradientPoints {
        get {
            switch(self) {
            case .topRightBottomLeft:
                return (CGPoint.init(x: 0.0,y: 1.0), CGPoint.init(x: 1.0,y: 0.0))
            case .topLeftBottomRight:
                return (CGPoint.init(x: 0.0,y: 0.0), CGPoint.init(x: 1,y: 1))
            case .horizontal:
                return (CGPoint.init(x: 0.0,y: 0.5), CGPoint.init(x: 1.0,y: 0.5))
            case .vertical:
                return (CGPoint.init(x: 0.0,y: 0.0), CGPoint.init(x: 0.0,y: 1.0))
            }
        }
    }
}


extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    mutating func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return Darwin.round(self * divisor) / divisor
    }
    
    func formatPoints() -> String {
        
        var thousandNum = self/1000
        var millionNum = self/1000000
        if self >= 1000 && self < 1000000{
            if(floor(thousandNum) == thousandNum){
                return("\(Int(thousandNum))" + "k".localized)
            }
            return("\(thousandNum.roundToPlaces(places: 1))" + "k".localized)
        }
        if self >= 1000000{
            if(floor(millionNum) == millionNum){
                return("\(Int(millionNum))" + "M".localized)
            }
            return ("\(millionNum.roundToPlaces(places: 1))" + "M".localized)
        }
        else{
            if(floor(self) == self){
                return ("\(Int(self))")
            }
            return ("\(self)")
        }
    }
}

extension UILabel
{
    func setUnderLine() {
        let textRange = NSMakeRange(0, self.text!.count)
        let attributedText = NSMutableAttributedString(string: self.text!)
        attributedText.addAttribute(NSAttributedString.Key.underlineStyle,
                                    value:NSUnderlineStyle.single.rawValue,
                                    range: textRange)
        
        self.attributedText = attributedText
    }
    
    func calculateMaxLines() -> Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(Float.infinity))
        let charSize = font.lineHeight
        let text = (self.text ?? "") as NSString
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        let linesRoundedUp = Int(ceil(textSize.height/charSize))
        return linesRoundedUp
    }
    @objc public var substituteFontName : String {
        get {
            return self.font.fontName;
        }
        set {
            let fontNameToTest = self.font.fontName.lowercased()
            var fontName = newValue
            if fontNameToTest.range(of: "bold") != nil {
                fontName += "-Bold"
            } else if fontNameToTest.range(of: "medium") != nil {
                fontName += "-Medium"
            } else if fontNameToTest.range(of: "light") != nil {
                fontName += "-Light"
            } else if fontNameToTest.range(of: "ultralight") != nil {
                fontName += "-UltraLight"
            }
            self.font = UIFont(name: fontName, size: self.font.pointSize)
        }
    }
}

extension UIScreen {
    var sizeType: SizeType {
        switch nativeBounds.height {
        case 960:
            return .iPhones4
        case 1136:
            return .iPhones5_SE
        case 1334:
            return .iPhones678
        case 1792:
            return .iPhone_XR
        case 1920, 2208:
            return .iPhones_678Plus
        case 2436:
            return .iPhones_X_XS
        case 2688:
            return .iPhone_XSMax
        default:
            return .unknown
        }
    }
    
    enum SizeType: String {
        case iPhones4 = "iPhone 4 or iPhone 4S"
        case iPhones5_SE = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
        case iPhones678 = "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
        case iPhones_678Plus = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus"
        case iPhones_X_XS = "iPhone X or iPhone XS"
        case iPhone_XR = "iPhone XR"
        case iPhone_XSMax = "iPhone XS Max"
        case unknown
    }
    
//    enum SizeType: CGFloat {
//        case Unknown = 0.0
//        case iPhone4 = 960.0
//        case iPhone5 = 1136.0
//        case iPhone6 = 1334.0
//        case iPhone6Plus = 1920.0
//        case iPhoneX = 2436
//    }
//
//    var sizeType: SizeType {
//        let height = nativeBounds.height
//        guard let sizeType = SizeType(rawValue: height) else { return .Unknown }
//        return sizeType
//    }
}

extension UILabel {
    func setStrikethroughStyle(text:String) {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string:text)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        self.attributedText = attributeString
    }

}

extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":                return "iPhone X"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad6,11", "iPad6,12":                    return "iPad 5"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7 Inch"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9 Inch"
        case "iPad7,1", "iPad7,2":                      return "iPad Pro 12.9 Inch 2. Generation"
        case "iPad7,3", "iPad7,4":                      return "iPad Pro 10.5 Inch"
        case "AppleTV5,3":                              return "Apple TV"
        case "AppleTV6,2":                              return "Apple TV 4K"
        case "AudioAccessory1,1":                       return "HomePod"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    
}


extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
    
}

extension Array where Element: Comparable {
    func containsSameElements(as other: [Element]) -> Bool {
        return self.count == other.count && self.sorted() == other.sorted()
    }
}
extension MPVolumeView {
    static func setVolume(_ volume: Float) {
        let volumeView = MPVolumeView()
        let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
            slider?.value = volume
        }
    }
}


extension AVURLAsset {
    var fileSize: Int? {
        let keys: Set<URLResourceKey> = [.totalFileSizeKey, .fileSizeKey]
        let resourceValues = try? url.resourceValues(forKeys: keys)

        return resourceValues?.fileSize ?? resourceValues?.totalFileSize
    }
}
extension UIApplication {
    class func topViewController(viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topViewController(viewController: nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(viewController: selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(viewController: presented)
        }
        return viewController
    }
}
