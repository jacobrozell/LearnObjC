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
    [self fetchCoursesUsingJSON];
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

- (void) fetchCoursesUsingJSON {
    NSLog(@"Fetching Courses...");
    NSString *urlString = @"https://api.letsbuildthatapp.com/jsondecodable/courses";
    NSURL *url = [NSURL URLWithString:urlString];
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        // Allocate an error
        NSError *err;

        // Turn JSON into an array
        NSArray *coursesJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];

        // Check to see if an error occurred
        if (err) {
            NSLog(@"Failed to serialize into JSON: %@", err);
            return;
        }

        NSMutableArray<Course *> *courses = NSMutableArray.new;
        // Loop through JSON
        for (NSDictionary *coursesDict in coursesJSON) {
            // Grab info
            NSString *name = coursesDict[@"name"];
            NSNumber *lessons = coursesDict[@"number_of_lessons"];

            // Make object from info
            Course *course = Course.new;
            course.name = name;
            course.numberOfLessons = lessons;

            [courses addObject:course];
        }

        self.courses = courses;

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });

    }] resume];
}

// MARK: -- Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.courses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];

    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];

    Course *course = self.courses[indexPath.row];
    cell.textLabel.text = course.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Number of lessons: %@", course.numberOfLessons.stringValue];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

@end
