//
//  HNFirstViewController.m
//  Habari News
//
//  Created by Denis on 13/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HNLatestNews.h"
#import "HNDataDownloader.h"
#import "NewsItem.h"
#import "webViewController.h"


#define NATION_NEWS_SOURCE @"http://www.nation.co.ke/-/1148/1148/-/view/asFeed/-/vtvnjq/-/index.xml"
#define NATION_BUSINESS @"http://www.nation.co.ke/business/-/996/996/-/view/asFeed/-/14lpkvc/-/index.xml"
@implementation HNLatestNews

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Latest", @"Latest");
        self.tabBarItem.image = [UIImage imageNamed:@"latest"];
    }
    return self;
}
							
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    newsItem = nil;
    webView = nil;
    items = nil;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshData:)];
    self.navigationItem.rightBarButtonItem = refreshButton;
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 410)];
    tableView.delegate =self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    [tableView release]; 
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(retrieveData) name:@"XMLParsingFinished" object:nil];
    [self refreshData:nil];
    
}


- (void)refreshData:(id)sender {
    NSURL *url = [NSURL URLWithString:NATION_NEWS_SOURCE];
    [[HNDataDownloader sharedHNDataDownloader] downloadNewsWithUrl:url];

}

- (void)retrieveData{
    items = [[HNDataDownloader sharedHNDataDownloader] retrieveNewsItems];
    [tableView reloadData];
   // NSLog(@"items %@", items);

}

- (void)viewDidUnload
{

    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [items count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    newsItem = [[NewsItem alloc] init];
    newsItem = [items objectAtIndex:indexPath.row];
    cell.textLabel.text = newsItem.title;
    cell.detailTextLabel.text = newsItem.description;
    //[newsItem release];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   // NewsItem* newsArticle = [[NewsItem alloc] init];
    newsItem = [items objectAtIndex:indexPath.row];
    webView = [[webViewController alloc] initWithNibName:@"webViewController" bundle:nil];
    
    [self.navigationController pushViewController:webView animated:YES];
    webView.url = [NSURL URLWithString:newsItem.link];
    
    [webView release];
}
- (void)dealloc {
    [super dealloc];
}
@end
