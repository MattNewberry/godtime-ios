#import "AFIncrementalStore.h"
#import "AFRestClient.h"

@interface GodTimeAPIClient : AFRESTClient <AFIncrementalStoreHTTPClient>

+ (GodTimeAPIClient *)sharedClient;

@end
