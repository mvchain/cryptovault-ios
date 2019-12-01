//
//    OrderDetailRepayPlanDOS.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation




class OrderDetailRepayPlanDOS : NSObject, NSCoding{

    var capitalRemain : Double!
    var createdby : Int!
    var createdon : String!
    var currentPeriods : Int!
    var currentPeriodsStr : String!
    var mainCustomer : String!
    var marginDeduction : Int!
    var modifiedby : Int!
    var modifiedon : String!
    var orderId : Int!
    var orderNo : String!
    var planRepayDate : String!
    var productName : String!
    var repaidCapitalInterest : Int!
    var repayCapital : Double!
    var repayInterest : Double!
    var repayPlanId : Int!
    var repayRemaining : Double!
    var repayRental : Double!
    var repayTotal : Double!
    var tenantId : Int!
    var totalPeriods : Int!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        capitalRemain = dictionary["capitalRemain"] as? Double
        createdby = dictionary["createdby"] as? Int
        createdon = dictionary["createdon"] as? String
        currentPeriods = dictionary["currentPeriods"] as? Int
        currentPeriodsStr = dictionary["currentPeriodsStr"] as? String
        mainCustomer = dictionary["mainCustomer"] as? String
        marginDeduction = dictionary["marginDeduction"] as? Int
        modifiedby = dictionary["modifiedby"] as? Int
        modifiedon = dictionary["modifiedon"] as? String
        orderId = dictionary["orderId"] as? Int
        orderNo = dictionary["orderNo"] as? String
        planRepayDate = dictionary["planRepayDate"] as? String
        productName = dictionary["productName"] as? String
        repaidCapitalInterest = dictionary["repaidCapitalInterest"] as? Int
        repayCapital = dictionary["repayCapital"] as? Double
        repayInterest = dictionary["repayInterest"] as? Double
        repayPlanId = dictionary["repayPlanId"] as? Int
        repayRemaining = dictionary["repayRemaining"] as? Double
        repayRental = dictionary["repayRental"] as? Double
        repayTotal = dictionary["repayTotal"] as? Double
        tenantId = dictionary["tenantId"] as? Int
        totalPeriods = dictionary["totalPeriods"] as? Int
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if capitalRemain != nil{
            dictionary["capitalRemain"] = capitalRemain
        }
        if createdby != nil{
            dictionary["createdby"] = createdby
        }
        if createdon != nil{
            dictionary["createdon"] = createdon
        }
        if currentPeriods != nil{
            dictionary["currentPeriods"] = currentPeriods
        }
        if currentPeriodsStr != nil{
            dictionary["currentPeriodsStr"] = currentPeriodsStr
        }
        if mainCustomer != nil{
            dictionary["mainCustomer"] = mainCustomer
        }
        if marginDeduction != nil{
            dictionary["marginDeduction"] = marginDeduction
        }
        if modifiedby != nil{
            dictionary["modifiedby"] = modifiedby
        }
        if modifiedon != nil{
            dictionary["modifiedon"] = modifiedon
        }
        if orderId != nil{
            dictionary["orderId"] = orderId
        }
        if orderNo != nil{
            dictionary["orderNo"] = orderNo
        }
        if planRepayDate != nil{
            dictionary["planRepayDate"] = planRepayDate
        }
        if productName != nil{
            dictionary["productName"] = productName
        }
        if repaidCapitalInterest != nil{
            dictionary["repaidCapitalInterest"] = repaidCapitalInterest
        }
        if repayCapital != nil{
            dictionary["repayCapital"] = repayCapital
        }
        if repayInterest != nil{
            dictionary["repayInterest"] = repayInterest
        }
        if repayPlanId != nil{
            dictionary["repayPlanId"] = repayPlanId
        }
        if repayRemaining != nil{
            dictionary["repayRemaining"] = repayRemaining
        }
        if repayRental != nil{
            dictionary["repayRental"] = repayRental
        }
        if repayTotal != nil{
            dictionary["repayTotal"] = repayTotal
        }
        if tenantId != nil{
            dictionary["tenantId"] = tenantId
        }
        if totalPeriods != nil{
            dictionary["totalPeriods"] = totalPeriods
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         capitalRemain = aDecoder.decodeObject(forKey: "capitalRemain") as? Double
         createdby = aDecoder.decodeObject(forKey: "createdby") as? Int
         createdon = aDecoder.decodeObject(forKey: "createdon") as? String
         currentPeriods = aDecoder.decodeObject(forKey: "currentPeriods") as? Int
         currentPeriodsStr = aDecoder.decodeObject(forKey: "currentPeriodsStr") as? String
         mainCustomer = aDecoder.decodeObject(forKey: "mainCustomer") as? String
         marginDeduction = aDecoder.decodeObject(forKey: "marginDeduction") as? Int
         modifiedby = aDecoder.decodeObject(forKey: "modifiedby") as? Int
         modifiedon = aDecoder.decodeObject(forKey: "modifiedon") as? String
         orderId = aDecoder.decodeObject(forKey: "orderId") as? Int
         orderNo = aDecoder.decodeObject(forKey: "orderNo") as? String
         planRepayDate = aDecoder.decodeObject(forKey: "planRepayDate") as? String
         productName = aDecoder.decodeObject(forKey: "productName") as? String
         repaidCapitalInterest = aDecoder.decodeObject(forKey: "repaidCapitalInterest") as? Int
         repayCapital = aDecoder.decodeObject(forKey: "repayCapital") as? Double
         repayInterest = aDecoder.decodeObject(forKey: "repayInterest") as? Double
         repayPlanId = aDecoder.decodeObject(forKey: "repayPlanId") as? Int
         repayRemaining = aDecoder.decodeObject(forKey: "repayRemaining") as? Double
         repayRental = aDecoder.decodeObject(forKey: "repayRental") as? Double
         repayTotal = aDecoder.decodeObject(forKey: "repayTotal") as? Double
         tenantId = aDecoder.decodeObject(forKey: "tenantId") as? Int
         totalPeriods = aDecoder.decodeObject(forKey: "totalPeriods") as? Int

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if capitalRemain != nil{
            aCoder.encode(capitalRemain, forKey: "capitalRemain")
        }
        if createdby != nil{
            aCoder.encode(createdby, forKey: "createdby")
        }
        if createdon != nil{
            aCoder.encode(createdon, forKey: "createdon")
        }
        if currentPeriods != nil{
            aCoder.encode(currentPeriods, forKey: "currentPeriods")
        }
        if currentPeriodsStr != nil{
            aCoder.encode(currentPeriodsStr, forKey: "currentPeriodsStr")
        }
        if mainCustomer != nil{
            aCoder.encode(mainCustomer, forKey: "mainCustomer")
        }
        if marginDeduction != nil{
            aCoder.encode(marginDeduction, forKey: "marginDeduction")
        }
        if modifiedby != nil{
            aCoder.encode(modifiedby, forKey: "modifiedby")
        }
        if modifiedon != nil{
            aCoder.encode(modifiedon, forKey: "modifiedon")
        }
        if orderId != nil{
            aCoder.encode(orderId, forKey: "orderId")
        }
        if orderNo != nil{
            aCoder.encode(orderNo, forKey: "orderNo")
        }
        if planRepayDate != nil{
            aCoder.encode(planRepayDate, forKey: "planRepayDate")
        }
        if productName != nil{
            aCoder.encode(productName, forKey: "productName")
        }
        if repaidCapitalInterest != nil{
            aCoder.encode(repaidCapitalInterest, forKey: "repaidCapitalInterest")
        }
        if repayCapital != nil{
            aCoder.encode(repayCapital, forKey: "repayCapital")
        }
        if repayInterest != nil{
            aCoder.encode(repayInterest, forKey: "repayInterest")
        }
        if repayPlanId != nil{
            aCoder.encode(repayPlanId, forKey: "repayPlanId")
        }
        if repayRemaining != nil{
            aCoder.encode(repayRemaining, forKey: "repayRemaining")
        }
        if repayRental != nil{
            aCoder.encode(repayRental, forKey: "repayRental")
        }
        if repayTotal != nil{
            aCoder.encode(repayTotal, forKey: "repayTotal")
        }
        if tenantId != nil{
            aCoder.encode(tenantId, forKey: "tenantId")
        }
        if totalPeriods != nil{
            aCoder.encode(totalPeriods, forKey: "totalPeriods")
        }

    }

}
