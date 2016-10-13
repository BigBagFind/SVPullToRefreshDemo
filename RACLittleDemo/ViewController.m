//
//  ViewController.m
//  RACLittleDemo
//
//  Created by 铁拳科技 on 16/9/5.
//  Copyright © 2016年 铁哥哥. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *label;





@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // starWith : 初始化返回的text
    // 但是length > 2, 否则不返回,即无初始值
    // filter : text.length > 2，才返给label
    RAC(self.label,text,@"没有哦") =
    [[[[self.textField.rac_textSignal startWith:@"starWith"] ignore:@"tgg"]
    filter:^BOOL(NSString *text) {
        return text.length > 2;
    }]
    map:^id(NSString *text) {
         return [text isEqualToString:@"Tgg"] ? @"bingo" : text;
    }];
    
    
    
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"1"];
        [subscriber sendNext:@"2"];
        [subscriber sendNext:@"3"];
        [subscriber sendCompleted];
        return nil;
    }]take:1]subscribeNext:^(id x) {
        NSLog(@"takeTest：%@",x);
    }];
    
    
    [[self.textField.rac_textSignal takeUntilBlock:^BOOL(NSString *value) {
        return [value isEqualToString:@"stop"];
    }] subscribeNext:^(NSString *value) {
        NSLog(@"current value is not `stop`: %@", value);
    }];
    
    
}



@end
