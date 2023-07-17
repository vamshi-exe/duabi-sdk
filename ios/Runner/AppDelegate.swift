import UIKit
import Flutter
import CCAvenueUaeVertical


@UIApplicationMain

// implement CCMainViewControllerDelegate to override getResponse method from payment view controller
@objc class AppDelegate: FlutterAppDelegate ,CCMainViewControllerDelegate{
    
    // Global variables to access in all methods
    var paymentController:CCMainViewController?
    var navigationController:UINavigationController?
    var flutterResult:FlutterResult?
    
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    // set navigation controller over flutter view controller
    navigationController = UINavigationController(rootViewController: controller)
    navigationController?.setNavigationBarHidden(true, animated: false)
    // set navigation controller as a root view controller
    self.window!.rootViewController = navigationController
    self.window!.makeKeyAndVisible()
    
    // create method channel object pass from flutter code
    let ccAvenueChannel = FlutterMethodChannel(name: "plugin_ccavenue",
                                                  binaryMessenger: controller.binaryMessenger)
    ccAvenueChannel.setMethodCallHandler({
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            
            let arguements = call.arguments as? NSDictionary
            if(call.method.elementsEqual("payCCAvenue")){
                
                self.openPaymentViewController(result:result,arguements:arguements!)
    
            }
        })
    
      GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    
  }
    
    func openPaymentViewController(result:@escaping FlutterResult, arguements:NSDictionary){
        self.flutterResult = result
        
        let request_dict = getRequest(arguements: arguements)
        
        self.paymentController = CCMainViewController(request: request_dict)
        
        self.paymentController?.delegate = self

        self.paymentController?.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(self.paymentController!, animated: false)
    }
    
    func  getRequest(arguements:NSDictionary?) -> [String:Any]{
        return [
            "customer_id"   : arguements!["customer_id"] as! String,
            "access_code"   : arguements!["accessCode"] as! String,
            "amount"        : arguements!["amount"] as! String,
            "currency"      : arguements!["currency"] as! String,
            "merchant_id"   : Int(arguements!["mId"] as! String)! ,
            "order_id"      : arguements!["order_id"] as! String,
            "promotion"     : arguements!["promo"] as! String,
            "billing_name" : arguements!["billing_name"] as! String,
            "billing_address" : arguements!["billing_address"] as! String,
            "billing_city" : arguements!["billing_city"] as! String,
            "billing_country" : arguements!["billing_country"] as! String,
            "billing_state" : arguements!["billing_state"] as! String,
            "billing_tel" : arguements!["billing_telephone"] as! String,
            "billing_email" : arguements!["billing_email"] as! String,
            "shipping_name" : arguements!["shipping_name"] as! String,
            "shipping_address" : arguements!["shipping_address"] as! String,
            "shipping_city" : arguements!["shipping_city"] as! String,
            "shipping_country" : arguements!["shipping_country"] as! String,
            "shipping_state" : arguements!["shipping_state"] as! String,
            "shipping_tel" : arguements!["shipping_telephone"] as! String,
            "merchant_param1": arguements!["merchantParam1"] as! String,
            "merchant_param2": arguements!["merchantParam2"] as! String,
            "merchant_param3": arguements!["merchantParam3"] as! String,
            "merchant_param4": arguements!["merchantParam4"] as! String,
            "merchant_param5": arguements!["merchantParam5"] as! String,
            "siType": arguements!["siType"] as! String,
            "siMerchantRefNo": arguements!["siRef"] as! String,
            "siSetupAmount": arguements!["siSetupAmount"] as! String,
            "siAmount": arguements!["siAmount"] as! String,
            "siStartDate": arguements!["siStartDate"] as! String,
            "siFrequencyType": arguements!["siFreqType"] as! String,
            "siFrequency": arguements!["siFreq"] as! String,
            "siBillCycle": arguements!["siBillCycle"] as! String,
            "rsa_url": arguements!["rsa_url"] as! String,
            "redirect_url": arguements!["redirect_url"] as! String,
            "cancel_url": arguements!["cancel_url"] as! String,
            "payment_enviroment": arguements!["envType"] as! String,
            "display_address": arguements!["display_address"] as! String
            ] as [String : Any]
    }
    
    func getResponse(_ jsonResponse: [AnyHashable : Any]?) {
        // pop payment view controller and return back on flutterViewController
        self.navigationController?.popViewController(animated: true)
         paymentController = nil
         dump(jsonResponse)
        
        // jump from a background thread to iOS’s main thread to execute a channel method
        DispatchQueue.main.async {
            if let theJSONData = try? JSONSerialization.data(
                withJSONObject: jsonResponse!,
                options: []) {
                let theJSONText = String(data: theJSONData,
                                           encoding: .ascii)
                // pass json response in string format to flutter code
                self.flutterResult!(theJSONText)
            }
            
        }
    }
}
