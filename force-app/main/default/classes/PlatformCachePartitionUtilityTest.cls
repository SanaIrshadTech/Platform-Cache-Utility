/*******************************************************************************************************************
Name    :   PlatformCachePartitionUtilityTest
Purpose :   Test class for PlatformCachePartitionUtility Class to cover Cache hit, miss, and exception scenarios.
====================================================================================================================
History                                                            
-------                                                            
VERSION     AUTHOR                  DATE                DETAIL                  
1.0         Sfdcchampsa           09/02/2024          INITIAL DEVELOPMENT     
********************************************************************************************************************/
@isTest
private class PlatformCachePartitionUtilityTest {
    
    /*
    * Method for cache hit scenario
    */
    @isTest
    static void testGetObjectNameFromPrefix_CacheHit() {
        // Get cache partition
        Cache.Partition orgPart = Cache.Org.getPartition('local.DemoPlatformCachePartition');
        orgPart.put('001', 'Account', 3600); // put the Account prefix and object name in cache for TTL as 1 hour
        
        Test.startTest();
        String result = PlatformCachePartitionUtility.getObjectNameFromPrefix('001', orgPart, 3600);
        Test.stopTest();
        
        // Assert statement
        System.assertEquals('Account', result, 'The object name should be retrieved from the cache.');
    }
    
    /*
    * Method for cache miss scenario
    */
    @isTest
    static void testGetObjectNameFromPrefix_CacheMiss() {
        // Get cache partition
        Cache.Partition orgPart = Cache.Org.getPartition('local.DemoPlatformCachePartition');
        
        Test.startTest();
        String result = PlatformCachePartitionUtility.getObjectNameFromPrefix('500', orgPart, 3600);
        Test.stopTest();
        
        // Assert statement
        System.assertEquals('Case', result, 'The object name should be inserted into cache after cache miss.');
    }
    
    /*
    * Method to simulate an exception scenario by providing an invalid cache partition TTL
    */
    @isTest
    static void testExceptionHandling() {
        // Get cache partition
        Cache.Partition orgPart = Cache.Org.getPartition('local.DemoPlatformCachePartition');
        
        Test.startTest();
        try {
            // Provide an invalid cache partition TTL or other invalid parameters to simulate the exception
            String result = PlatformCachePartitionUtility.getObjectNameFromPrefix('003', orgPart, 6);
            System.assert(false, 'Exception should be thrown.');
        } catch (PlatformCacheException ex) {
            // Assert the exception details
            System.assert(ex.getMessage().contains('Exception occurred while accessing Platform Cache'), 
                          'Exception message should indicate a cache access issue.');
        }
        Test.stopTest();
    }
}