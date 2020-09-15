//
//  ViewController.m
//  ObjCGettingStarted
//
//  Created by Jacob Rozell on 9/3/20.
//  Copyright © 2020 Jacob Rozell. All rights reserved.
//

#import "ViewController.h"
#import "Course.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray<Course *> *courses;

@end

@implementation ViewController

NSString *cellId = @"cellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCourses];
    self.title = @"Courses";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:cellId];
    self.tableView.tableFooterView = [UIView.new init];
}

- (void) setupCourses {
    self.courses = NSMutableArray.new;

    Course *course = Course.new;
    course.name = @"Instagram Firebase";
    course.numberOfLessons = @(49);

    [self.courses addObject:course];
}

// MARK: -- Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.courses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];

    Course *course = self.courses[indexPath.row];
    cell.textLabel.text = course.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

@end
