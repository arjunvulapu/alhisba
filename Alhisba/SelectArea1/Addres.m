

#import "Addres.h"
#import "ExistAddres.h"
@implementation Addres

@synthesize areas, countryId, title, titleAr;

+ (Addres *)instanceFromDictionary:(NSDictionary *)aDictionary {

    Addres *instance = [[Addres alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (NSString *)title {
    //if ([[[MCLocalization sharedInstance] language] isEqualToString:KEY_LANGUAGE_EN]) {
        return title;
//    } else {
//        return [titleAr length] > 0 ? titleAr : title;
//    }
}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }


    NSArray *receivedAreas = [aDictionary objectForKey:@"areas"];
    if ([receivedAreas isKindOfClass:[NSArray class]]) {

        NSMutableArray *populatedAreas = [NSMutableArray arrayWithCapacity:[receivedAreas count]];
        for (NSDictionary *item in receivedAreas) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [populatedAreas addObject:[ExistAddres instanceFromDictionary:item]];
            }
        }

        self.areas = populatedAreas;
    }
    
    self.countryId = [aDictionary objectForKey:@"id"];
    self.title = [aDictionary objectForKey:@"type"];
    self.titleAr = [aDictionary objectForKey:@"type"];

}

- (NSDictionary *)dictionaryRepresentation {

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    if (self.areas) {
        [dictionary setObject:self.areas forKey:@"areas"];
    }

    if (self.countryId) {
        [dictionary setObject:self.countryId forKey:@"countryId"];
    }

    if (self.title) {
        [dictionary setObject:self.title forKey:@"name"];
    }

    if (self.titleAr) {
        [dictionary setObject:self.titleAr forKey:@"titleAr"];
    }

    return dictionary;

}


@end
