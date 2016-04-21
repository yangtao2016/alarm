//
//  baseNSObject.m
//  TaoYang
//
//  Created by zhixian on 16/3/10.
//  Copyright © 2016年 zhixian. All rights reserved.
//

#import "baseNSObject.h"
@implementation baseNSObject


/**        模型必须继承与本类
归档
[NSKeyedArchiver archiveRootObject:arr toFile:@"/Users/Zhixian/Desktop/test.text"];
解档
NSArray *arr2= [NSKeyedUnarchiver unarchiveObjectWithFile:@"/Users/Zhixian/Desktop/test.text"];
 
 */





/**
 *  获取类所有的属性名
 *
 *  @param class 类
 *
 *  @return 属性名数组
 */
- (NSArray *)getAllPropertyWithClass:(Class)class
{
    NSMutableArray *propertyArr = [[NSMutableArray alloc] init];
    unsigned int count;
    while (class != [NSObject class]) {
        objc_property_t *properties = class_copyPropertyList(class, &count);
        for(int i = 0; i < count; i++)
        {
            objc_property_t property = properties[i];
            NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            if ([propertyName isEqualToString:@"distace"]) {
                continue;
            }
            [propertyArr addObject:propertyName];
        }
        if (properties) {
            free(properties);
        }
        //得到父类的消息
        class = class_getSuperclass(class);
    }
    return propertyArr;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        NSArray *properties = [self getAllPropertyWithClass:[self class]];
        for (NSString *property in properties) {
            [self setValue:[coder decodeObjectForKey:property] forKey:property];
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    NSArray *properties = [self getAllPropertyWithClass:[self class]];
    for (NSString *property in properties) {
        [coder encodeObject:[self valueForKey:property] forKey:property];
    }
}


@end
