import { LightningElement, track, api } from 'lwc';
import getProduct from '@salesforce/apex/CaseController.getProduct';

/**
* Class representing ProductInformation.
* @extends LightningElement
*/
export default class ProductInformation extends LightningElement {

    /**
    * RecordId from lightning.
    */
    @api
    recordId;

    /**
    * Type of product.
    */
   @api
   productType;

    /**
    * Reactive property to hold the cost per month for a product.
    */
    @track
    costPerMonth;

    /**
    * Property to check if product is available.
    * @return {Boolean} true or false.
    */
    get isAvailable() {
        return this.costPerMonth !== undefined ? true : false;
    }

    /**
    * Reactive property to hold the card replacement cost for a product.
    */
    @track
    cardReplacementCost;

    /**
    * Reactive property to hold the atm fee in other countries for a product.
    */
    @track
    atmFeeInOtherCountries;

    /**
    * Property to check if product package atm fees are excluded.
    * @return {Boolean} true or false.
    */
    get isFreeWithdrawal() {
        return this.atmFeeInOtherCountries ? true : false;
    }

    /**
    * Reactive property to display an error.
    */
    @track
    error;

    /**
    * Gets product information from apex controller and set class properties.
    */
    connectedCallback() {
        getProduct({ caseId: this.recordId })
            .then(result => {
                this.productType = result.productType;
                this.costPerMonth = result.costPerMonth;
                this.cardReplacementCost = result.cardReplacementCost;
                this.atmFeeInOtherCountries = result.atmFeeInOtherCountries;
                // In real life application there should be proper error handling.
                this.error = undefined;
            })
            .catch(error => {
                this.error = error;
                this.costPerMonth = undefined;
                this.cardReplacementCost = undefined;
                this.atmFeeInOtherCountries = undefined;
            });
    }
}
