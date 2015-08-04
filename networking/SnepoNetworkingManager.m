//
//  SnepoNetworkingManager.m
//  networking
//
//  Created by Melad Barjel on 4/08/2015.
//  Copyright (c) 2015 Snepo. All rights reserved.
//

#import "SnepoNetworkingManager.h"

#import "AFNetworking.h"

@interface SnepoNetworkingManager ()

@property (nonatomic, strong) AFHTTPRequestOperationManager* operationManager;

@end

@implementation SnepoNetworkingManager

+ (instancetype)sharedManager {
    static id _instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (id)init {
    self = [super init];
    if (self) {
        _operationManager = [AFHTTPRequestOperationManager manager];
        
        AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        _operationManager.requestSerializer = requestSerializer;
        
        AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
        [responseSerializer setRemovesKeysWithNullValues:YES];
        _operationManager.responseSerializer = responseSerializer;
    }
    return self;
}

- (void)setToken:(NSString *)token name:(NSString *)name {
    if (!token) {
        [_operationManager.requestSerializer clearAuthorizationHeader];
    } else {
        [_operationManager.requestSerializer setValue:[NSString stringWithFormat:@"Token token=%@",token] forHTTPHeaderField:@"Authorization"];
    }
    [_operationManager.requestSerializer setValue:name forHTTPHeaderField:@"X-User-Username"];
}

#pragma mark - GET

- (void)get:(NSString *)get withParameters:(NSDictionary *)parameters withSuccess:(void(^)(NSDictionary * data))success failure:(void(^)(NSError* error))failure {
    [_operationManager GET:get parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - POST

- (void)post:(NSString *)post withParameters:(NSDictionary *)parameters withSuccess:(void(^)(NSDictionary * data))success failure:(void(^)(NSError* error))failure {
    [_operationManager POST:post parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - PATCH

- (void)patch:(NSString *)patch withParameters:(NSDictionary *)parameters withSuccess:(void(^)(NSDictionary * data))success failure:(void(^)(NSError * error))failure {
    [_operationManager PATCH:patch parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - DELETE

- (void)delete:(NSString *)delete withParameters:(NSDictionary *)parameters withSuccess:(void(^)(NSDictionary * data))success failure:(void(^)(NSError * error))failure {
    [_operationManager DELETE:delete parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end