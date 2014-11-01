//
//  DetailViewController.swift
//  魔靈資訊
//
//  Created by CK Lam on 25/10/14.
//  Copyright (c) 2014 CK Lam. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var petDetilTable: UITableView!
    @IBOutlet weak var petDetailImg: UIImageView!
    
    var petInfo : AnyObject = []
    var getPetInfo : AnyObject = []
    var giveMePetInfo : [String] = []
    var getCountArray : Int = 0
    
    var ref = Firebase(url:"https://infomorning.firebaseio.com/message/petMessage/petID")
    
    var petInfoDictionary = Dictionary<String, AnyObject>()
    
    var petMessageDictionary = Dictionary<String, AnyObject>()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var testPath = getPetInfo["m_id"] as String!
        
        if let petBigImg = petInfo["imgBigUrl"] as? String{
            petDetailImg.image = UIImage(named: petBigImg)
        }
        
        var refShow = Firebase(url:"https://infomorning.firebaseio.com/message/petMessage/petID/")
        
        
        
        //refShow.setValue("Hey man")
        
        //var postRef = refShow.childByAppendingPath(testPath)
        //var post1 = ["author": "gracehop", "title": "Announcing COBOL, a New Programming Language"]
        //var post1Ref = postRef.childByAutoId()
        //println(post1Ref)
        //println(post1)
        //post1Ref.setValue(post1)
        
        //println(post1Ref.name)
        
        var showMessage = Firebase(url:"https://infomorning.firebaseio.com/message/petMessage/petID/" + testPath!)
        
        println(showMessage)
        
        showMessage.observeEventType(.ChildAdded, withBlock: { snapshot in
            println(snapshot.value.objectForKey("title") as String)
            
        })
        
        
        
        jsonResponsePetDetail()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 4
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        //let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "petCell")
        //let cell : petDetailCell! = tableView.dequeueReusableCellWithIdentifier("petCell") as petDetailCell

        
        
        var cell: petDetailCell = tableView.dequeueReusableCellWithIdentifier("petCellContent") as petDetailCell
        
        println(indexPath.row)
        
        if(indexPath.row == 0){
        
        if let petSkillName = petInfoDictionary["skillName1"] as? String{
            cell.skillName.text = petSkillName
        }
        
        if let petSkill = petInfoDictionary["skill1"] as? String{
            cell.skillContent.text = petSkill
            }
        } else if (indexPath.row == 1){
            if let petSkillName = petInfoDictionary["skillName2"] as? String{
                cell.skillName.text = petSkillName
            }
            
            if let petSkill = petInfoDictionary["skill2"] as? String{
                cell.skillContent.text = petSkill
            }
            
        } else if (indexPath.row == 2){
            if let petSkillName = petInfoDictionary["skillName3"] as? String{
                cell.skillName.text = petSkillName
            }
            
            if let petSkill = petInfoDictionary["skill3"] as? String{
                cell.skillContent.text = petSkill
            }
            
        } else if (indexPath.row == 3){
            if let petSkillName = petInfoDictionary["skillName4"] as? String{
                cell.skillName.text = petSkillName
            }
            
            if let petSkill = petInfoDictionary["skill4"] as? String{
                
                cell.skillContent.text = petSkill
                
            }
            
        }
        cell.skillName.numberOfLines = 0
        cell.skillContent.numberOfLines = 0
        cell.skillContent.sizeToFit()
        return cell

    }
    
    // ========== Get JSON Data From Local ==============//
    
    func jsonResponsePetDetail(){
        let path = NSBundle.mainBundle().pathForResource( "petDetailInfo", ofType: "json" )
        if( path != nil ) {
            //println(path)
            let jsonData = NSData(contentsOfFile: path!, options: .DataReadingMappedIfSafe, error: nil )
            if( jsonData != nil ) {
                let jsonObject: AnyObject! = NSJSONSerialization.JSONObjectWithData( jsonData!, options: NSJSONReadingOptions.MutableContainers, error: nil)
                //println(jsonObject["pet_detail"])
                if let wholePetDetail : AnyObject = jsonObject["pet_detail"] as? NSArray{

                    if let countArray : Array = wholePetDetail as? NSArray{
                       getCountArray = countArray.count as Int
                    }
                    
                    for(var i = 0; i < getCountArray; i++){
                    
                    if let getMonsterDetail : Array = wholePetDetail[i]["monster_detail"] as? NSArray{
                       
                        var selectedPetID = getPetInfo["m_id"] as String!
                        var showDetailID = getMonsterDetail[0]["m_id"] as String!
                        if (selectedPetID == showDetailID){
                            
                            // ========= Assign to Dictionary =============//
                            
                            petInfoDictionary["m_atk"] = getMonsterDetail[0]["m_atk"] as String!
                            petInfoDictionary["m_def"] = getMonsterDetail[0]["m_def"] as String!
                            petInfoDictionary["m_hp"] = getMonsterDetail[0]["m_hp"] as String!
                            petInfoDictionary["m_pic"] = getMonsterDetail[0]["m_pic"] as String!
                            petInfoDictionary["m_spd"] = getMonsterDetail[0]["m_spd"] as String!
                            petInfoDictionary["m_star"] = getMonsterDetail[0]["m_star"] as String!
                            petInfoDictionary["m_type"] = getMonsterDetail[0]["m_type"] as String!
                            
                            //println(petInfoDictionary["m_hp"])
                            
                            
                            // ========= Get Skill ======== //
                            
                            if let getMonsterSkillName : Array = wholePetDetail[i]["monster_skill_name"] as? NSArray{
                                
                                petInfoDictionary["skillName1"] = getMonsterSkillName[0]
                                petInfoDictionary["skillName2"] = getMonsterSkillName[1]
                                petInfoDictionary["skillName3"] = getMonsterSkillName[2]
                                petInfoDictionary["skillName4"] = getMonsterSkillName[3]
                                
                            }
                            
                            
                            if let getMonsterSkill : Array = wholePetDetail[i]["monster_skill"] as? NSArray{
                                
                                petInfoDictionary["skill1"] = getMonsterSkill[0]
                                petInfoDictionary["skill2"] = getMonsterSkill[1]
                                petInfoDictionary["skill3"] = getMonsterSkill[2]
                                petInfoDictionary["skill4"] = getMonsterSkill[3]
                            
                            }
                        }
                        
                        
                        
                        
                    }
                }
                    
                    
                }
            }
        }
        
    }
    
    // ========== Geted =================================//

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
