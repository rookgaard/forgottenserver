// Copyright 2022 The Forgotten Server Authors. All rights reserved.
// Use of this source code is governed by the GPL-2.0 License that can be found in the LICENSE file.

#ifndef FS_ACCOUNT_H
#define FS_ACCOUNT_H

#include "enums.h"

struct Character {
	std::string name;
	uint16_t lookType, level;
	uint8_t lookHead, lookBody, lookLegs, lookFeet, lookAddons, vocation;
};

struct Account
{
	std::vector<Character> characters;
	std::string name;
	std::string key;
	uint32_t id = 0;
	time_t premiumEndsAt = 0;
	AccountType_t accountType = ACCOUNT_TYPE_NORMAL;

	Account() = default;
};

#endif // FS_ACCOUNT_H
