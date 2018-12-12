
#import <Foundation/Foundation.h>

@interface Addres : NSObject {

}

@property (nonatomic, copy) NSArray *areas;
@property (nonatomic, copy) NSString *countryId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *titleAr;

+ (Addres *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
