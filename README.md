# DDYEmptyView

UITableView、UICollectionView空白占位

> # 继承

* CocoaPods方式 

	1. pod 'DDYEmptyView', '~> 1.0.1'
	2. \#import \<DDYEmptyViewHeader.h>

* 文件夹拖入工程方式
  
  	1. 下载工程解压后将'DDYEmptyView'文件夹拖到工程中

  	2. \#import "DDYEmptyViewHeader.h"

> # 使用
	
	1. 本库采用链式编程，好处是避免OC没有可选参数造成写多个固定构造函数，坏处代码提示功能不健全。
	2. 示例代码

	```
	__weak __typeof__ (self)weakSelf = self;
	DDYEmptyBlock actionBlock = ^() {
	    [weakSelf loadTestData];
	};
	self.tableView.ddy_EmptyView = [DDYEmptyView emptyView].title(@"wuti").imageName(@"emptyLive").detail(@"9999").actionTitle(@"8888").actionBlock(actionBlock).subMargin(1);
	```