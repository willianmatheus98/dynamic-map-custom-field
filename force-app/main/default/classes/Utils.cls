public with sharing class Utils {
        
    /**
    * @description return the map by custom field with unique value possible for each unique key
    * @author Willian Batista | 2021-11-16 
    * @param records 
    * @param fieldName 
    * @return Map<Object, Sobject> 
    **/
    public static Map<Object, Sobject> getMapUniqueByCustomField(List<Sobject> records, String fieldName){
        Map<Object, Sobject> response = new Map<Object, Sobject>();
        for(Sobject sobj: records){
            Object key = sobj.get(fieldName);
            if(key != null){
                response.put(key, sobj);
            }
        }
        
        return response;
    }
    
    /**
    * @description return the map by custom field with collection of values possible for each unique key
    * @author Willian Batista | 2021-11-16 
    * @param records 
    * @param fieldName 
    * @return Map<Object, List<Sobject>> 
    **/
    public static Map<Object, List<Sobject>> getMapByCustomField(List<Sobject> records, String fieldName){
        Map<Object, List<Sobject>> response = new Map<Object, List<Sobject>>();
        for(Sobject sobj: records){
            Object key = sobj.get(fieldName);
            if(key != null){
                List<Sobject> sobjs = response.containskey(key)? response.get(key) : new List<Sobject>();
                sobjs.add(sobj);
                response.put(key, sobjs);
            }
        }
        
        return response;
    }
}