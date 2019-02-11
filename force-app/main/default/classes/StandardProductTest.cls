/*
* @author mostafa-anm
*
* @description Testclass for StandardProduct.
*/
@isTest
public class StandardProductTest {

    /*
    * @description Unit test for getting standard product information.
    * @returns Nothing.
    */
    @isTest
    public static void testStandardProduct() {
        String homeCountry = 'UK';

        Test.startTest();
        StandardProduct testProduct = new StandardProduct();

        Decimal costPerMonth = testProduct.getCostPerMonth(homeCountry);
        Decimal cardReplacementCost = testProduct.getCardReplacementCost(homeCountry);
        Decimal atmFeeInOtherCountries = testProduct.getAtmFeeInOtherCountries(homeCountry);
        Test.stopTest();

        System.assertEquals(0, costPerMonth);
        System.assertEquals(6, cardReplacementCost);
        System.assertEquals(1.7, atmFeeInOtherCountries);
    }
}
