//
//  FirstViewController.swift
//  魔靈資訊
//
//  Created by CK Lam on 25/10/14.
//  Copyright (c) 2014 CK Lam. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, DataEnteredDelegate{
    
    // ======= init Value =========== //
    var arr: AnyObject = []
    var filteredArr: AnyObject = []
    var namesID: [String] = []
    var petImg: [String] = []
    var petName: [String] = []
    var forTesting: String = ""
    var forTestingCount: Int = 0
    var userDataEntered: Bool = false
    var letMeDie: [String] = []
    var letMeDieNum: [String] = []
    // ======= init Value end ======= //
    

    @IBOutlet weak var petCollect: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        jsonResponse()
        filteredArr = arr
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // ========== Collection view code ==================//
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{

        return petImg.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as
            PetsCollectionViewCell

        cell.petImg.image = UIImage(named: petImg[indexPath.row])
        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let selectedImg = petCollect.cellForItemAtIndexPath(indexPath)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "petDetailSection"){
            
            //let indexPath = self.tableView.indexPathForSelectedRow()
            //let post = myCollection[indexPath!.row].id
            
            let detailVC = segue.destinationViewController as DetailViewController
            
            var selectedItems:NSArray = petCollect.indexPathsForSelectedItems()!
            var selectedItem:NSIndexPath = selectedItems[0] as NSIndexPath
            
            let selectedPhotoIndex = selectedItem.row
            
            
            if(letMeDieNum.isEmpty){
                detailVC.getPetInfo = filteredArr[selectedPhotoIndex]
            } else{
                let hihiPoint = letMeDieNum[selectedPhotoIndex].toInt()
                detailVC.getPetInfo = filteredArr[hihiPoint!]
                
            }
            
            

        }
        
        if(segue.identifier == "showFilter"){
            
            let filterVC = segue.destinationViewController as FilterViewController
            filterVC.delegate = self
            
        }
        
    }
    
    // ========== Collection view code end ==============//
    
    // ========== Get JSON Data From Local ==============//
    
    func jsonResponse(){
        let path = NSBundle.mainBundle().pathForResource( "petListJs", ofType: "json" )
        if( path != nil ) {
            //println(path)
            let jsonData = NSData(contentsOfFile: path!, options: .DataReadingMappedIfSafe, error: nil )
            if( jsonData != nil ) {
                let jsonObject: AnyObject! = NSJSONSerialization.JSONObjectWithData( jsonData!, options: NSJSONReadingOptions.MutableContainers, error: nil)
                
                if let wholePetDetail = jsonObject as? NSArray{
                    
                    arr = wholePetDetail
                    
                    var showHowManyItems = wholePetDetail.count
                    for(var i = 0; i < showHowManyItems; i++){
                        if let petDetail = wholePetDetail[i] as? NSDictionary{
    
                            let petSmallPic : AnyObject? = petDetail["m_pic"]
                            
                            petImg.append(petSmallPic as String)
                            
                            let getPetName : AnyObject? = petDetail["m_name"]
                            
                            petName.append(getPetName as String)
                            
                        }
                    }

                }
            }
        }
        
    }
    
    // ========== Geted =================================//
    override func viewWillAppear(animated: Bool) {
       //self.petCollect.reloadData()
    }
    
    
    // ========== Get search result ====================//

    func userDidEnteredInformation(info: NSString) {
        filteredArr = arr
        
        var showHowManyItems = filteredArr.count
        if(info == "1" || info == "2" || info == "3" || info == "4" || info == "5" || info == "6"){
        petImg.removeAll()
            //println(filteredArr)
            
            for(var i = 0; i < showHowManyItems; i++){
                
            
            if let petDetail = arr[i] as? NSDictionary{
                

                if( info == petDetail["m_star"] as String){
                    
                    
                    let petSmallPic : AnyObject? = petDetail["m_pic"]
                    
                    petImg.append(petSmallPic as String)
                    
                    letMeDieNum.append(String(i))

                }
            }
        }
        }
        self.petCollect.reloadData()
        //self.petCollect.reloadItemsAtIndexPaths(<#indexPaths: [AnyObject]#>)
    }
    

     // ========== Get search result end =============//

}

