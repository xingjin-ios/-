//
//  ViewController.m
//  KeyWordRearrangeDemo
//
//  Created by 邢进 on 2017/4/1.
//  Copyright © 2017年 邢进. All rights reserved.
//

#import "ViewController.h"

#define Font14 [UIFont systemFontOfSize:14]

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *tagsView;
@property (nonatomic, strong)NSArray *tagsArray;
@property (nonatomic, strong) UIView *headerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"关键字排列Demo";

}
- (NSArray *)tagsArray {
    if (!_tagsArray) {
        _tagsArray = @[@"关键字",@"搜索",@"西红柿",@"番茄炒鸡蛋",@"小油条",@"木炒肉",@"大地瓜",@"胡萝卜",@"冬吃罗卜,夏吃姜",@"小鸡炖蘑菇",@"生煎包子",@"葱",@"蒜苗",@"我是个厨子",@"😋"];
    }
    return _tagsArray;
}
- (void)viewDidAppear:(BOOL)animated {
    [self tagsViewWithTag];
}

//排列搜索关键词
- (void)tagsViewWithTag
{
    //设置基数
    CGFloat allLabelWidth = 0;
    CGFloat allLabelHeight = 0;
    int rowHeight = 0;
    //遍历初始化 tag
    for (int i = 0; i < self.tagsArray.count; i++) {
        //不是最后一个的判断
        if (i != self.tagsArray.count-1) {
            
            CGFloat width = [self getWidthWithTitle:self.tagsArray[i+1] font:Font14];
            if (allLabelWidth + width+10 > self.tagsView.frame.size.width) {
                rowHeight++;
                allLabelWidth = 0;
                allLabelHeight = rowHeight*40;
            }
        }
        else
        {
            //是最后一个的判断
            CGFloat width = [self getWidthWithTitle:self.tagsArray[self.tagsArray.count-1] font:Font14];
            if (allLabelWidth + width+10 > self.tagsView.frame.size.width) {
                rowHeight++;
                allLabelWidth = 0;
                allLabelHeight = rowHeight*40;
            }
        }
        //已经计算出单个label的frame
        UILabel *rectangleTagLabel = [[UILabel alloc] init];
        // 设置属性
        rectangleTagLabel.userInteractionEnabled = YES;
        rectangleTagLabel.font = Font14;
        rectangleTagLabel.textColor = [UIColor whiteColor];
        rectangleTagLabel.backgroundColor = [UIColor lightGrayColor];
        rectangleTagLabel.text = self.tagsArray[i];
        rectangleTagLabel.textAlignment = NSTextAlignmentCenter;
        //添加tag手势事件
        [rectangleTagLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagDidCLick:)]];
        
        CGFloat labelWidth = [self getWidthWithTitle:self.tagsArray[i] font:Font14];
        
        rectangleTagLabel.layer.cornerRadius = 5;
        [rectangleTagLabel.layer setMasksToBounds:YES];
        
        rectangleTagLabel.frame = CGRectMake(allLabelWidth, allLabelHeight, labelWidth, 25);
        [self.tagsView addSubview:rectangleTagLabel];
        
        allLabelWidth = allLabelWidth + 10 + labelWidth;
    }
    //设置父视图高度
    CGRect rect = _tagsView.frame;
    rect.size.height = rowHeight*40+40;
    _tagsView.frame = rect;
}
- (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width+10;
}
/** 选中标签 */
- (void)tagDidCLick:(UITapGestureRecognizer *)gr
{
    UILabel *label = (UILabel *)gr.view;
    NSLog(@"选中 : %@", label.text);
    // 缓存数据并且刷新界面
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
