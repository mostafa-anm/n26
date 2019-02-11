# SFDX N26 Test App


This includes both features and related metadata configuration.

These metadata are ready and can be pushed to a scrach org. Where the tests can be ran.
For displaying the lightning web component, contact and case data are needed as well as including the LWC in any case layout.

## Survey feature:

* `SendSurvey.cls` -- Is the batch class to send out emails.
* `ScheduleSendSurvey.cls` -- Is the scheduler class to execute the batch apex

## Product feature:
This is build using the strategy design pattern.

* `CaseController.cls` -- Is called from the LWC to get product information based on Contact Id.

* `ProductService.cls` -- Is the interface for the products. (Strategy)
* `StandardProduct.cls` -- Represents a product information and implements the interface. (Strategy implementation)
* `BlackProduct.cls` -- Same as above. 
* `MetalProduct.cls` -- Same as above
* `Product.cls` -- Is the context so to say to get the any type of product information.

* `productinformation.html` Is the lightning web component markup to display data.
* `productinformation.js` Is the lightning web component logic to call the apex controller and pass data to markup.


The rest are test classes and the related metadata are found in `Email` and `Objects` folder.

