//
//  ViewController.m
//  array
//
//  Created by Admin on 2016/11/12.
//  Copyright © 2016年 Admin. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()

@property (nonatomic , strong) NSMutableArray *array;

@end

static long x = 0;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = [NSMutableArray array];
    
    
    //循环1
    NSDate* tmpStartData = [NSDate date];
    [self fun1];
    double deltaTime = [[NSDate date] timeIntervalSinceDate:tmpStartData];
    NSLog(@"cost time 1 = %f", deltaTime);
    
    //循环2
    NSMutableArray *array2 = [NSMutableArray array];
    NSDate* tmpStartData2 = [NSDate date];
    for (NSString *str in self.array) {
        NSLog(@"thread = %@",[NSThread currentThread]);
        NSString *str1 = [NSString stringWithFormat:@"link - %ld",x];
        [array2 addObject:str1];
        x ++;
    }
    double deltaTime2 = [[NSDate date] timeIntervalSinceDate:tmpStartData2];
    NSLog(@"cost time 2 = %f", deltaTime2);
    
    
    //循环3
    NSMutableArray *array3 = [NSMutableArray array];
    NSDate* tmpStartData3 = [NSDate date];
    [array2 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSLog(@"thread = %@",[NSThread currentThread]);
        NSString *str2 = [NSString stringWithFormat:@"link - %ld",x];
        [array3 addObject:str2];
        x ++;

    }];
    double deltaTime3 = [[NSDate date] timeIntervalSinceDate:tmpStartData3];
    NSLog(@"cost time 3 = %f", deltaTime3);
    
    
    //循环4
    NSMutableArray *array4 = [NSMutableArray array];
    NSDate* tmpStartData4 = [NSDate date];
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_apply(array3.count, queue, ^(size_t index) {
        NSLog(@"thread = %@",[NSThread currentThread]);
        NSString *str2 = [NSString stringWithFormat:@"link - %ld",x];
        [array4 addObject:str2];
        x ++;
    });
    double deltaTime4 = [[NSDate date] timeIntervalSinceDate:tmpStartData4];
    NSLog(@"cost time 4 = %f", deltaTime4);
}


- (void)fun1 {
    
    
    for (int i = 0; i < 2000; i ++) {
        NSLog(@"thread = %@",[NSThread currentThread]);

        NSString *str = [NSString stringWithFormat:@"link - %ld",x];
        [self.array addObject:str];
        x ++;
    }
}






@end
