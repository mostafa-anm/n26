/*
* @author mostafa-anm
*
* @description Testclass for BlackProduct.
*/
@isTest
public class BlackProductTest {

    /*
    * @description Unit test for getting black product information.
    * @returns Nothing.
    */
    @isTest
    public static void testBlackProduct() {
        String homeCountry = 'UK';

        Test.startTest();
        BlackProduct testProduct = new BlackProduct();

        Decimal costPerMonth = testProduct.getCostPerMonth(homeCountry);
        Decimal cardReplacementCost = testProduct.getCardReplacementCost(homeCountry);
        Decimal atmFeeInOtherCountries = testProduct.getAtmFeeInOtherCountries(homeCountry);
        Test.stopTest();

        System.assertEquals(null, costPerMonth);
        System.assertEquals(6, cardReplacementCost);
        System.assertEquals(0, atmFeeInOtherCountries);
    }
}
