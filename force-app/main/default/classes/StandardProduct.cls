/*
* @author mostafa-anm
*
* @description Product class with type standard used as the implementation in the strategy pattern.
*/
public with sharing class StandardProduct implements ProductService {

    /*
    * @description Cost per month and country mapping.
    */
    private Map<String, Decimal> costPerMonth = new Map<String, Decimal>{
        'DE' => 0,
        'FR' => 0,
        'ES' => 0,
        'IT' => 0,
        'UK' => 0
    };

    /*
    * @description Card replacement cost and country mapping.
    */
    private Map<String, Decimal> cardReplacementCost = new Map<String, Decimal>{
        'DE' => 6,
        'FR' => 6,
        'ES' => 6,
        'IT' => 6,
        'UK' => 6
    };

    /*
    * @description Atm fee in other countries and country mapping.
    */
    private Map<String, Decimal> atmFeeInOtherCountries = new Map<String, Decimal>{
        'DE' => 1.7,
        'FR' => 1.7,
        'ES' => 1.7,
        'IT' => 1.7,
        'UK' => 1.7
    };

    /*
    * @description Get the cost per month for this standard product.
    * @param country The home country.
    * @returns The cost per month.
    */
    public Decimal getCostPerMonth(String country) {
        return this.costPerMonth.get(country);
    }

    /*
    * @description Get the cost per card replacement for this standard product.
    * @param country The home country.
    * @returns The cost per card replacement.
    */
    public Decimal getCardReplacementCost(String country) {
        return this.cardReplacementCost.get(country);
    }


    /*
    * @description Get the atm fee for this standard product.
    * @param country The home country.
    * @returns The fee per withdrawal.
    */
    public Decimal getAtmFeeInOtherCountries(String country) {
        return this.atmFeeInOtherCountries.get(country);
    }
}
