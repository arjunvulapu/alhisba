

#import <Foundation/Foundation.h>

@interface ExistAddres : NSObject {

}

//@property (nonatomic, copy) NSString *countryStateId;
@property (nonatomic, copy) NSString *title;
//@property (nonatomic, copy) NSString *city;
//@property (nonatomic, copy) NSString *stateName;
//@property (nonatomic, copy) NSString *titleAr;
//@property (nonatomic, copy) NSString *address1;
//@property (nonatomic, copy) NSString *address2;
//@property (nonatomic, copy) NSString *postCode;
//@property (nonatomic, copy) NSString *mobileNo;
//@property (nonatomic, copy) NSString *pinCode;
//@property (nonatomic, copy) NSString *state;

@property (nonatomic, copy) NSString *addresId;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *block;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *street;
@property (nonatomic, copy) NSString *building;
@property (nonatomic, copy) NSString *flat;
@property (nonatomic, copy) NSString *jaddah;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *email_id;





+ (ExistAddres *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;
- (NSDictionary *)dictionaryRepresentation;




@end
