
//
//  Function.h
//  GuideBook
//
//  Created by Apple on 2020/3/12.
//  Copyright © 2020 Design. All rights reserved.
//

#ifndef Function_h
#define Function_h


#ifdef DEBUG
#define NSLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif

#define IMG(__IMAGENAME)    [UIImage imageNamed:__IMAGENAME]

#define TRainDataJSON @"TrainData"
#define RankTrainJSON @"RankTrain"
#define SaveTrainName @"SaveTrainArr"
#define AddSunccessNotice @"SaveSuccess"
#define TrainNumbers @"TrainNumbers"
#define UserName @"userName"
#define UserSaying @"userSaying"


///    多语言处理

#define BaseCancel @"取消"
#define BaseSure @"确认"

#define MainTabbarItem1 @"训练项目"
#define MainTabbarItem2 @"设置中心"

#define HomeFunc1 @"足球简介"
#define HomeFunc2 @"训练排行"
#define HomeFunc3 @"动态教程"
#define HomeTitle @"训练项目"
#define HomeClean @"清空"
#define HomeDelete @"删除"
#define HomeNodataTitle @"暂无训练项目"
#define HomeNodataMessage @"请添加新的训练项目,然后回来查看详情"
#define HomeNodataLook @"查看详情"
#define HomeAddNewPro @"添加新的训练项目"
#define HomeAlertTitle @"清空内容"
#define HomeAlertMessa @"返回将清空内容，是否继续"

#define TroduceTitle @"简介"
#define TroduceHeadT @"足球 (Football)"
#define TroduceContent @"足球，英文football，被誉为“世界第一运动”，全球体育界最具影响力的体育运动。\n标准的11人制足球比赛由两队各派10名球员与1名守门员，总共22人，在长方形的草地球场上对抗、防守、进攻。\n\n比赛时尽量将足球射入对方的球门内，每射入一球就可以得到一分，当比赛完毕后，得分多的一队则胜出。如果在比赛规定时间内得分相同，则须看比赛章则而定，可以抽签、加时再赛或互射点球（十二码）等形式比赛分高下。\n  足球比赛中除了守门员可以在己方禁区内利用手部接触足球外，球场上每名球员只可以利用手以外的身体其他部分控制足球（开界外球例外）。\n当今世界足球水平最高的联赛是欧洲足球五大联赛。分别是西甲联赛，英超联赛，意甲联赛，德甲联赛，法甲联赛。"

#define RankTitle @"训练排行"

#define TutorTitle @"动态教程"

#define OtherTitle @"其他"

#define DetailComplete @"完成"
#define DetailTotal @"训练总次数"
#define DetailNum @"123次"
#define DetailSuccess @"您已经完成训练,无需再次完成"
#define DetailAlertTitle @"完成训练"
#define DetailAlertContent @"是否已经完成训练项目"

#define AddSelectTitle @"请选择训练"
#define AddNoType @"请选择训练项目"
#define AddChooseTime @"选择时间"
#define AddAlertChooseTime @"请选择训练时间"
#define AddAlertChooseAddress @"请输入训练场地"
#define AddAlertSuccess @"添加训练成功,请按时训练"
#define AddChooseAddress @"       请输入训练地址"
#define AddNochooseTitle @"请选择一个训练项目,此处将会显示训练要求与技巧!"

#define SetTitle @"设置中心"
#define SetTarget @"训练目标"
#define SetAlertTarget @"总共需要%@次训练/完成训练次数 %ld次"
#define SetAlertTargetTitle @"请输入想要训练的总次数"
#define SetTextPlaceholde @"请输入训练总次数"
#define SetShareTitle @"分享的标题"
#define SetBackFeedTitle @"反馈意见"
#define SetBackFeedContent @"请填写反馈内容"
#define SetNoTargetTitle @"暂未添加训练次数"
#define SetCellBakcFeed @"反馈意见"
#define SetCellGood @"点赞鼓励"
#define SetCellConnect @"联系我们"
#define SetCellAbout @"关于我们"
#define SetCellShare @"分享好友"

#define FeedBackTitle @"反馈意见"
#define FeedBackContent @"发送反馈内容"
#define FeedBackSend @"发送"
#define FeedBackAlertContent @"请输入反馈内容"
#define FeedBackAlertSuccess @"多谢你的反馈!"

#define AboutTitle @"关于我们"
#define AboutHeadTitle @"足球技巧训练"
#define AboutContent @"         球感是一个很虚的概念，因此对球感的养成其实并无捷径，这就需要你在平时多下功夫！下面十个动作，每个动作练习30秒，组间间歇30秒再进行下一个动作。每天练习5分钟，七天就能见到效果！"
#define AboutVersion @"Version 1.0, Made By SuitDevs"

#define EditTitle @"修改用户信息"
#define EditCellAvatar @"修改头像"
#define EditCellName @"昵称"
#define EditCellSaying @"名言"
#define EditDefaultName @"足球先生"
#define EditDefaultSaying @"编辑名言"
#define EditAlertTitleName @"修改昵称"
#define EditAlertMessageName @"请输入昵称"
#define EditAlertTitleSaying @"修改名言"
#define EditAlertMessageSaying @"请输入名言警句"




#define WEAKSELF(weakSelf)  __weak __typeof(self)weakSelf = self;

#endif /* Function_h */
