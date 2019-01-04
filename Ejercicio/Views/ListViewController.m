//
//  ListViewController.m
//  Ejercicio
//
//  Created by Francisco Paramo Muñoz on 25/12/2018.
//  Copyright © 2018 Francisco Paramo Muñoz. All rights reserved.
//

#import "ListViewController.h"
#import "Ejercicio-Swift.h"
#import "centroCulturalCell.h"


@interface ListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.table registerNib:[UINib nibWithNibName:@"centroCulturalCell" bundle:nil] forCellReuseIdentifier:@"centroCulturalCell"];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.estimatedRowHeight = 50;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    centroCulturalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"centroCulturalCell"];
    CentroCultural *centro = [_arr objectAtIndex:indexPath.row];
    cell.title.text = [centro getTitle];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr.count;
}

@end
