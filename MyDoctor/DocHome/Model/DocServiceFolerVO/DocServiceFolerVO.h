//
//  DocServiceFolerVO.h
//  
//
//  Created by 张昊辰 on 15/12/7.
//
//

#import <Foundation/Foundation.h>

@interface DocServiceFolerVO : NSObject

//CareInfoId = 2;
//CareInfoName = "\U7167\U62a42";
//CreateTime = "2016-01-17 09:44:21";
//DoctorId = 1;
//OrderType = 1;
//UserId = 2;
//id = 2;

@property (nonatomic, strong) NSString * id;
@property (nonatomic, strong) NSString * CareInfoName;
@property (nonatomic, strong) NSString * OrderType;
@property (nonatomic, strong) NSString * CreateTime;
@property (nonatomic,strong) NSString * headImg;
@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) NSString * details;
@property (nonatomic,strong) NSString * Phone;
@property (nonatomic,strong) NSString * UserId;

-(void)setValue:(id)value forUndefinedKey:(NSString *)key;


@end
