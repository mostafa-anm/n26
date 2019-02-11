/*
* @author mostafa-anm
*
* @description Testclass for CaseController.
*/
@isTest
public  class CaseControllerTest {

    /*
    * @description Unit test for getting product information.
    * @returns Nothing.
    */
    @isTest
    public static void testGetProduct() {
        Contact testContact =  new Contact(
            LastName='Last Name',
            Home_Country__c='DE',
            Product__c='Standard');

        insert testContact;

        Case testCase = new Case(
            Subject='Test',
            ContactId=testContact.Id);

        insert testCase;

        Test.startTest();
        Map<String, Object> result = CaseController.getProduct(testCase.Id);
        Test.stopTest();

        // Assert correct product type.
        System.assertEquals('Standard', result.get('productType'));
        // Assert correct results from StandardProduct class.
        System.assertEquals(0, result.get('costPerMonth'));
        System.assertEquals(6, result.get('cardReplacementCost'));
        System.assertEquals(1.7, result.get('atmFeeInOtherCountries'));
    }
}
