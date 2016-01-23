//
//  ViewController.m
//  UICollectionView
//
//  Created by 康梁 on 16/1/21.
//  Copyright © 2016年 LeonKang. All rights reserved.
//

#import "ViewController.h"
#import <Foundation/Foundation.h>

@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) UILabel *cellLable;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds ];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGRect screen = [UIScreen mainScreen].bounds;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 25, screen.size.width, screen.size.height) collectionViewLayout:flowLayout];
    // collectionView.collectionViewLayout = flowLayout;
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.headerReferenceSize = CGSizeMake(screen.size.width, 25);
    flowLayout.footerReferenceSize = CGSizeMake(screen.size.width, 20);
//    [flowLayout setMinimumInteritemSpacing:0];
//    [flowLayout setMinimumLineSpacing:0];
//    [flowLayout setItemSize:CGSizeMake(28, 28)];
    
    [self.view addSubview:collectionView];
    
    collectionView.backgroundColor = [UIColor whiteColor];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
    
}

#pragma mark - CollectionViewDelegate
// Section个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

// Item数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 7;
}

// 定制cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    for (id subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    cell.backgroundColor = [UIColor greenColor];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, 20)];
    lable.textAlignment = NSTextAlignmentCenter;
    
    [cell.contentView addSubview:lable];
    
    lable.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    
    
    
    return cell;
}


// 定制每个Item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize size = CGSizeMake(100, 150);
    
    return size;
}

// 每组的cell的边界
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 20, 0, 20);
    
    if (section == 1) {
        edgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    }
    
    return edgeInsets;
}

// 最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    CGFloat minL = 0;
    
    if (section == 1) {
        minL = 5;
    }
    
    return minL;
}

// 最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    CGFloat minI = 0.5;
    
    return minI;
}

// 被选中时调用的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *msg = [NSString stringWithFormat:@"It's %ld", (long)indexPath.row];
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"Hello" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
    [alertC addAction:cancel];
    [self presentViewController:alertC animated:YES completion:nil];
    
    
}

// 是否可以被选择
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ((indexPath.row % 2) == 1) {
        return YES;
    }
    return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// Header 和 Footer
- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
    lable.textAlignment = NSTextAlignmentCenter;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        lable.textColor = [UIColor blueColor];
        lable.text = @"HeaderView";
        headerView.backgroundColor = [UIColor orangeColor];
        [headerView addSubview:lable];
        reusableview = headerView;
    }
    
    if (kind == UICollectionElementKindSectionFooter)
    {
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        
        lable.textColor = [UIColor whiteColor];
        lable.text = @"FooterView";
        footerview.backgroundColor = [UIColor blackColor];
        [footerview addSubview:lable];
        reusableview = footerview;
    }
    
    return reusableview;
}

@end
