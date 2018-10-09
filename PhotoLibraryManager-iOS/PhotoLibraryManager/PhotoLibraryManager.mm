//
//  PhotoLibraryManager.m
//  Unity-iPhone
//
//  Created by Basel Abdelaziz on 4/21/17.
//
//

#import <Foundation/Foundation.h>
#import "PhotoLibraryManager.h"
#import <Photos/Photos.h>

@implementation PhotoLibraryManager

+ (id)instance
{
	PhotoLibraryManager *instance = [[self alloc] init];
	if (instance.plm == nil)
		instance.plm = instance;
	
	return instance.plm;
}

- (void)requestAuthorization:(void (^) (bool authorized)) handler
{
	PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
	
	if (status == PHAuthorizationStatusAuthorized) {
		// Access has been granted.
		handler(true);
	}
	
	else if (status == PHAuthorizationStatusDenied) {
		// Access has been denied.
		handler(false);
	}
	
	else if (status == PHAuthorizationStatusNotDetermined) {
		
		// Access has not been determined.
		[PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
			
			if (status == PHAuthorizationStatusAuthorized) {
				handler(true);
			}
			
			else {
				handler(false);
			}
		}];
	}
	
	else if (status == PHAuthorizationStatusRestricted) {
		// Restricted access - normally won't happen.
		handler(false);
	}
}

- (void)saveVideoToLibrary:(NSString *) videoPath
{
	NSURL *url = [NSURL URLWithString:videoPath];
	
	[[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
		PHAssetChangeRequest *request = [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:url];
		[request placeholderForCreatedAsset];
	} completionHandler:^(BOOL success, NSError *error) {
		NSLog(@"Finished adding asset. %@", (success ? @"Success" : error));
	}];
}

- (void)savePhotoToLibrary:(NSString *) photoPath
{
	NSURL *url = [NSURL URLWithString:photoPath];
	
	[[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
		PHAssetChangeRequest *request = [PHAssetChangeRequest creationRequestForAssetFromImageAtFileURL:url];
		[request placeholderForCreatedAsset];
	} completionHandler:^(BOOL success, NSError *error) {
		NSLog(@"Finished adding asset. %@", (success ? @"Success" : error));
	}];
}

static NSString* CreateNSString(const char* string)
{
	if (string != NULL)
		return [NSString stringWithUTF8String:string];
	else
		return [NSString stringWithUTF8String:""];
}

extern "C"
{
	
	PhotoLibraryManager *libraryManager;
	BOOL authorized;
	
	void PhotoLibraryManager_Init()
	{
		libraryManager = [PhotoLibraryManager instance];
	}
	
	void PhotoLibraryManager_RequestAuthorization()
	{
		[libraryManager requestAuthorization:^(bool authorized) {
			authorized = authorized;
		}];
	}
	
	void PhotoLibraryManager_SaveVideo(char* path)
	{		
		[libraryManager saveVideoToLibrary:CreateNSString(path)];
	}
	
	void PhotoLibraryManager_SavePhoto(char* path)
	{
		[libraryManager savePhotoToLibrary:CreateNSString(path)];
	}
	
}

@end
