//
//  SUMVideoTableViewController.m
//  
//
//  Created by Matthew Turk on 7/21/15.
//
//

#import "SUMVideoTableViewController.h"
#import "SUMTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "SUMVideo.h"

@interface SUMVideoTableViewController ()

@end

@implementation SUMVideoTableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    #define black [UIColor colorWithRed:32.0/255 green:34.0/255 blue:41.0/255 alpha:1.0]
    #define yellow [UIColor colorWithRed:241.0/255 green:196.0/255 blue:15.0/255 alpha:1.0]
    #define grey [UIColor colorWithRed:146.0/255 green:146.0/255 blue:146.0/255 alpha:1.0]
    #define white [UIColor colorWithRed:236.0/255 green:240.0/255 blue:241.0/255 alpha:1.0]
    self.navigationController.navigationBar.barTintColor = black;
    self.video = [[SUMVideo alloc] init];
    self.SVTSearchIcon = _SVTSearchIcon;
    //UIBarButtonItem *SVTSearchIcon = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(search)];
    UIBarButtonItem *SVTSettingsIcon = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"SUMSettingsIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(settings)];
    SVTSettingsIcon.tintColor = white;
    //SVTSearchIcon.tintColor = white;
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:SVTSettingsIcon, _SVTSearchIcon, nil]];
    self.video.SVLoadPopularVideos;
}

//----
//NSURL *url = [NSURL URLWithString:@"http://rest-service.guides.spring.io/greeting"];
//    NSURL *url = [NSURL URLWithString:@"https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=PLrEnWoR732-BHrPp_Pm8_VleD68f9s14-&key=AIzaSyArbT63UVCvk0RkArDgOwcW-gfUJJ8-ea4"];
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.video.SVTitle.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SUMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SUMTableViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    int row = [indexPath row];
//    cell.SVTTitleLabel.text = vid.SVTitle[row];
//    cell.SVTDescriptionLabel.text = vid.SVCreator[row];
//    cell.SVTThumbImage.image = [UIImage imageNamed:vid.SVCreatorImage[row]];
//    cell.SVTCreatorImageView.image = [UIImage imageNamed:vid.SVCreator[row]];
    cell.SVTTitleLabel.text = self.video.SVTitle[row];
    cell.SVTViewCountLabel.text = [self.video.SVViewCount[row] stringByAppendingString:@" Views"];
    cell.SVTDescriptionLabel.text = self.video.SVCreator[row];
    cell.SVTThumbImage.image = [UIImage imageNamed:self.video.SVImage[row]];
    cell.SVTCreatorImageView.image = [UIImage imageNamed:self.video.SVCreatorImage[row]];
    cell.SVTAgeLabel.text = [self.video.SVAge[row] stringByAppendingString:@" Ago"];
    cell.SVTCreatorImageView.layer.cornerRadius = 8.0;
    cell.SVTCreatorImageView.layer.masksToBounds = YES;
    cell.view.layer.cornerRadius = 8.0;
    if (_SVTIsTop == YES) {
        cell.SVSourceWaterMark.hidden = true;
        cell.SVTCellSeparator.backgroundColor = yellow;
        cell.SVTAdIndicatorPillView.hidden = NO;
        cell.SVTAdIndicatorPillLabel.hidden = NO;
        cell.SVTAgeLabel.hidden = YES;
        cell.SVTViewCountLabel.hidden = YES;
        } else {
        cell.SVTViewCountLabel.hidden = NO;
        cell.SVTAgeLabel.hidden = NO;
        cell.SVSourceWaterMark.hidden = false;
        cell.SVTCellSeparator.backgroundColor = grey;
        cell.SVTAdIndicatorPillView.hidden = YES;
        cell.SVTAdIndicatorPillLabel.hidden = YES;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0)
    {
        _SVTIsTop = YES;
        return 193.0f;
    } else {
        _SVTIsTop = NO;
        return 125.0f;
    }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end