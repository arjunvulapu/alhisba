

#import "ExistAddres.h"

@implementation ExistAddres

//@synthesize countryAreaId, title, titleAr;

+ (ExistAddres *)instanceFromDictionary:(NSDictionary *)aDictionary {

    ExistAddres *instance = [[ExistAddres alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (NSString *)title {
    //if ([[[MCLocalization sharedInstance] language] isEqualToString:KEY_LANGUAGE_EN]) {
        return _title;
//    } else {
//        return [titleAr length] > 0 ? titleAr : title;
//    }
}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    _addresId = [aDictionary objectForKey:@"id"];
    _title = [aDictionary objectForKey:@"type"];
//    self.city = [aDictionary objectForKey:@"city"];
//    self.stateName = [aDictionary objectForKey:@"state"];
//    self.titleAr = [aDictionary objectForKey:@"address"];
//    self.address1 = [aDictionary objectForKey:@"address1"];
//    self.address2 = [aDictionary objectForKey:@"address2"];
//    self.postCode = [aDictionary objectForKey:@"postcode"];
//    self.mobileNo = [aDictionary objectForKey:@"phone"];
//    self.pinCode = [aDictionary objectForKey:@"pincode"];
//    self.state = [[aDictionary valueForKey:@"state"] valueForKey:@"title"];
    
    _addresId = [aDictionary objectForKey:@"id"];
    self.type = [aDictionary objectForKey:@"type"];
    self.phone = [aDictionary objectForKey:@"phone"];
    self.block = [aDictionary objectForKey:@"block"];
    self.street = [aDictionary objectForKey:@"street"];
    self.building = [aDictionary objectForKey:@"building"];
    self.flat = [aDictionary objectForKey:@"flat"];
    self.jaddah = [aDictionary objectForKey:@"juddah"];
    self.firstName = [aDictionary objectForKey:@"fname"];
    self.lastName = [aDictionary objectForKey:@"lname"];
    self.email_id = [aDictionary objectForKey:@"email"];

}

- (NSDictionary *)dictionaryRepresentation {

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

//    if (self.countryAreaId) {
//        [dictionary setObject:self.countryAreaId forKey:@"countryAreaId"];
//    }

    if (self.title) {
        [dictionary setObject:self.title forKey:@"type"];
    }

//    if (self.titleAr) {
//        [dictionary setObject:self.titleAr forKey:@"titleAr"];
//    }

    return dictionary;

}


@end
