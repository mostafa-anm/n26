/**
* @author mostafa-anm
*
* @description Batch class to send surveys to contacts based on their language.
*/
public with sharing class SendSurvey implements Database.Batchable<sObject>, Database.Stateful {

    /**
    * @description Email template Id english version.
    */
    private Id templateIdEnglish = [
        SELECT Id FROM EmailTemplate WHERE DeveloperName = 'Survey_EN'].Id;

    /**
    * @description Email template Id german version.
    */
    private Id templateIdGerman = [
        SELECT Id FROM EmailTemplate WHERE DeveloperName = 'Survey_DE'].Id;

    /**
    * @description Queries contacts who should be surveyed.
    * @param bc Database.BatchableContext.
    */
    public Database.QueryLocator start(Database.BatchableContext bc) {
        Datetime dt = Datetime.now();
        return Database.getQueryLocator(
            'SELECT Id, Language__c FROM Contact WHERE Survey_date__c < :dt');
    }

    /**
    * @description Queries contacts who should be surveyed.
    * @param bc Database.BatchableContext.
    * @param contacts List of contacts to be processed.
    */
    public void execute(Database.BatchableContext bc, List<Contact> contacts) {

        // First determine which email template to use German or English.
        List<Messaging.SingleEmailMessage> emailsToSend = new List<Messaging.SingleEmailMessage>();

        for (Contact c: contacts) {
            Messaging.SingleEmailMessage em = new Messaging.SingleEmailMessage();
            em.setTargetObjectId(c.Id);
            em.setTemplateId(c.Language__c == 'de' ? this.templateIdGerman : this.templateIdEnglish);
            emailsToSend.add(em);
        }

        // Ensure the email daily limit will not be exceeded and send the emails.
        List<Messaging.SendEmailResult> results;

        try {
            Messaging.reserveSingleEmailCapacity(emailsToSend.size());
            results = Messaging.sendEmail(emailsToSend, false);
        } catch (Exception e) {
            // Do something when the daily limits are reached!
            // In real life do something useful.
            return;
        }

        // Collect contact Ids for sucessfully sent emails.
        List<Id> surveyedContactIds = new List<Id>();

        Integer counter = 0;
        for (Messaging.SendEmailResult result: results) {
            if (result.isSuccess()) {
                surveyedContactIds.add(emailsToSend.get(counter).getTargetObjectId());
            } else {
                // Do something to handle errors!
                // In real life do something useful.
            }
            counter++;
        }

        // Finally update the contacts, set survey date to null for successfully sent emails.
        List<Contact> contactsToUpdate = new List<Contact>();

        for (Id contactId: surveyedContactIds) {
            contactsToUpdate.add(
                new Contact(Id=contactId, Survey_date__c=null));
        }
        update contactsToUpdate;
    }

    /**
    * @description Called after the job is finished.
    * @param bc Database.BatchableContext.
    */
    public void finish(Database.BatchableContext bc) {}
}
