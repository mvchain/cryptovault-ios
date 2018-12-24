//
//  TPTransDetailCell.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/27.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPTransDetailCell.h"
#import "UILabel+WLAttributedString.h"
@interface TPTransDetailCell ()
//@property (nonatomic, strong) UILabel *titleLab;
//@property (nonatomic, strong) UILabel *conLab;
@end

@implementation TPTransDetailCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier isCopy:(BOOL)isCopy
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _titleLab = [YFactoryUI YLableWithText:@"金额:" color:TP59Color font:FONT(14)];
        [self addSubview:_titleLab];
        
        _conLab = [YFactoryUI YLableWithText:@"0x2051dd2bab0ae6c75dee40546e5ffa196ccc2448" color:TP59Color font:FONT(14)];
        
        [_conLab wl_changeLineSpaceWithTextLineSpace:5];
        _conLab.textAlignment = NSTextAlignmentRight;
        _conLab.numberOfLines = 0;
        [self addSubview:_conLab];
        
//        if (isCopy)
//        {
//            UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressCellHandle:)];
//
//            longPressGesture.minimumPressDuration =2;
//            [self.conLab addGestureRecognizer:longPressGesture];
//        }
    }
    return self;
}


-(void)longPressCellHandle:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state==UIGestureRecognizerStateEnded)
    {
            UIMenuController *menuController = [UIMenuController sharedMenuController];
            UIMenuItem *copyItem = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(menuCopyBtnPressed:)];
             menuController.menuItems = @[copyItem];
            [menuController setTargetRect:gesture.view.frame inView:gesture.view.superview];
            [menuController setMenuVisible:YES animated:YES];
            [UIMenuController sharedMenuController].menuItems = nil;
    }
}

-(void)menuCopyBtnPressed:(UIMenuItem *)menuItem
{
      [UIPasteboard generalPasteboard].string = self.conLab.text;
}



-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(@40);
        make.centerY.equalTo(self);
        make.height.equalTo(@19);
    }];
    
    [_conLab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.right.equalTo(@(-40));
        make.width.equalTo(@183);
//        make.top.equalTo(@12);
        make.centerY.equalTo(self);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
