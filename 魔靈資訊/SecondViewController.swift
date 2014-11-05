//
//  SecondViewController.swift
//  魔靈資訊
//
//  Created by CK Lam on 25/10/14.
//  Copyright (c) 2014 CK Lam. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var TotalMessageCount = 0;
    
    var refShow = Firebase(url:"https://infomorning.firebaseio.com/message/petMessage/userMessage/")
    
    
    @IBOutlet weak var messageTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        refShow.setValue("Hey man")
        
        var postRef = refShow.childByAutoId()
        var post1 = ["pet": "no", "name": "BB", "content": "Hatwtw"]
        postRef.setValue(post1)
        println(postRef)
        
        //refShow.setValue("Do you have data? You'll love Firebase.")
        
        //println(postRef.ch)
        
        //var showMessage = Firebase(url:"https://infomorning.firebaseio.com/message/petMessage/petID/")
        
        refShow.observeEventType(.ChildAdded, withBlock: { snapshot in
            //self.TotalMessageCount++
            println("added -> \(snapshot.value)")
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    
        return 3
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell : userMessageCell = tableView.dequeueReusableCellWithIdentifier("userCellContent") as userMessageCell
    
        cell.userName.text = "textName"
        
        cell.userMessageContent.text = "Sample Content"
        
        cell.userPet.image = UIImage(named: "pet_small/monster_3.jpg")
        
        return cell
    
    }

}

