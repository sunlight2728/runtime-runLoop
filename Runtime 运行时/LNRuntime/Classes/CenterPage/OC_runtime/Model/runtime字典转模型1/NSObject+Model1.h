/*
 * NSObject+Model1.h
 * 不知名开发者 https://dwz.cn/rC1LGk2f | https://github.com/CoderLN/Runtime-RunLoop
 * 
 * runtime 字典转模型；modelWithDict:
 */

#import <Foundation/Foundation.h>

@interface NSObject (Model1)
// 字典转模型
+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end


/**
 获取类里面所有方法
 class_copyMethodList(__unsafe_unretained Class cls, unsigned int *outCount)// 本质:创建谁的对象
 
 获取类里面所有属性
 class_copyPropertyList(__unsafe_unretained Class cls, unsigned int *outCount)
 
 获取类中的所有成员变量(以下划线开头)
 Ivar * ivarList = class_copyIvarList(Class _Nullable cls：表示获取哪个类中的成员变量, unsigned int * _Nullable outCount：表示这个类有多少成员变量，传入一个Int变量地址，会自动给这个变量赋值)
 返回值ivarList指的是一个ivar数组，会把所有成员变量放在一个数组中，通过返回的数组就能全部获取到
 */

