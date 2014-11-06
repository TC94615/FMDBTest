//
//  ViewController.m
//  FMDBTest
//
//  Created by 李道政 on 2014/11/5.
//  Copyright (c) 2014年 李道政. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import <sqlite3.h>
#import <FMDatabase.h>
#import <FMResultSet.h>
#import <FMDatabaseQueue.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //NSLog(@"%@",paths);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //NSLog(@"%@",documentsDirectory);
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"mybase.sqlite"];
    FMDatabase* db = [FMDatabase databaseWithPath:writableDBPath];
    [db open];
    
    [db executeUpdate:@"DROP TABLE myTable"];
     
    [db executeUpdate:@"CREATE TABLE myTable (\
     id INTEGER  PRIMARY KEY DEFAULT NULL,\
     para2 INTEGER DEFAULT NULL)"];
    FMResultSet *s = [db executeQuery:@"SELECT * FROM myTable"];
    while([s next]){
        int id = [s intForColumnIndex:0];
        int phoneNumber = [s intForColumnIndex:1];
        NSLog(@"id %i | para2 %i",id,phoneNumber);
    }
    [db executeUpdate:@"INSERT INTO myTable (id, para2) VALUES (?, ?)", [NSNumber numberWithInt:125961434],[NSNumber numberWithInt:958253189]];
    s = [db executeQuery:@"SELECT * FROM myTable"];
    while([s next]){
        int id = [s intForColumnIndex:0];
        int phoneNumber = [s intForColumnIndex:1];
        NSLog(@"id %i | para2 %i",id,phoneNumber);
    }
    [db executeUpdate:@"UPDATE myTable set para2 = ? where id = ?",[NSNumber numberWithInt:23635817],[NSNumber numberWithInt:125961434]];
    s = [db executeQuery:@"SELECT * FROM myTable"];
    while([s next]){
        int id = [s intForColumnIndex:0];
        int phoneNumber = [s intForColumnIndex:1];
        NSLog(@"id %i | para2 %i",id,phoneNumber);
    }
    [db executeUpdate:@"DELETE FROM myTable where id = ?",[NSNumber numberWithInt:125961434],nil];
    s = [db executeQuery:@"SELECT * FROM myTable"];
    while([s next]){
        int id = [s intForColumnIndex:0];
        int phoneNumber = [s intForColumnIndex:1];
        NSLog(@"id %i | para2 %i",id,phoneNumber);
    }
    [db close];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
