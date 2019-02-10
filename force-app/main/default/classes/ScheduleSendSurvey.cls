/*
* @author mostafa-anm
*
* @description Schedulable class to execute SendSurvey on a specific schedule.
*/
public with sharing class ScheduleSendSurvey implements Schedulable {

    /*
    * @description Calls SendSurvey batch job.
    * @param sc SchedulableContext.
    * @returns Nothing.
    */
    public void execute(SchedulableContext sc) {
        Database.executeBatch(new SendSurvey());
    }
}
