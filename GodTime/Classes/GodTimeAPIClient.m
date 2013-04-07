#import "GodTimeAPIClient.h"
#import "AFJSONRequestOperation.h"

static NSString * const kGodTimeAPIBaseURLString = @"https://godtime.herokuapp.com";

@implementation GodTimeAPIClient

+ (GodTimeAPIClient *)sharedClient {
    static GodTimeAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kGodTimeAPIBaseURLString]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}

#pragma mark - AFIncrementalStore

- (id)representationOrArrayOfRepresentationsFromResponseObject:(id)responseObject {
    return responseObject;
}

- (NSDictionary *)representationsForRelationshipsFromRepresentation:(NSDictionary *)representation ofEntity:(NSEntityDescription *)entity fromResponse:(NSHTTPURLResponse *)response
{
    NSMutableDictionary *mutableRelationshipValues = [[super representationsForRelationshipsFromRepresentation:representation ofEntity:entity fromResponse:response] mutableCopy];
    
    if([entity.name isEqualToString:@"Prayer"]) {
        NSDictionary *detail = mutableRelationshipValues[@"created_by"];
        mutableRelationshipValues[@"created_by"] = [detail allValues][0];
        
        detail = mutableRelationshipValues[@"created_for"];
        mutableRelationshipValues[@"created_for"] = [detail allValues][0];
    }
    
    return mutableRelationshipValues;
}

- (NSDictionary *)attributesForRepresentation:(NSDictionary *)representation 
                                     ofEntity:(NSEntityDescription *)entity 
                                 fromResponse:(NSHTTPURLResponse *)response 
{
    NSMutableDictionary *mutablePropertyValues = [[super attributesForRepresentation:representation ofEntity:entity fromResponse:response] mutableCopy];
    
    // Customize the response object to fit the expected attribute keys and values  
    
    return mutablePropertyValues;
}

- (BOOL)shouldFetchRemoteAttributeValuesForObjectWithID:(NSManagedObjectID *)objectID
                                 inManagedObjectContext:(NSManagedObjectContext *)context
{
    return NO;
}

- (BOOL)shouldFetchRemoteValuesForRelationship:(NSRelationshipDescription *)relationship
                               forObjectWithID:(NSManagedObjectID *)objectID
                        inManagedObjectContext:(NSManagedObjectContext *)context
{
    return NO;
}

@end
