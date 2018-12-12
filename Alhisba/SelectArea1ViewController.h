

#import "BaseViewController.h"
#import "PopViewControllerDelegate.h"


@interface SelectArea1ViewController : BaseViewController
@property (nonnull) id<PopViewControllerDelegate> delegate;
@property (nonatomic) NSString *restId;
@property (nonatomic, copy) void (^completionBlock)(NSMutableDictionary *area);


@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UIView * _Nullable totalView;

@property (weak, nonatomic) IBOutlet UILabel *noServiceLvbl;


- (IBAction)cancelBtnClciked:(id)sender;


@end
