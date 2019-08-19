#import "ViewController.h"
#import "DDYEmptyViewHeader.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray <NSMutableArray <NSString *>*>*dataArray;

@end

@implementation ViewController

- (NSMutableArray <NSMutableArray <NSString *>*>*)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [UIView new];
        _tableView.estimatedRowHeight = 120;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"EmptyID"];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    __weak __typeof__ (self)weakSelf = self;
    DDYEmptyBlock actionBlock = ^() {
        [weakSelf loadTestData];
    };
    self.tableView.ddy_EmptyView = [DDYEmptyView emptyView].title(@"wuti").imageName(@"empty_yy").actionTitle(@"8888").actionBlock(actionBlock).subMargin(1);
    [self.tableView reloadData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmptyID" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)loadTestData {
    NSMutableArray *section = [NSMutableArray array];
    [section addObject:@"1"];
    [self.dataArray addObject:section];
    [self.tableView reloadData];
}

@end
