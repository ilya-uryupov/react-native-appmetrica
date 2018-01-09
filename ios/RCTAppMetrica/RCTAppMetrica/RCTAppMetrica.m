#import "RCTAppMetrica.h"
#import <YandexMobileMetrica/YandexMobileMetrica.h>

@implementation RCTAppMetrica {
    
}

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(reportEvent:(NSString *)message parameters:(nullable NSDictionary *)params)
{
    if (params == nil) {
        [YMMYandexMetrica reportEvent:message onFailure:NULL];
    }
    else {
        [YMMYandexMetrica reportEvent:message parameters:params onFailure:NULL];
    }
}

RCT_EXPORT_METHOD(reportError:(NSString *)message parameters:(nullable NSDictionary *)params) {
    NSString *paramsJson = [self dictionaryToJson:params];
    NSException *exception = [[NSException alloc] initWithName:@"YandexReportedError" reason:paramsJson userInfo:nil];
    [YMMYandexMetrica reportError:message exception:exception onFailure:NULL];
}

-(NSString*) dictionaryToJson:(nullable NSDictionary *) dictionary {
    if (dictionary == nil) {
        return [[NSString alloc] initWithString:@""];
    }
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:0
                                                         error:&error];
    
    if (!jsonData) {
        NSLog(@"Failed to serialize an error for Yandex AppMetrica: %@", error);
        return [[NSString alloc] initWithString:@""];
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

@end
