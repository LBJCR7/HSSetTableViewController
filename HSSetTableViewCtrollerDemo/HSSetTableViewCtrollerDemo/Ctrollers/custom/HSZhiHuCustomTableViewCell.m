//
//  HSZhiHuTableViewCell.m
//  HSSetTableViewCtrollerDemo
//
//  Created by hushaohui on 2017/6/9.
//  Copyright © 2017年 ZLHD. All rights reserved.
//

#import "HSZhiHuCustomTableViewCell.h"
#import "HSZhiHuCustomCellModel.h"
#import "HSSetTableViewController.h"
#import "NSBundle+HSImage.h"

@interface HSZhiHuCustomTableViewCell()

@property (nonatomic, weak)UISwitch *mySwitch;  ///<
@property (nonatomic, weak)UIImageView *arrow;  ///<

@end
@implementation HSZhiHuCustomTableViewCell

+ (HSBaseTableViewCell *)cellWithIdentifier:(NSString *)cellIdentifier tableView:(UITableView *)tableView
{
    HSZhiHuCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        
        //这里重写父类方法 仅仅是因为需要改写下cell样式，实际情况可以自己管理布局
        cell = [[HSZhiHuCustomTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)setupUI
{
    [super setupUI];
    
    
    //添加switch
    UISwitch *switchItem = [[UISwitch alloc] initWithFrame:CGRectMake(self.frame.size.width - HS_KSwitchWidth - HS_KCellMargin, (60 - HS_KSwitchHeight)/2, HS_KSwitchWidth, HS_KSwitchHeight)];
    [switchItem addTarget:self action:@selector(switchChang:) forControlEvents:UIControlEventValueChanged];
    switchItem.onTintColor = [UIColor blueColor];
    [self.contentView addSubview:switchItem];
    self.mySwitch = switchItem;
    
    //箭头
    UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-HS_KCellMargin - HS_KArrowWidth, (60 - HS_kArrowHeight)/2, HS_KArrowWidth, HS_kArrowHeight)];
    arrow.image = [NSBundle hs_imageNamed:@"ic_hs_tableView_arrow"];
    [self.contentView addSubview:arrow];
    self.arrow = arrow;
    
}

- (void)setupDataModel:(HSBaseCellModel *)model
{
    [super setupDataModel:model];
    
    HSZhiHuCustomCellModel *cellModel = (HSZhiHuCustomCellModel *)model;
    self.arrow.hidden = !cellModel.hideSwitch;
    self.mySwitch.hidden = cellModel.hideSwitch;
    self.textLabel.text = cellModel.customTitle;
    self.detailTextLabel.text = cellModel.cusomDetailTitle;
}

- (void)switchChang:(UISwitch *)switchItem
{
    HSSwitchCellModel *model =
    (HSSwitchCellModel *)self.cellModel;
    model.on = switchItem.on;
    if(model.switchBlock){
        model.switchBlock(self.cellModel,switchItem.on);
    }
    
    
}

@end