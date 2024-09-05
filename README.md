**PlatformCachePartitionUtility**

**Background**

There could be many, but one of the key use cases for Platform Cache that I encountered involved frequent calls to the resource-intensive Schema class methods (one example: getGlobalDescribe method), which were causing latency issues in the Salesforce application and impacting system performance. To improve application performance, a solution was needed to reduce the need for repeated ‘getGlobalDescribe’ calls by efficiently caching object record prefixes and names. The PlatformCachePartitionUtility was developed to address this issue by implementing a caching mechanism that minimizes the number of expensive calls, resulting in significantly improved system performance and reduced data retrieval times to milliseconds.

**Overview**

PlatformCachePartitionUtility is an Apex utility designed to optimize Salesforce applications by caching object record ID prefixes and names. This utility reduces the need for frequent, resource-intensive Schema class methods  across the applications by leveraging platform cache partitions to store and retrieve data efficiently.

**Features**

  ✨ Cache Management: Caches object record ID prefixes and names to minimize resource-intensive calls.

  🔍 Efficient Retrieval: Checks cache before calling describe methods; updates cache if the data is missing.

  ⏳ Configurable Cache Expiry: Allows setting a time-to-live for cached data.

**Installation**

To use the PlatformCachePartitionUtility, follow these steps:

  🛠️ Clone the Repository: git clone https://github.com/SfdcChampsa/Platform-Cache-Utility.git
  
  🚀 Deploy to Salesforce: Deploy the PlatformCachePartitionUtility class to your Salesforce organization using your preferred method (e.g., Salesforce CLI, or directly in Salesforce Developer Console).

**Usage**

🔧 **Method: getObjectNameFromPrefix**

  📜 Description - Caches object record ID prefixes and names in the Org partition to minimize getGlobalDescribe calls. Retrieves cached data if available, otherwise fetches it from Salesforce Schema and updates the cache.
<p align="center">
<img alt="Note" src="https://github.com/user-attachments/assets/a340a343-f730-4887-a02e-1239ebeeb0bf">
</p>

🛠️ **Parameters**

  •	recordIdOrPrefix (String): The record ID or prefix to find its respective object API name.
  
  •	orgPart (Cache.Partition): The Org partition to use. (The partition type should be Cache.Partition.)
  
  •	timeToLiveInSec (Integer): Maximum time in seconds the data will be stored in the cache.

🔄 **Returns** 

  •	String: The object API name associated with the record ID prefix.

📝 **Example** 

Call the generic method provided by PlatformCacheUtility whenever you need to access Prefix/Object data in the application. This method will automatically handle cache hits and misses. [You can adjust the put method to store your application-specific data in the cache as needed.]
<p align="center">
<img alt="Example" src="https://github.com/user-attachments/assets/c8025da3-16c9-46ab-b6a1-76a3ccf75473">
</p>

⚠️ **Error Handling**

If an error occurs while retrieving or caching data, a PlatformCacheException is thrown with a detailed message. Ensure proper exception handling in your implementation.

🚨 **Custom Exception**

The utility includes a custom exception class for error handling:
<p align="center">
<img alt="Custom Exception Class" src="https://github.com/user-attachments/assets/6a63363f-227b-478d-a545-68176c2d8119">
</p>

🤝 **Contributing**

Contributions are welcome! Please follow these guidelines:

  🍴 Fork the repository.

  🌿 Create a new branch (git checkout -b feature-branch).
  
  📝 Commit your changes (git commit -am 'Add new feature').
  
  ⬆️ Push to the branch (git push origin feature-branch).
  
  🔄 Open a Pull Request.


**Contact**: For any questions or support, please contact sfdcchampsa@gmail.com.

**Learn More**: For more information on how to effectively use Platform Cache in your Salesforce applications, check out the Trailhead module below:

    🎓 Level Up Your Skills: https://trailhead.salesforce.com/content/learn/modules/platform_cache
