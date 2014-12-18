//
//  SPGooglePlacesAutocompleteQuery.m
//  SPGooglePlacesAutocomplete
//
//  Created by Stephen Poletto on 7/17/12.
//  Copyright (c) 2012 Stephen Poletto. All rights reserved.
//

#import "SPGooglePlacesAutocompleteQuery.h"
#import "SPGooglePlacesAutocompletePlace.h"

@interface SPGooglePlacesAutocompleteQuery()
@property (nonatomic, copy, readwrite) SPGooglePlacesAutocompleteResultBlock resultBlock;
@end

@implementation SPGooglePlacesAutocompleteQuery

@synthesize input, sensor, key, offset, location, radius, language, types, resultBlock;

+ (SPGooglePlacesAutocompleteQuery *)query {
    return [[[self alloc] init] autorelease];
}

- (id)init {
    self = [super init];
    if (self) {
        // Setup default property values.
        self.sensor = NO;
        self.key = kGoogleAPIKey;
        self.offset = NSNotFound;
        self.location = CLLocationCoordinate2DMake(-1, -1);
        self.radius = NSNotFound;
        self.types = -1;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Query URL: %@", [self googleURLString]];
}

- (void)dealloc {
    [googleConnection release];
    [responseData release];
    [input release];
    [key release];
    [language release];
    [super dealloc];
}

- (NSString *)googleURLString {
    
    /*
    https://maps.googleapis.com/maps/api/place/search/json?location=-33.8670522,151.1957362&radius=500&types=food&sensor=true&key=AddYourOwnKeyHere
  
    https://maps.googleapis.com/maps/api/place/autocomplete/json?input=Universit%C3%A0%20di%20Catania&sensor=true&key=_API_KEY_&radius=100.000000&language=it
    
    */
//    NSMutableString *url = [NSMutableString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&sensor=%@&key=%@&country=GB&radius=200&language=en&location=54.559322587438636,-4.1748046875",
//                                                             [input stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
//                                                             SPBooleanStringForBool(sensor), key];
    
    //"https://maps.googleapis.com/maps/api/js?sensor=false&libraries=places"
   // https://maps.googleapis.com/maps/api/place/radarsearch/json?location=51.503186,-0.126446&radius=5000&types=museum&key=AddYourOwnKeyHere
    
    
   /* NSMutableString *url = [NSMutableString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&sensor=%@&key=%@&components=country:GB&types=geocode&cities&radius=200&language=en&location=54.559322587438636,-4.1748046875",
                            [input stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                            SPBooleanStringForBool(sensor), key];
    */
    NSMutableString *url = [NSMutableString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&sensor=%@&key=%@&types=geocode&cities&radius=200&language=en",
                            [input stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                            SPBooleanStringForBool(sensor), key];
    
    //regions=administrative_area_level_1
    
    
    
    if (offset != NSNotFound) {
        [url appendFormat:@"&offset=%lu", (unsigned long)offset];
    }
    if (location.latitude != -1) {
        [url appendFormat:@"&location=%f,%f", location.latitude, location.longitude];
    }
    if (radius != NSNotFound) {
        [url appendFormat:@"&radius=%f", radius];
    }
    if (language) {
        [url appendFormat:@"&language=%@", language];
    }
    if (types != -1) {
        [url appendFormat:@"&types=%@", SPPlaceTypeStringForPlaceType(types)];
    }
    return url;
}

- (void)cleanup {
    [googleConnection release];
    [responseData release];
    googleConnection = nil;
    responseData = nil;
    self.resultBlock = nil;
}

- (void)cancelOutstandingRequests {
    [googleConnection cancel];
    [self cleanup];
}

- (void)fetchPlaces:(SPGooglePlacesAutocompleteResultBlock)block {
    if (!SPEnsureGoogleAPIKey()) {
        return;
    }
    
    if (SPIsEmptyString(self.input)) {
        // Empty input string. Don't even bother hitting Google.
        block([NSArray array], nil);
        return;
    }
    
    [self cancelOutstandingRequests];
    self.resultBlock = block;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[self googleURLString]]];
    googleConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    responseData = [[NSMutableData alloc] init];
}

#pragma mark -
#pragma mark NSURLConnection Delegate

- (void)failWithError:(NSError *)error {
    if (self.resultBlock != nil) {
        self.resultBlock(nil, error);
    }
    [self cleanup];
}

- (void)succeedWithPlaces:(NSArray *)places {
    NSMutableArray *parsedPlaces = [NSMutableArray array];
    for (NSDictionary *place in places) {
        [parsedPlaces addObject:[SPGooglePlacesAutocompletePlace placeFromDictionary:place]];
    }
    if (self.resultBlock != nil) {
        self.resultBlock(parsedPlaces, nil);
    }
    [self cleanup];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    if (connection == googleConnection) {
        [responseData setLength:0];
    }
}

- (void)connection:(NSURLConnection *)connnection didReceiveData:(NSData *)data {
    if (connnection == googleConnection) {
        [responseData appendData:data];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if (connection == googleConnection) {
        [self failWithError:error];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if (connection == googleConnection) {
        NSError *error = nil;
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
        if (error) {
            [self failWithError:error];
            return;
        }
        if ([[response objectForKey:@"status"] isEqualToString:@"ZERO_RESULTS"]) {
            [self succeedWithPlaces:[NSArray array]];
            return;
        }
        if ([[response objectForKey:@"status"] isEqualToString:@"OK"]) {
            [self succeedWithPlaces:[response objectForKey:@"predictions"]];
            return;
        }
        
        // Must have received a status of OVER_QUERY_LIMIT, REQUEST_DENIED or INVALID_REQUEST.
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[response objectForKey:@"status"] forKey:NSLocalizedDescriptionKey];
        [self failWithError:[NSError errorWithDomain:@"com.spoletto.googleplaces" code:kGoogleAPINSErrorCode userInfo:userInfo]];
    }
}

@end