//
//  PhotoLibraryManager.h
//  Unity-iPhone
//
//  Created by Basel Abdelaziz on 4/21/17.
//
//

#ifndef PhotoLibraryManager_h
#define PhotoLibraryManager_h

@interface PhotoLibraryManager : NSObject

@property PhotoLibraryManager *plm;

- (void)saveVideoToLibrary:(NSString *) videoPath;

@end

#endif /* PhotoLibraryManager_h */
