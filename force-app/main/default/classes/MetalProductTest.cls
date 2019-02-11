/*
* @author mostafa-anm
*
* @description Testclass for MetalProduct.
*/
@isTest
public class MetalProductTest {

    /*
    * @description Unit test for getting metal product information.
    * @returns Nothing.
    */
    @isTest
    public static void testMetalProduct() {
        String homeCountry = 'UK';

        Test.startTest();
        MetalProduct testProduct = new MetalProduct();

        Decimal costPerMonth = testProduct.getCostPerMonth(homeCountry);
        Decimal cardReplacementCost = testProduct.getCardReplacementCost(homeCountry);
        Decimal atmFeeInOtherCountries = testProduct.getAtmFeeInOtherCountries(homeCountry);
        Test.stopTest();

        System.assertEquals(null, costPerMonth);
        System.assertEquals(45, cardReplacementCost);
        System.assertEquals(0, atmFeeInOtherCountries);
    }
}
