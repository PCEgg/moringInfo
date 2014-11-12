//
//  DetailViewController.swift
//  魔靈資訊
//
//  Created by CK Lam on 25/10/14.
//  Copyright (c) 2014 CK Lam. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var pagePetName: UILabel!

    @IBOutlet weak var petDetilTable: UITableView!
    @IBOutlet weak var petDetailImg: UIImageView!
    
    var petInfo : AnyObject = []
    var getPetInfo : AnyObject = []
    var giveMePetInfo : [String] = []
    var getCountArray : Int = 0
    
    var petInfoDictionary = Dictionary<String, AnyObject>()
    
    var petMessageDictionary = Dictionary<String, AnyObject>()
  
    override func viewDidLoad() {
        super.viewDidLoad()

        
        var testPath = getPetInfo["m_id"] as String!
        var petName = getPetInfo["m_name"] as String!
        
        pagePetName.text = petName

        // ======= set background image ========= //
        self.petDetilTable.backgroundView = UIImageView(image: UIImage(named: "detailBg.png"))
        
        jsonResponsePetDetail()
        
        if let petBigImg = petInfoDictionary["m_pic"] as? String{
            //println(petBigImg)
            petDetailImg.image = UIImage(named: petBigImg)
        }
        
        self.petDetilTable.estimatedRowHeight = 77.0
        self.petDetilTable.rowHeight = UITableViewAutomaticDimension

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
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        var cell: petDetailCell = tableView.dequeueReusableCellWithIdentifier("petCellContent") as petDetailCell
        
        //println(indexPath.row)
        
        //var messageCell: petDetailCell = tableView.dequeueReusableCellWithIdentifier("messageCellContent") as petDetailCell
        
        
        if(indexPath.row == 0){
        
        cell.skillName.text = "隊長技"
        
        
        if let petSkill = petInfoDictionary["skill1"] as? String{
            cell.skillContent.text = petSkill
            }
        } else if (indexPath.row == 1){
                cell.skillName.text = "技能一"
            
            if let petSkill = petInfoDictionary["skill2"] as? String{
                cell.skillContent.text = petSkill
            } else {
                
                cell.skillContent.text = "沒有"
            }
            
        } else if (indexPath.row == 2){
                cell.skillName.text = "技能二"
            
            if let petSkill = petInfoDictionary["skill3"] as? String{
                cell.skillContent.text = petSkill
            } else {
                
                cell.skillContent.text = "沒有"
            }
            
        } else if (indexPath.row == 3){
                cell.skillName.text = "技能三"
            
            if let petSkill = petInfoDictionary["skill4"] as? String{
                cell.skillContent.text = petSkill
            } else {
            
                cell.skillContent.text = "沒有"
            }
            
        } /*else {
            //println(petMessageDictionary["author"])
            if let petMessageUser = petMessageDictionary["author"] as? String{
                messageCell.petMessageContent.text = petMessageUser
            }
            if let petMessageContent = petMessageDictionary["title"] as? String{
                messageCell.petMessageContent.text = petMessageContent
            }
        }
*/
        cell.skillName.numberOfLines = 0
        cell.skillContent.numberOfLines = 0
        cell.skillContent.sizeToFit()
        cell.backgroundColor = UIColor.clearColor()
        
        /*messageCell.petMessageUser.numberOfLines = 0
        messageCell.petMessageContent.numberOfLines = 0
        messageCell.petMessageContent.sizeToFit()*/
        
        /*if(indexPath.row <= 3){
            return cell
        } else {
            return messageCell
        }*/
        
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerImg = UIImageView(image: UIImage(named: "skillHeader"))
        
        return headerImg
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 30
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerImg = UIImageView(image: UIImage(named: "skillFooter"))
        
        return footerImg
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 30
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
                            //println(getMonsterDetail[0]["m_pic"])
                            // ========= Assign to Dictionary =============//
                            petInfoDictionary["m_pic"] = getMonsterDetail[0]["m_pic"] as String!
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
