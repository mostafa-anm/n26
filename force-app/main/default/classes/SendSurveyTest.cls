/**
* @author mostafa-anm
*
* @description Testclass for SendSurvey.
*/
@isTest
public class SendSurveyTest {

    /*
    * @description Generates contacts as needed.
    * @param maxNumber The number of contacts to be created.
    * @param language The contacts' language in ISO 639-1 format.
    * @param surveyDate The date of survey to be populated for this contacts.
    * @return List of contacts' objects.
    */
    private static List<Contact> generateContacts(Integer maxNumber, String language, DateTime surveyDate) {
        List<Contact> contactsToInsert = new List<Contact>();

        for (Integer i = 0; i < maxNumber; i++) {
            Contact c = new Contact(
                Language__c=language,
                LastName='Last Name' + i,
                FirstName='First Name' + i,
                Survey_date__c=surveyDate,
                Email=i + 'test@example.com');

            contactsToInsert.add(c);
        }
        insert contactsToInsert;

        return [
            SELECT
                Id,
                Email,
                FirstName,
                Survey_date__c
            FROM
                Contact
        ];
    }

    /*
    * @description Helper method for assertions based on language.
    * @param language The language in ISO 639-1 format.
    * @param templateMessage A substring to be checked in the TextBody.
    * return Nothing.
    */
    private static void assertOneSurveySent(String language, String templateMessage) {
        // Make sure the Contact is created and has a survey date.
        Contact c = generateContacts(1, language, Datetime.now().addDays(-1))[0];
        System.assert(c.Survey_date__c != null);

        Test.startTest();
        Database.executeBatch(new SendSurvey());
        Test.stopTest();

        // Expect email to contain contact information and date to be empty.
        EmailMessage em = [SELECT Id, TextBody, Status FROM EmailMessage];
        String contactId = String.valueOf(c.Id).substring(0, 15);

        // Status 3 = sent
        System.assertEquals('3', em.Status);
        System.assert(em.TextBody.contains(contactId));
        System.assert(em.TextBody.contains(c.FirstName));
        System.assert(em.TextBody.contains(templateMessage));

        c = [SELECT Survey_date__c FROM Contact];
        System.assert(c.Survey_date__c == null);
    }

    /*
    * @description Unit test for sending one email in english.
    * @return Nothing.
    */
    @isTest
    public static void testSendOneSurveyEnglish() {
        assertOneSurveySent('en', 'please fill out our survey');
    }

    /*
    * @description Unit test for sending one email in german.
    * @return Nothing.
    */
    @isTest
    public static void testSendOneSurveyGerman() {
        assertOneSurveySent('de', 'bitte fülle unsere Umfrage aus');
    }

    /*
    * @description Unit test for sending many emails that don't exceed the daily limit.
    * @return Nothing.
    */
    @isTest
    public static void testSendManySurveysWithinLimit() {
        generateContacts(10, 'en', Datetime.now().addDays(-1));

        Test.startTest();
        Database.executeBatch(new SendSurvey());
        Test.stopTest();

        System.assertEquals(10, [SELECT count() FROM Contact]);
        System.assertEquals(10, [SELECT count() FROM EmailMessage]);
    }

    /*
    * @description Unit test for sending many emails that exceeds the daily limit.
    * @return Nothing.
    */
    @isTest
    public static void testSendManySurveysExceedingLimit() {
        // For demonstration purposes:
        // Email daily limit is 15 for a dev/scrach org.
        generateContacts(16, 'en', Datetime.now().addDays(-1));

        Test.startTest();
        Database.executeBatch(new SendSurvey());
        Test.stopTest();

        System.assertEquals(16, [SELECT count() FROM Contact]);
        System.assertEquals(0, [SELECT count() FROM EmailMessage]);
    }

    /*
    * @description Unit test for checking that email is not send because the date is in the future.
    * @return Nothing.
    */
    @isTest
    public static void testSurveyDateInFuture() {
        // Don't send an email if the survey date is in the future.
        Datetime frozenDatetime = Datetime.now().addDays(1);
        Contact c = generateContacts(1, 'en', frozenDatetime)[0];

        Test.startTest();
        Database.executeBatch(new SendSurvey());
        Test.stopTest();

        // No emails sent out.
        System.assertEquals(0, [SELECT count() FROM EmailMessage]);

        // Assert survey date not effected.
        System.assertEquals(frozenDatetime, c.Survey_date__c);
    }

    /*
    * @description Unit test for checking that email is not send because contact has no email.
    * @return Nothing.
    */
    @isTest
    public static void testSendSurveyEmailFailed() {
        // If the email failed to send, do not set the survey date to null.
        Datetime frozenDatetime = Datetime.now().addDays(-1);
        Contact c = generateContacts(1, 'en', frozenDatetime)[0];
        c.Email = null;
        update c;

        Test.startTest();
        Database.executeBatch(new SendSurvey());
        Test.stopTest();

        // Make sure no email is sent and the survey date is not null.
        System.assertEquals(0, [SELECT count() FROM EmailMessage]);
        System.assertEquals(frozenDatetime, c.Survey_date__c);
    }
}