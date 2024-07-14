/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#ifndef RESOURCE_TABLE_H
#define RESOURCE_TABLE_H

#include<stdint.h>

namespace OHOS {
const int32_t STRING_ENTRYABILITY_DESC = 0x01000002;
const int32_t STRING_ENTRYABILITY_LABEL = 0x01000003;
const int32_t STRING_MAINABILITY_DESC = 0x01000043;
const int32_t STRING_MAINABILITY_LABEL = 0x01000044;
const int32_t STRING_APP_NAME = 0x01000001;
const int32_t STRING_BOTTOM_TITLE_HEIGHT = 0x01000046;
const int32_t STRING_CALENDAR = 0x01000045;
const int32_t STRING_COMMON_BAR_CHART_HEIGHT = 0x0100004c;
const int32_t STRING_COMMON_NAVIGATION_HEIGHT = 0x0100004d;
const int32_t STRING_COMMON_NAVIGATION_WIDTH = 0x0100004e;
const int32_t STRING_COMMON_STACK_HEIGHT = 0x0100004f;
const int32_t STRING_COMMON_STACK_WIDTH = 0x01000050;
const int32_t STRING_COMMON_TEXT_HEIGHT = 0x01000051;
const int32_t STRING_COMMON_TEXT_WIDTH = 0x01000052;
const int32_t STRING_DIVIDER_HEIGHT = 0x0100005b;
const int32_t STRING_ENTRY_DESC = 0x0100005c;
const int32_t STRING_FRIDAY = 0x01000047;
const int32_t STRING_MAIN_PAGE_PADDING = 0x0100006a;
const int32_t STRING_MAIN_PAGE_PADDING2 = 0x0100006b;
const int32_t STRING_MAIN_PAGE_PADDING5 = 0x0100006c;
const int32_t STRING_MAIN_PAGE_PADDING_TOP = 0x0100006d;
const int32_t STRING_MAIN_PAGE_SWIPER_HEIGHT = 0x0100006e;
const int32_t STRING_MAX_SIZE = 0x01000072;
const int32_t STRING_MODULE_DESC = 0x01000004;
const int32_t STRING_MONDAY = 0x01000048;
const int32_t STRING_OHOS_ID_CARD_MARGIN_START = 0x0100007b;
const int32_t STRING_OHOS_ID_CARD_PADDING_START = 0x0100007c;
const int32_t STRING_OHOS_ID_CORNER_RADIUS_DEFAULT_L = 0x0100007d;
const int32_t STRING_OHOS_ID_CORNER_RADIUS_DEFAULT_M = 0x0100007e;
const int32_t STRING_OHOS_ID_CORNER_RADIUS_SUBTAB = 0x0100007f;
const int32_t STRING_OHOS_ID_ELEMENTS_MARGIN_VERTICAL_L = 0x01000080;
const int32_t STRING_OHOS_ID_ELEMENTS_MARGIN_VERTICAL_M = 0x01000081;
const int32_t STRING_OHOS_ID_TEXT_FONT_FAMILY_MEDIUM = 0x01000082;
const int32_t STRING_OHOS_ID_TEXT_SIZE_BODY1 = 0x01000083;
const int32_t STRING_OHOS_ID_TEXT_SIZE_BODY2 = 0x01000084;
const int32_t STRING_OHOS_ID_TEXT_SIZE_BODY3 = 0x01000085;
const int32_t STRING_OHOS_ID_TEXT_SIZE_CAPTION = 0x01000086;
const int32_t STRING_OHOS_ID_TEXT_SIZE_HEADLINE = 0x01000087;
const int32_t STRING_SATURDAY = 0x01000049;
const int32_t STRING_SCROLL_WIDTH = 0x01000092;
const int32_t STRING_SUNDAY = 0x0100004a;
const int32_t STRING_SWIPER_STACK_HEIGHT1 = 0x010000a8;
const int32_t STRING_SWIPER_STACK_HEIGHT2 = 0x010000a9;
const int32_t STRING_SWIPER_STACK_WIDTH = 0x010000aa;
const int32_t STRING_THURSDAY = 0x0100004b;
const int32_t STRING_TODAY = 0x01000053;
const int32_t STRING_TUESDAY = 0x01000054;
const int32_t STRING_WEDNESDAY = 0x01000055;
const int32_t STRING_WIDTH_FULL = 0x010000d8;
const int32_t STRING_WIDTH_NINETY_PERCENT = 0x010000d9;
const int32_t COLOR_BACKGROUND_COLOR = 0x01000005;
const int32_t COLOR_BADGE_COLOR = 0x01000006;
const int32_t COLOR_CARD_SHADOW_COLOR = 0x01000007;
const int32_t COLOR_COLOR_WHITE = 0x01000008;
const int32_t COLOR_COMMON_COLOR_DARK_BLUE = 0x01000009;
const int32_t COLOR_DIGITAL_SCROLL_ANIMATION_BACKGROUND_COLOR = 0x0100000a;
const int32_t COLOR_FONT_COLOR_LIGHT_DARK = 0x0100000b;
const int32_t COLOR_FRIENDS_PAGE_DIVIDER_COLOR = 0x0100000c;
const int32_t COLOR_HELP_COLOR = 0x0100000d;
const int32_t COLOR_JUMP_BUTTON_BGC = 0x0100000e;
const int32_t COLOR_JUMP_BUTTON_FONT_COLOR = 0x0100000f;
const int32_t COLOR_LIST_ITEM_NORMAL_COLOR = 0x01000010;
const int32_t COLOR_MARQUEE_BG_COLOR1 = 0x01000011;
const int32_t COLOR_MARQUEE_BG_COLOR2 = 0x01000012;
const int32_t COLOR_MINE_BACKGROUND = 0x01000013;
const int32_t COLOR_MUSIC_ICON = 0x01000014;
const int32_t COLOR_OHOS_FA_EMPHASIZE = 0x01000015;
const int32_t COLOR_OHOS_ID_COLOR_BACKGROUND = 0x01000016;
const int32_t COLOR_OHOS_ID_COLOR_EMPHASIZE = 0x01000017;
const int32_t COLOR_OHOS_ID_COLOR_FOREGROUND = 0x01000018;
const int32_t COLOR_OHOS_ID_COLOR_LIST_ALERT = 0x01000019;
const int32_t COLOR_OHOS_ID_COLOR_PALETTE1 = 0x0100001a;
const int32_t COLOR_OHOS_ID_COLOR_PALETTE10 = 0x0100001b;
const int32_t COLOR_OHOS_ID_COLOR_PALETTE11 = 0x0100001c;
const int32_t COLOR_OHOS_ID_COLOR_PALETTE2 = 0x0100001d;
const int32_t COLOR_OHOS_ID_COLOR_PALETTE3 = 0x0100001e;
const int32_t COLOR_OHOS_ID_COLOR_PALETTE4 = 0x0100001f;
const int32_t COLOR_OHOS_ID_COLOR_PALETTE5 = 0x01000020;
const int32_t COLOR_OHOS_ID_COLOR_PALETTE6 = 0x01000021;
const int32_t COLOR_OHOS_ID_COLOR_PALETTE7 = 0x01000022;
const int32_t COLOR_OHOS_ID_COLOR_PALETTE8 = 0x01000023;
const int32_t COLOR_OHOS_ID_COLOR_PALETTE9 = 0x01000024;
const int32_t COLOR_OHOS_ID_COLOR_PALETTE_AUX1 = 0x01000025;
const int32_t COLOR_OHOS_ID_COLOR_PALETTE_AUX10 = 0x01000026;
const int32_t COLOR_OHOS_ID_COLOR_PALETTE_AUX11 = 0x01000027;
const int32_t COLOR_OHOS_ID_COLOR_PALETTE_AUX2 = 0x01000028;
const int32_t COLOR_OHOS_ID_COLOR_PALETTE_AUX3 = 0x01000029;
const int32_t COLOR_OHOS_ID_COLOR_PALETTE_AUX4 = 0x0100002a;
const int32_t COLOR_OHOS_ID_COLOR_PALETTE_AUX5 = 0x0100002b;
const int32_t COLOR_OHOS_ID_COLOR_PALETTE_AUX6 = 0x0100002c;
const int32_t COLOR_OHOS_ID_COLOR_PALETTE_AUX7 = 0x0100002d;
const int32_t COLOR_OHOS_ID_COLOR_PALETTE_AUX8 = 0x0100002e;
const int32_t COLOR_OHOS_ID_COLOR_PALETTE_AUX9 = 0x0100002f;
const int32_t COLOR_OHOS_ID_COLOR_SUB_BACKGROUND = 0x01000030;
const int32_t COLOR_OHOS_ID_COLOR_TEXT_PRIMARY = 0x01000031;
const int32_t COLOR_OHOS_ID_COLOR_TEXT_SECONDARY = 0x01000032;
const int32_t COLOR_OHOS_ID_COLOR_WARNING = 0x01000033;
const int32_t COLOR_PHOTO_PREVIEW_BUILD_BACKGROUND = 0x01000034;
const int32_t COLOR_STACK_BACKGROUND_COLOR = 0x01000035;
const int32_t COLOR_STACK_COLOR = 0x01000036;
const int32_t COLOR_START_BACKGROUND = 0x01000037;
const int32_t COLOR_START_WINDOW_BACKGROUND = 0x01000038;
const int32_t COLOR_SWIPER_JUMP_BG_COLOR = 0x01000039;
const int32_t COLOR_SWIPER_SELECTED_COLOR = 0x0100003a;
const int32_t COLOR_SWIPER_UNSELECTED_COLOR = 0x0100003b;
const int32_t COLOR_TEXT_BG = 0x01000134;
const int32_t COLOR_TEXT_COLOR = 0x0100003c;
const int32_t COLOR_TITLE_FONT_COLOR = 0x0100003d;
const int32_t COLOR_TRANSPARENT_COLOR = 0x0100003e;
const int32_t COLOR_VOICE_RECORD_DYNAMIC_EFFECT_COLOR_ALL = 0x0100003f;
const int32_t COLOR_VOICE_RECORD_DYNAMIC_EFFECT_COLOR_MESSAGE = 0x01000040;
const int32_t COLOR_VOICE_RECORD_DYNAMIC_EFFECT_COLOR_ROW = 0x01000041;
const int32_t COLOR_WHITE = 0x01000042;
const int32_t FLOAT_APP_SIDE_LENGTH = 0x010000dc;
const int32_t FLOAT_BADGE_FONT_SIZE = 0x010000dd;
const int32_t FLOAT_BLANK_HEIGHT = 0x010000de;
const int32_t FLOAT_BORDERRADIUS_TWELVE = 0x010000df;
const int32_t FLOAT_BORDER_RADIUS = 0x010000e0;
const int32_t FLOAT_BOTTOM_INTERVAL_FIVE = 0x010000e1;
const int32_t FLOAT_BOTTOM_INTERVAL_MINUS_FIVE = 0x010000e2;
const int32_t FLOAT_BOTTOM_INTERVAL_MINUS_TEN = 0x010000e3;
const int32_t FLOAT_BUTTON_HEIGHT = 0x010000e4;
const int32_t FLOAT_CANVAS_PADDING_TOP = 0x010000e5;
const int32_t FLOAT_CARD_SWIPER_CARD_SHADOW_OFFSETX = 0x010000e6;
const int32_t FLOAT_CARD_SWIPER_CARD_SHADOW_OFFSETY = 0x010000e7;
const int32_t FLOAT_CARD_SWIPER_CARD_SHADOW_RADIUS = 0x010000e8;
const int32_t FLOAT_CARD_SWIPER_PHOTO_RADIUS = 0x010000e9;
const int32_t FLOAT_CARD_SWIPER_SWIPER_HEIGHT = 0x010000ea;
const int32_t FLOAT_CARD_SWIPER_SWIPER_MARGIN = 0x010000eb;
const int32_t FLOAT_COLUM_OFFSET_ONE = 0x010000ec;
const int32_t FLOAT_COLUMN_PADDING_TOP = 0x010000ed;
const int32_t FLOAT_COMMON_BORDER_RADIUS = 0x010000ee;
const int32_t FLOAT_COMMON_FONT_SIZE = 0x010000ef;
const int32_t FLOAT_EXPANDED_TITLE_FONT_SIZE = 0x010000f0;
const int32_t FLOAT_FONT_SIZE_EIGHTEEN = 0x010000f1;
const int32_t FLOAT_FONT_SIZE_FOURTEEN = 0x010000f2;
const int32_t FLOAT_FONT_SIZE_NORMAL = 0x010000f3;
const int32_t FLOAT_FONT_SIZE_SMALLER = 0x010000f4;
const int32_t FLOAT_FONT_SIZE_TWENTY = 0x010000f5;
const int32_t FLOAT_FONT_SIZE_TWENTY_TWO = 0x010000f6;
const int32_t FLOAT_INIT_TITLE_FONT_SIZE = 0x010000f7;
const int32_t FLOAT_ITEM_IMAGE_HEIGHT = 0x010000f8;
const int32_t FLOAT_ITEM_IMAGE_WIDTH = 0x010000f9;
const int32_t FLOAT_ITEM_TEXT_HEIGHT = 0x010000fa;
const int32_t FLOAT_ITEM_TEXT_OFFSET = 0x010000fb;
const int32_t FLOAT_JUMP_BUTTON_OPACITY = 0x010000fc;
const int32_t FLOAT_LAYOUT_10 = 0x010000fd;
const int32_t FLOAT_LAYOUT_110 = 0x010000fe;
const int32_t FLOAT_LAYOUT_25 = 0x010000ff;
const int32_t FLOAT_LAYOUT_8 = 0x01000100;
const int32_t FLOAT_LAYOUT_90 = 0x01000101;
const int32_t FLOAT_LEFT_INTERVAL_VALUE = 0x01000102;
const int32_t FLOAT_LIST_ITEM_BORDER_RADIUS = 0x01000103;
const int32_t FLOAT_LIST_ITEM_PADDING = 0x01000104;
const int32_t FLOAT_MARGIN_FIFTEEN = 0x01000105;
const int32_t FLOAT_MAX_TEXT_LINES = 0x01000106;
const int32_t FLOAT_MEMO_COUNTS_FONT_SIZE = 0x01000107;
const int32_t FLOAT_MENU_PIC_LAYOUT = 0x01000108;
const int32_t FLOAT_NORMAL_MARGIN = 0x01000109;
const int32_t FLOAT_OFFSET_X = 0x0100010a;
const int32_t FLOAT_OFFSET_Y = 0x0100010b;
const int32_t FLOAT_OPACITY_ZERO_POINT_SIX = 0x0100010c;
const int32_t FLOAT_PAD_TEXT = 0x0100010d;
const int32_t FLOAT_POSITIONY = 0x0100010e;
const int32_t FLOAT_RIGHT_INTERVAL_VALUE = 0x0100010f;
const int32_t FLOAT_SCROLL_WIDTH = 0x01000110;
const int32_t FLOAT_SMALL_FONT_SIZE = 0x01000111;
const int32_t FLOAT_SWIPER_OFFSET = 0x01000112;
const int32_t FLOAT_TAB_BIG_IMG_WITH = 0x01000113;
const int32_t FLOAT_TAB_BORDER_RADIUS = 0x01000114;
const int32_t FLOAT_TAB_FONT_SIZE = 0x01000115;
const int32_t FLOAT_TAB_IMG_SIZE = 0x01000116;
const int32_t FLOAT_TAB_MARGIN = 0x01000117;
const int32_t FLOAT_TEXT_BORDER_RADIUS = 0x01000118;
const int32_t FLOAT_TITLE_OFFSET_Y = 0x01000119;
const int32_t FLOAT_TITLE_TEXT_SIZE = 0x0100011a;
const int32_t FLOAT_TOOL_BAR_WIDTH = 0x0100011b;
const int32_t FLOAT_TOP_INTERVAL_MINUS_FIVE = 0x0100011c;
const int32_t FLOAT_TOP_INTERVAL_SIXTY = 0x0100011d;
const int32_t FLOAT_TOP_INTERVAL_TEN = 0x0100011e;
const int32_t FLOAT_TOP_INTERVAL_TWENTY = 0x0100011f;
const int32_t FLOAT_WATER_RIPPLES_FONT_SIZE = 0x01000120;
const int32_t FLOAT_WATER_RIPPLES_WIDTH = 0x01000121;
const int32_t FLOAT_WIDTH_AND_HEIGHT_FORTY = 0x01000122;
const int32_t FLOAT_WIDTH_AND_HEIGHT_ONE_HUNDRED_AND_THIRTY = 0x01000123;
const int32_t FLOAT_WIDTH_AND_HEIGHT_SIXTY = 0x01000124;
const int32_t FLOAT_WIDTH_AND_HEIGHT_THIRTY = 0x01000125;
const int32_t FLOAT_WIDTH_AND_HEIGHT_THIRTY_FIVE = 0x01000126;
const int32_t MEDIA_APP_ICON = 0x01000000;
const int32_t MEDIA_DOT = 0x0100013d;
const int32_t MEDIA_ICON = 0x010000da;
const int32_t MEDIA_LIST = 0x01000145;
const int32_t MEDIA_ROTATE = 0x01000148;
const int32_t PROFILE_MAIN_PAGES = 0x010000db;
}
#endif