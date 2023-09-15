import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane/bottom_sheets/notification_filter_sheet.dart';
import 'package:plane/bottom_sheets/notification_more_options_sheet.dart';
import 'package:plane/provider/provider_list.dart';
import 'package:plane/screens/MainScreens/Notification/notifications_list.dart';
import 'package:plane/widgets/custom_app_bar.dart';
import 'package:plane/widgets/custom_text.dart';
import '/utils/enums.dart';

class NotifiactionScreen extends ConsumerStatefulWidget {
  const NotifiactionScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotifiactionScreenState();
}

class _NotifiactionScreenState extends ConsumerState<NotifiactionScreen> {
  PageController controller = PageController();
  int selected = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var notificationProvider = ref.watch(ProviderList.notificationProvider);
    var themeProvider = ref.watch(ProviderList.themeProvider);

    return Scaffold(
      appBar: CustomAppBar(
        onPressed: () {},
        text: "Notifications",
        centerTitle: false,
        leading: false,
        fontType: FontStyle.H4,
        elevation: false,
        actions: [
          GestureDetector(
            onTap: () {
              notificationProvider.getNotifications(type: 'assigned');
              notificationProvider.getNotifications(type: 'created');
              notificationProvider.getNotifications(type: 'watching');
              notificationProvider.getUnreadCount();
              notificationProvider.getNotifications(
                  type: 'unread', getUnread: true);
            },
            child: CircleAvatar(
              radius: 20,
              backgroundColor:
                  themeProvider.themeManager.primaryBackgroundSelectedColour,
              child: Icon(
                Icons.refresh,
                size: 20,
                color: themeProvider.themeManager.secondaryTextColor,
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                enableDrag: true,
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.4),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
                context: context,
                builder: (context) => const NotificationFilterSheet(),
              );
            },
            child: CircleAvatar(
              radius: 20,
              backgroundColor:
                  themeProvider.themeManager.primaryBackgroundSelectedColour,
              child: Center(
                child: Icon(
                  Icons.filter_list_outlined,
                  size: 20,
                  color: themeProvider.themeManager.secondaryTextColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                enableDrag: true,
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.2),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
                context: context,
                builder: (context) => NotificationMoreOptionsSheet(selected),
              );
            },
            child: CircleAvatar(
              radius: 20,
              backgroundColor:
                  themeProvider.themeManager.primaryBackgroundSelectedColour,
              child: Center(
                child: Icon(
                  Icons.more_vert_outlined,
                  size: 20,
                  color: themeProvider.themeManager.secondaryTextColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          Container(
            //bottom border
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: themeProvider.themeManager.borderSubtle01Color,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      controller.jumpToPage(0);
                    },
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: CustomText(
                                'My Issues',
                                color: selected == 0
                                    ? themeProvider.themeManager.primaryColour
                                    : themeProvider
                                        .themeManager.placeholderTextColor,
                                type: FontStyle.Medium,
                                overrride: true,
                              ),
                            ),
                            notificationProvider.getAssignedCount == 0
                                ? Container()
                                : Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: themeProvider
                                          .themeManager.primaryColour,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: CustomText(
                                      notificationProvider.getAssignedCount
                                          .toString(),
                                      color: Colors.white,
                                      type: FontStyle.Small,
                                    ),
                                  )
                          ],
                        ),
                        selected == 0
                            ? Container(
                                height: 6,
                                color: themeProvider.themeManager.primaryColour,
                              )
                            : Container(
                                height: 6,
                              )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      controller.jumpToPage(1);
                    },
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: CustomText(
                                overrride: true,
                                'Created',
                                color: selected == 1
                                    ? themeProvider.themeManager.primaryColour
                                    : themeProvider
                                        .themeManager.placeholderTextColor,
                                type: FontStyle.Medium,
                              ),
                            ),
                            notificationProvider.getCreatedCount == 0
                                ? Container()
                                : Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: themeProvider
                                          .themeManager.primaryColour,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: CustomText(
                                      notificationProvider.getCreatedCount
                                          .toString(),
                                      color: Colors.white,
                                      type: FontStyle.Small,
                                    ),
                                  )
                          ],
                        ),
                        selected == 1
                            ? Container(
                                height: 6,
                                color: themeProvider.themeManager.primaryColour,
                              )
                            : Container(
                                height: 6,
                              )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      controller.jumpToPage(2);
                    },
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: CustomText(
                                overrride: true,
                                'Subscribed',
                                color: selected == 2
                                    ? themeProvider.themeManager.primaryColour
                                    : themeProvider
                                        .themeManager.placeholderTextColor,
                                type: FontStyle.Medium,
                              ),
                            ),
                            notificationProvider.getWatchingCount == 0
                                ? Container()
                                : Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: themeProvider
                                          .themeManager.primaryColour,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: CustomText(
                                      notificationProvider.getWatchingCount
                                          .toString(),
                                      color: Colors.white,
                                      type: FontStyle.Small,
                                    ),
                                  )
                          ],
                        ),
                        selected == 2
                            ? Container(
                                height: 6,
                                color: themeProvider.themeManager.primaryColour,
                              )
                            : Container(
                                height: 6,
                              ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: controller,
              onPageChanged: (value) {
                setState(() {
                  selected = value;
                });
              },
              children: [
                NotificationsList(
                  type: 'assigned',
                  data: ref.read(ProviderList.notificationProvider).assigned,
                ),
                NotificationsList(
                  type: 'created',
                  data: ref.read(ProviderList.notificationProvider).created,
                ),
                NotificationsList(
                  type: 'watching',
                  data: ref.read(ProviderList.notificationProvider).watching,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
