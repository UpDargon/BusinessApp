//
//  AddBankViewController.m
//  BusinessApp
//
//  Created by prefect on 16/3/15.
//  Copyright © 2016年 Perfect. All rights reserved.
//

#import "AddBankViewController.h"
#import "BindBanksViewController.h"

@interface AddBankViewController ()<UITextFieldDelegate>

@property(nonatomic,strong)MBProgressHUD *hud;

@property (weak, nonatomic) IBOutlet UITextField *nameField;

@property (weak, nonatomic) IBOutlet UITextField *cardFiled;

@property (weak, nonatomic) IBOutlet UITextField *phoneFiled;

@property (weak, nonatomic) IBOutlet UILabel *bankLabel;

@property(nonatomic,copy)NSString *codeString;



@end

@implementation AddBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加银行卡";

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 5;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    __weak typeof(self) weakSelf = self;
    
    if (indexPath.section==0) {
        
        if (indexPath.row ==2) {
            
            BindBanksViewController *vc = [[BindBanksViewController alloc]init];
            
            vc.didSelectRows = ^(NSString *bankString,NSString *codeString){
            
                weakSelf.bankLabel.text = bankString;

                weakSelf.codeString = codeString;
            };

            [self.navigationController pushViewController:vc animated:YES];

        }

    }else{

        
        _hud = [AppUtil createHUD];
        _hud.labelText = @"正在添加...";
        _hud.userInteractionEnabled = NO;
        
        if (![self check]) {
            return;
        }


        [AFHttpTool incomeAddBank:Store_id
                        bank_code:_codeString
                             name:_nameField.text
                      open_branch:_bankLabel.text
                       bank_phone:_phoneFiled.text
                        bank_card:_cardFiled.text progress:^(NSProgress *progress) {
                           
        } success:^(id response) {
            
            if (!([response[@"code"]integerValue]==0000)) {
                
                NSString *errorMessage = response [@"msg"];
                _hud.mode = MBProgressHUDModeCustomView;
                _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
                _hud.labelText = [NSString stringWithFormat:@"错误:%@", errorMessage];
                [_hud hide:YES afterDelay:3];
                
                return;
            }


            if (_addSuccess) {
                _addSuccess();
            }
            
            [weakSelf.navigationController popViewControllerAnimated:YES];
        
            
        } failure:^(NSError *err) {
            
            _hud.mode = MBProgressHUDModeCustomView;
            _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
            _hud.labelText = @"Error";
            _hud.detailsLabelText = err.userInfo[NSLocalizedDescriptionKey];
            [_hud hide:YES afterDelay:3];
            
        }];
        

    
    }



}


-(BOOL)check{

    if (_nameField.text.length==0) {
        
        _hud.mode = MBProgressHUDModeCustomView;

        _hud.labelText = @"请输入姓名";
        
        [_hud hide:YES afterDelay:3];
        
        return NO;
    }
    if (_cardFiled.text.length<9) {
        
        _hud.mode = MBProgressHUDModeCustomView;
        
        _hud.labelText = @"请输入正确卡号";
        
        [_hud hide:YES afterDelay:3];
        
        return NO;
        
    }if(_codeString.length==0){
        
        _hud.mode = MBProgressHUDModeCustomView;
        
        _hud.labelText = @"请选择开户行";
        
        [_hud hide:YES afterDelay:3];
        
        return NO;
        
    }if (_phoneFiled.text.length!=11) {

        _hud.mode = MBProgressHUDModeCustomView;
        
        _hud.labelText = @"请输入正确的手机号";
        
        [_hud hide:YES afterDelay:3];
        
        return NO;
    }
    
    return YES;

}



@end