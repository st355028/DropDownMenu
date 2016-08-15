//
//  ViewController.m
//  DropDownMenu
//
//  Created by MinYeh on 2016/8/15.
//  Copyright © 2016年 MINYEH. All rights reserved.
//

#import "ViewController.h"

#define information  @[@"食",@"衣",@"住",@"行",@"娛樂"]

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView * forTableView;
    UITableView * dropDownMenu;
    UILabel * showContent;
    BOOL  buttonClick;
    double width;
    NSArray * youWantToShow;
}
@property (weak, nonatomic) IBOutlet UIButton *dropDownBtnName;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    forTableView = [[UIView alloc]initWithFrame:CGRectMake(0, -250,width, 250)];
    
    youWantToShow = information;
    
    width = [UIScreen mainScreen].bounds.size.width;
    dropDownMenu = [[UITableView alloc]initWithFrame:CGRectMake(0,-250,width, 250) style:UITableViewStylePlain];
    dropDownMenu.delegate = self;
    dropDownMenu.dataSource = self;
    [self.view addSubview:dropDownMenu];
    //[forTableView addSubview:dropDownMenu];
    

    [self.view bringSubviewToFront:forTableView];
}

- (IBAction)dropDownMenuBtnPressed:(UIButton *)sender {
    if(buttonClick == false){
        buttonClick = true;
        [self moveIn];
    }else{
        buttonClick = false;
        [self moveOut];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return youWantToShow.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    cell.backgroundColor = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    cell.textLabel.text = youWantToShow[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}

#pragma mark 改變button名稱
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //self.dropDownBtnName.titleLabel.text = youWantToShow[indexPath.row];
    [self.dropDownBtnName setTitle:youWantToShow[indexPath.row] forState:
     UIControlStateNormal];
    [self moveOut];
    buttonClick = false;
}

#pragma mark 移入、移出動畫
-(void)moveIn{
    
    [UIView animateWithDuration:0.75 animations:^
     {
         
         CGRect newFrame = [dropDownMenu frame];
         newFrame.origin.y += 300; // tweak here to adjust the moving position
         [dropDownMenu setFrame:newFrame];
     }];

}


-(void)moveOut{
    [UIView animateWithDuration:0.25 animations:^
     {
         CGRect newFrame = [dropDownMenu frame];
         newFrame.origin.y -= 300; // tweak here to adjust the moving position
         [dropDownMenu setFrame:newFrame];
         
     }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
