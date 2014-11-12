//
//  FilterViewController.swift
//  魔靈資訊
//
//  Created by CK Lam on 10/11/14.
//  Copyright (c) 2014 CK Lam. All rights reserved.
//

import UIKit

protocol DataEnteredDelegate{
    func userDidEnteredInformation(info: NSString)
}

class FilterViewController: UIViewController {
    
    var delegate:DataEnteredDelegate? = nil

    @IBAction func submitBtn(sender: AnyObject) {
        if (delegate != nil){
            let information:NSString = textField.text
            let cateInformation:NSString = textField.text
            
            delegate!.userDidEnteredInformation(information)
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    @IBOutlet weak var textField: UITextField! = UITextField()
    
    @IBOutlet weak var cateDemoField: UITextField!
    
    @IBOutlet weak var typeField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
