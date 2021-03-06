//
//  StoreCodeViewController.m
//  BusinessApp
//
//  Created by prefect on 16/5/4.
//  Copyright © 2016年 Perfect. All rights reserved.
//

#import "StoreCodeViewController.h"

@interface StoreCodeViewController ()

@property(nonatomic,strong)UIView * allView;

@property(nonatomic,strong)UIImageView * markImage;

@property(nonatomic,strong)UILabel * phoneLabel;

@property(nonatomic,strong)UIImageView * codeImage;

@property(nonatomic,strong)UILabel * setLabel;

@property(nonatomic,strong)MBProgressHUD *hud;

@end

@implementation StoreCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店铺二维码";
    self.view.backgroundColor = [UIColor blackColor];
    
    [self createView];
    
    [self setLayout];
    
    [self loadData];
}

-(void)loadData{
    
    
    _hud = [AppUtil createHUD];
    
    _hud.labelText = @"正在加载";
    
    NSString *urlSring = [NSString stringWithFormat:@"%@/store/qrcode/%@",SITE_SERVER,Store_id];
    
    [_codeImage sd_setImageWithURL:[NSURL URLWithString:urlSring] placeholderImage:[UIImage imageNamed:@"logo_place"]  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        
        
        if (error != nil) {
            
            _codeImage.image = [UIImage imageNamed:@"code_err"];
            
        }
        
        [_hud hide:YES];
    }];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [_hud hide:YES];
}

-(void)createView{
    
    _allView = [UIView new];
    _allView.backgroundColor = [UIColor whiteColor];
    _allView.layer.cornerRadius = 5;
    [self.view addSubview:_allView];
    
    _markImage = [UIImageView new];
    _markImage.image = _logoImage;
    _markImage.layer.cornerRadius = 30.f;
    _markImage.layer.masksToBounds = YES;
    [_allView addSubview:_markImage];
    
    _phoneLabel = [UILabel new];
    _phoneLabel.text = _nameString;
    _phoneLabel.font = [UIFont systemFontOfSize:14];
    [_allView addSubview:_phoneLabel];
    
    _codeImage = [UIImageView new];
    _codeImage.backgroundColor = [UIColor whiteColor];
    [_allView addSubview:_codeImage];
    
    _setLabel = [UILabel new];
    _setLabel.text = @"扫一扫上面的二维码,关注店铺";
    _setLabel.font = [UIFont systemFontOfSize:14];
    _setLabel.textColor = [UIColor grayColor];
    [_allView addSubview:_setLabel];
}
-(void)setLayout{
    
    __weak typeof(self) weakSelf = self;
    [_allView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(self.view.bounds.size.width-40, self.view.bounds.size.height-150));
        
    }];
    [_markImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_markImage.mas_bottom).offset(15.f);
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.height.mas_equalTo(14);
    }];
    
    
    [_codeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phoneLabel.mas_bottom).offset(40.f);
        make.centerX.mas_equalTo(weakSelf.allView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(self.view.bounds.size.width-140,self.view.bounds.size.height/3));
    }];
    [_setLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-20);
        make.centerX.mas_equalTo(weakSelf.allView.mas_centerX);
        make.height.mas_equalTo(14);
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
