/*
* @author mostafa-anm
*
* @description Testclass for Product.
*/
@isTest
public class ProductTest {

    /*
    * @description Unit test for getting product instantiation.
    * @returns Nothing.
    */
    @isTest
    public static void testProduct() {

        Test.startTest();
        Product standardProduct = new Product('Standard');
        Product blackProduct = new Product('Black');
        Product metalProduct = new Product('Metal');
        Test.stopTest();

        System.assert(standardProduct != null);
        System.assert(blackProduct != null);
        System.assert(metalProduct != null);
    }

    /*
    * @description Unit test for handling invalid products.
    * @returns Nothing.
    */
    @isTest
    public static void testWrongProduct() {
        String invalidProduct = 'InvalidProduct';

        try {
            new Product(invalidProduct);
        } catch(Exception e) {
            System.assertEquals('This product is not implemented: ' + invalidProduct, e.getMessage());
        }
    }
}
