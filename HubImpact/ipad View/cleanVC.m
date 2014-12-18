//
//  cleanVC.m
//  HubImpact
//
//  Created by One Platinum on 12/4/14.
//  Copyright (c) 2014 Design Offshore Nepal. All rights reserved.
//

#import "cleanVC.h"
#import "CleanlinessCellSection.h"

@interface cleanVC ()
@end

@implementation cleanVC
@synthesize recipes;
- (void)viewDidLoad {
    [super viewDidLoad];
    num=2;
    recipes = [NSMutableArray arrayWithObjects:@"1", @"2", nil];
    
    
        UIBarButtonItem *addButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItemToArray)];
    self.navigationItem.rightBarButtonItem = addButton;

    // Do any additional setup after loading the view from its nib.
}
- (void)addItemToArray {
    num++;
    [recipes addObject:[NSString stringWithFormat:@"Item No. %d",num]];
     [self.MytableView reloadData];
     }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 286;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [recipes count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CleanlinessCellSection *cell = (CleanlinessCellSection *)[tableView dequeueReusableCellWithIdentifier:nil];
    
    
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CleanlinessCellSection" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    
    cell.textLabel.text = [recipes objectAtIndex:indexPath.row];
   // cell.imageView.image = [UIImage imageNamed:@"creme_brelee.jpg"];
    
    return cell;
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
