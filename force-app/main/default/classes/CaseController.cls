/*
* @author mostafa-anm
*
* @description Lightning compatible Case controller.
*/
public with sharing class CaseController {

    /*
    * @description Get a product information relevant to a contact.
    * @param caseId The Id to be used to get it's related contact information.
    * @returns Map of product information.
    */
    @AuraEnabled
    public static Map<String, Object> getProduct(Id caseId) {
        Case c = [
            SELECT
                Id,
                Contact.Product__c,
                Contact.Home_Country__c
            FROM
                Case
            WHERE
                Id = :caseId
        ];

        Product p = new Product(c.Contact.Product__c);
        return new Map<String, Object>{
            'productType' => c.Contact.Product__c,
            'costPerMonth' => p.getCostPerMonth(c.Contact.Home_Country__c),
            'cardReplacementCost' => p.getCardReplacementCost(c.Contact.Home_Country__c),
            'atmFeeInOtherCountries' => p.getatmFeeInOtherCountries(c.Contact.Home_Country__c)
        };
    }
}
