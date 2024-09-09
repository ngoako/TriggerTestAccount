trigger AccountTrigger on Account (before insert, after insert) {
    
    if(Trigger.isInsert){
        if(Trigger.isBefore){
            AccountHandler.updateRating(Trigger.new);
            AccountHandler.copyBillingToShipping(Trigger.new);
        }
        else if(trigger.isAfter){
            AccountHandler.createRelatedContact(Trigger.new);
            AccountHandler.createRelatedOpportunity(Trigger.new);
        }
    }
    
}