#import "TRGridVC.h"

#import "ELHASO.h"
#import "TRGridCell.h"
#import "TRLogic.h"
#import "TRPhotoData.h"
#import "TRPhotoDetailVC.h"


#define kTRGridCell @"TRGridCell"


@interface TRGridVC ()

@property (nonatomic, strong) IBOutlet UICollectionView* collectionView;
/// Just a copy of the latest global fetch.
@property (nonatomic, strong) NSArray* items;
/// Parent which fades in/out with some timeouts.
@property (strong, nonatomic) IBOutlet UIView *errorView;
@property (strong, nonatomic) IBOutlet UILabel *errorLabel;

@end


@implementation TRGridVC

#pragma mark -
#pragma mark Life

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView
        registerNib:[UINib nibWithNibName:kTRGridCell bundle:nil]
        forCellWithReuseIdentifier:kTRGridCell];

    self.items = [TRLogic getPhotos];
    self.errorView.hidden = YES;
    self.errorView.alpha = 0;
}

/** Starts an automatic loading of photos the fist time.
 *
 * This is a good place to put the automatic fetch for the app startup, since
 * this is the first view that will be seen and we expect to have always some
 * items.
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.items.count < 1) {
        DLOG(@"No photos? Go get some…");

        [TRLogic fetchPhotosWithCallback:^(NSError* error){
                BLOCK_UI();
                if (error) {
                    DLOG(@"Error fetching photos: %@", error);
                    self.errorLabel.text =
                        NON_NIL_STRING(error.localizedDescription);
                    self.errorView.hidden = NO;
                    // Fade in the error, from whatever state it was.
                    [UIView animateWithDuration:kFadeInterval delay:0
                        options:kFadeOptions animations:^{
                            self.errorView.alpha = 1;
                        } completion:^(BOOL finished) {
                            // Discard the error if there are items.
                            if (self.items.count)
                                RUN_AFTER(2, ^{ [self fadeOutErrorView]; });
                        }];
                } else {
                    // Discard any previous error message should if reloading.
                    [self fadeOutErrorView];
                    self.items = [TRLogic getPhotos];
                    [self.collectionView reloadData];
                }
            }];
    }
}

#pragma mark -
#pragma mark Methods

/** Fades out the error view.
 *
 * The fadeing is done from whatever current state there is and without
 * interrupting animations, so it should be safe to call this always.
 *
 * Reimplementing existing HUD libraries because it's fun… not.
 */
- (void)fadeOutErrorView
{
    BLOCK_UI();
    [UIView animateWithDuration:kFadeInterval delay:0 options:kFadeOptions
        animations:^{ self.errorView.alpha = 0; } completion:nil];
}

#pragma mark -
#pragma mark UICollectionViewDataSource protocol

- (NSInteger)collectionView:(UICollectionView*)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView
    cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    TRPhotoData* photoData = self.items[indexPath.row];
    TRGridCell* cell = [self.collectionView
        dequeueReusableCellWithReuseIdentifier:kTRGridCell
        forIndexPath:indexPath];

    [cell configure:photoData];
    return cell;
}

#pragma mark -
#pragma mark UICollectionViewDelegate protocol

- (void)collectionView:(UICollectionView*)collectionView
    didSelectItemAtIndexPath:(NSIndexPath*)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];

    TRPhotoDetailVC* vc = [TRPhotoDetailVC new];
    vc.photoData = self.items[indexPath.row];
    UINavigationController *navVc = [[UINavigationController alloc]
        initWithRootViewController:vc];
    [self presentViewController:navVc animated:YES completion:nil];
}

@end
