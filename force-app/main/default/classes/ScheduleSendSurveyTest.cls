/**
* @author mostafa-anm
*
* @description Testclass for ScheduleSendSurvey.
*/
@isTest
public class ScheduleSendSurveyTest {

    /*
    * @description Unit test for scheduling ScheduleSendSurvey.
    * @returns Nothing.
    */
    @isTest
    public static void testExecuteSendSurvey() {
        insert new Contact(
            Language__c='en',
            LastName='Last Name',
            FirstName='First Name',
            Email='test@example.com',
            Survey_date__c=Datetime.now().addDays(-1));

        Test.startTest();
        ScheduleSendSurvey scheduler = new ScheduleSendSurvey();
        // Dummy CRON expression daily at 12:00 pm.
        System.schedule('ScheduleSendSurveyTest', '0 0 12 * * ?', scheduler);
        // Since stopTest would execute ScheduleSendSurvey synchronously
        // And SendSurvey is asynchronous so it is not executed and we need to call do that manually.
        scheduler.execute(null);
        Test.stopTest();

        // Expect an email to be sent out.
        System.assertEquals(1, [SELECT count() FROM EmailMessage]);
    }
}
