//
//  LoadPictureDetailsInteractor.h
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 10/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import "BaseInteractor.h"
#import "CoreDataStack.h"
@class PictureEntity;

@interface LoadPictureDetailsInteractor : BaseInteractor

- (instancetype)initWithCoreDataStack:(CoreDataStack *)coreDataStack;
- (PictureEntity *)showDetailsForPicture:(PictureEntity *)picture;

@end
