/*
* @author mostafa-anm
*
* @description Product class that returns information about the product and is
* used as the context in a strategy pattern.
*/
public with sharing class Product {

    /*
    * @description Exception to be raised when product name is not found.
    */
    public class ProductException extends Exception {}

    /*
    * @description Interface ProductService to be assinged a product type.
    */
    private ProductService productServiceType;

    /*
    * @description Constructor determine the product type or throw an exception.
    * @param name The product name.
    * @returns Nothing.
    */
    public Product(String name) {

        switch on name {
            when 'Standard' {
                productServiceType = new StandardProduct();
            }
            when 'Black' {
                productServiceType = new BlackProduct();
            }
            when 'Metal' {
                productServiceType = new MetalProduct();
            }
            when else {
                throw new ProductException('This product is not implemented: ' + name);
            }
        }
    }

    /*
    * @description Get the cost per month based on product type and country.
    * @param country The home country.
    * @returns The cost per month.
    */
    public Decimal getCostPerMonth(String country){
        return productServiceType.getCostPerMonth(country);
    }

    /*
    * @description Get the cost to replace a card based on product type and country.
    * @param country The home country.
    * @returns Cost for card replacement.
    */
    public Decimal getCardReplacementCost(String country) {
        return productServiceType.getCardReplacementCost(country);
    }

    /*
    * @description Get the atm fee based on product type and country.
    * @param country The home country.
    * @returns The fee per withdrawal.
    */
    public Decimal getAtmFeeInOtherCountries(String country) {
        return productServiceType.getAtmFeeInOtherCountries(country);
    }
}
