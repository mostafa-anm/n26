/*
* @author mostafa-anm
*
* @description Product interface used as the strategy to be implemented by different products.
*/
public interface ProductService {

    /*
    * @description Cost per month for a specific product and country.
    */
    Decimal getCostPerMonth(String country);

    /*
    * @description Card replacement cost for a specific product and country.
    */
    Decimal getCardReplacementCost(String country);

    /*
    * @description Atm fee for a specific product and country.
    */
    Decimal getAtmFeeInOtherCountries(String country);
}