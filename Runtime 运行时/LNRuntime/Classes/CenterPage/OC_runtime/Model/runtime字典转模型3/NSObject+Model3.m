/*
 * NSObject+Model3.m
 * 不知名开发者 https://dwz.cn/rC1LGk2f | https://github.com/CoderLN/Runtime-RunLoop
 * 
 */

#import "NSObject+Model3.h"
#import <objc/message.h>

@implementation NSObject (Model3)

// 思路：利用runtime 遍历模型中所有属性，根据模型中属性去字典中取出对应的value给模型属性赋值
+ (instancetype)modelWithDict3:(NSDictionary *)dict
{
    // 1.创建对应的对象
    id objc = [[self alloc] init];
    
    // 2.利用runtime给对象中的属性赋值 
    // 成员变量个数
    unsigned int count = 0;
    // 获取类中的所有成员变量
    Ivar *ivars = class_copyIvarList(self, &count);
    
    // 遍历所有成员变量
    for (int i = 0; i < count; i++) {
        // 根据角标，从数组取出对应的成员变量（Ivar：成员变量,以下划线开头）
        Ivar ivar = ivars[i];
        
        // 获取成员变量名字
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        
        // 处理成员属性名->字典中的key(去掉 _ ,从第一个角标开始截取)
        NSString *key = [ivarName substringFromIndex:1];
        
        // 根据成员属性名去字典中查找对应的value
        id value = dict[key];
        
        
        //----------------------- <#<--- 不知名开发者 --->#> ------------------------//
        //
        
        // runtime字典转模型三级转换：字典->数组->字典；NSArray中也是字典，把数组中的字典转换成模型.
        // 判断值是否是数组
        if ([value isKindOfClass:[NSArray class]]) {
            // 判断对应类有没有实现字典数组转模型数组的协议
            // arrayContainModelClass 提供一个协议，只要遵守这个协议的类，都能把数组中的字典转模型
            if ([self respondsToSelector:@selector(arrayContainModelClass)]) {
                
                // 转换成id类型，就能调用任何对象的方法
                id idSelf = self;
                
                // 获取数组中字典对应的模型
                NSString *type =  [idSelf arrayContainModelClass][key];
                
                // 生成模型
                Class classModel = NSClassFromString(type);
                NSMutableArray *arrM = [NSMutableArray array];
                // 遍历字典数组，生成模型数组
                for (NSDictionary *dict in value) {
                    // 字典转模型
                    id model =  [classModel modelWithDict3:dict];
                    [arrM addObject:model];
                }
                
                // 把模型数组赋值给value
                value = arrM;     
            }
        }
        
        if (value) {
            // 给模型中属性赋值
            [objc setValue:value forKey:key];
        }
    }
    // 释放ivars
    free(ivars);
    
    return objc;
}




@end
