//
//  ViewController.m
//  WaterfallFlow
//
//  Created by chen on 2017/8/4.
//  Copyright © 2017年 Gorpeln. All rights reserved.
//

#import "ViewController.h"
#import "GPCollectionViewWaterfallLayout.h"
#import "WaterfallCell.h"
#import "WaterfallHeaderView.h"
#import "WaterfallFooterView.h"

#define RANDOMCOLOR  [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1]
#define BOUNDS_WIDTH    [UIScreen mainScreen].bounds.size.width

#define SPACING 5       //间隔
#define COLUMNCOUNT 2   //列数
#define HEADERHEIGHT 64 //头部高度
#define FOOTERHEIGHT 64 //尾部高度
#define ITEMWIDTH    (BOUNDS_WIDTH - SPACING) / 2.0  //宽度
#define ITEMHEIGHT   ITEMWIDTH + (arc4random()% (int)ITEMWIDTH)                //高度


static NSString *cellIdentifier   = @"WaterfallCell";
static NSString *headerIdentifier = @"WaterfallHeader";
static NSString *footerIdentifier = @"WaterfallFooter";


@interface ViewController ()<UICollectionViewDataSource, GPCollectionViewDelegateWaterfallLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"瀑布流";
    
    
    // 初始化布局
    GPCollectionViewWaterfallLayout *layout = [[GPCollectionViewWaterfallLayout alloc] init];
    
    // 设置布局
    layout.sectionInset = UIEdgeInsetsMake(SPACING,SPACING, SPACING, SPACING);
    layout.headerHeight = HEADERHEIGHT;            // headerView高度
    layout.footerHeight = FOOTERHEIGHT;             // footerView高度
    layout.columnCount  = COLUMNCOUNT;             // 几列显示
    layout.minimumColumnSpacing    = SPACING;  // cell之间的水平间距
    layout.minimumInteritemSpacing = SPACING;  // cell之间的垂直间距
    
    // 初始化collectionView
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                         collectionViewLayout:layout];
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _collectionView.dataSource       = self;
    _collectionView.delegate         = self;
    _collectionView.backgroundColor  = [UIColor clearColor];
    
    // 注册cell以及HeaderView，FooterView
    [_collectionView registerClass:[WaterfallCell class] forCellWithReuseIdentifier:cellIdentifier ];
    [_collectionView registerClass:[WaterfallHeaderView class]
        forSupplementaryViewOfKind:GPCollectionElementKindSectionHeader
               withReuseIdentifier:headerIdentifier];
    [_collectionView registerClass:[WaterfallFooterView class]
        forSupplementaryViewOfKind:GPCollectionElementKindSectionFooter
               withReuseIdentifier:footerIdentifier];
    
    // 添加到视图当中
    [self.view addSubview:_collectionView];
    
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"点击了 %ld", indexPath.row);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 60;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WaterfallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = RANDOMCOLOR;
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableView = nil;
    
    if ([kind isEqualToString:GPCollectionElementKindSectionHeader]) {
        
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                          withReuseIdentifier:headerIdentifier
                                                                 forIndexPath:indexPath];
        
    } else if ([kind isEqualToString:GPCollectionElementKindSectionFooter]) {
        
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                          withReuseIdentifier:footerIdentifier
                                                                 forIndexPath:indexPath];
    }
    
    return reusableView;
}

#pragma mark - GPCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(ITEMWIDTH, ITEMHEIGHT);
}

@end
