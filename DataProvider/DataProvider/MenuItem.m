//
//  Created by Steffen Bauereiss on 24.12.12.
//  Copyright (c) 2012 Steffen Bauereiss. All rights reserved.
//

#import "MenuItem.h"

@implementation MenuItem

// Initialization/Setup

- (id) initWithTitle:(NSString*)theTitle imgUrl:(NSString*)theImgURL usingChildren:(NSArray *)children andParent:(MenuItem *)theParent{
	if (self = [super init]) {
		title = theTitle;
		imgURL = theImgURL;
		childMenuItems = children;
		parent = theParent;
	}
	
	return self;
}
- (void) setChildren:(NSArray*) children {
	childMenuItems = children;
}- (void) setParent:(MenuItem*) theParent {
	parent = theParent;
}

// View / Represenatation relevant

- (NSString*) getTitle {
	return title;
}

- (NSString*) getImgUrl {
	return imgURL;
}
- (UIImage *) getImg {
	if (imgURL == nil) return nil;
	return [UIImage imageNamed:[[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:imgURL] encoding:NSUTF8StringEncoding error:nil]];
}

// Navigation relevant

- (int) getChildrenCount {
	if (![self isLeaf]) {
		return [childMenuItems count];
	}
	return 0;
}
- (NSArray *) getChildren {
	return childMenuItems;
}
- (MenuItem *) getParent {
	return parent;
}

- (BOOL) isLeaf {
	return childMenuItems == nil;
}

@end
