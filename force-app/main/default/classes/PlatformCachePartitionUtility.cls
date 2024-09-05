/**************************************************************************************************************
Name    :   PlatformCachePartitionUtility
Purpose :   This utility accesses the platform cache partition for a specified key. If the key is not found,
           it stores the data in the Organization partition. If the key is found, it retrieves the cached data.
===============================================================================================================
History
-------                                                            
VERSION     AUTHOR                  DATE                DETAIL                  
1.0         Sfdcchampsa           09/02/2024          INITIAL DEVELOPMENT     
*****************************************************************************************************************/
public class PlatformCachePartitionUtility {

    /*****************************************************************************************************************************
    * Method Name   :   getObjectNameFromPrefix
    *
    * Purpose       :   Caches object record ID prefixes and names in the Org partition to reduce the frequency of resource-intensive
    *                   Schema class method calls. Checks the cache first; if the record ID prefix is not found, retrieves 
    *                   the information using Schema class describe methods and updates the cache, reducing repeated calls 
    *                   to resource-intensive methods.
    *
    * Parameters    :   recordIdOrPrefix -> Record ID or prefix to find its respective object API name
    *                   orgPart -> The Org partition to use. (The partition type should be Cache.Partition.)
    *                   timeToLiveInSec -> Maximum time in seconds the data will be stored in the cache.
    *
    * Result        :   This approach mitigates Salesforce application latency issues and reduces data retrieval times to milliseconds.
    ***********************************************************************************************************************************/
    public static String getObjectNameFromPrefix(String recordIdOrPrefix, Cache.Partition orgPart, Integer timeToLiveInSec) {
      
        if (String.isEmpty(recordIdOrPrefix) || recordIdOrPrefix.length() < 3) {
            throw new IllegalArgumentException('Record ID or prefix must be at least 3 characters long.');
        }
        
        try {
            String recIdPrefix = recordIdOrPrefix.substring(0, 3);
            
            if (orgPart.contains(recIdPrefix)) {
                // Cache hit block: Return the data from cache.
                return (String) orgPart.get(recIdPrefix);
            } else {
                // Cache miss block: Retrieve data and store in cache.
                String sobjectName = '';
                Map<String, Schema.SObjectType> sobjectAPIandTypeMap = Schema.getGlobalDescribe();
                for (Schema.SObjectType sobjType : sobjectAPIandTypeMap.values()) {
                    Schema.DescribeSObjectResult sobjTypeMetadata = sobjType.getDescribe();
                    if (sobjTypeMetadata.getKeyPrefix() != Null && sobjTypeMetadata.getKeyPrefix().equals(recIdPrefix)) {
                        sobjectName = sobjTypeMetadata.getName();
                        orgPart.put(recIdPrefix, sobjectName, timeToLiveInSec);
                        break;
                    }
                }
                return sobjectName;
            }
        } catch (Exception excep) {
            // Throw custom exception with detailed message
            throw new PlatformCacheException('Exception occurred while accessing Platform Cache to retrieve object name from prefix: ' + excep.getMessage());
        }
    }
}