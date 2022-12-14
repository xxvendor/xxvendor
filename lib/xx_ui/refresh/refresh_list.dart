import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../xx_vendor.dart';

export 'package:pull_to_refresh/pull_to_refresh.dart';

typedef ItemBuilder = Widget Function(
  BuildContext context,
  int index,
  List list,
);

typedef SeparatorBuilder = Widget Function(
  BuildContext context,
  int index,
  List list,
);

typedef OnRefresh = Future<Resp> Function();
typedef OnRefreshFinished = Function();
typedef OnLoadMore = Future<Resp> Function(int currentPage);

class XXRefreshListView extends StatefulWidget {
  final OnRefresh onRefresh;
  final OnLoadMore onLoadMore;
  final OnRefreshFinished? onRefreshFinished;
  final ItemBuilder itemBuilder;
  final SeparatorBuilder? separatorBuilder;
  final EdgeInsetsGeometry padding;
  final int initPageIndex;
  final int initPageSize;
  final bool initRefresh;
  final Widget loadingWidget;
  final Widget emptyWidget;
  final ScrollController? scrollController;
  final bool forceRefresh;

  const XXRefreshListView({
    Key? key,
    this.padding = EdgeInsets.zero,
    required this.itemBuilder,
    required this.separatorBuilder,
    required this.onRefresh,
    required this.onLoadMore,
    this.initPageIndex = 1,
    this.initPageSize = 20,
    this.initRefresh = true,
    this.emptyWidget = const SizedBox(),
    this.loadingWidget = const SizedBox(),
    this.scrollController,
    this.forceRefresh = false,
    this.onRefreshFinished,
  }) : super(key: key);

  @override
  State<XXRefreshListView> createState() => _XXRefreshListViewState();
}

class _XXRefreshListViewState extends State<XXRefreshListView>
    with AfterLayoutMixin {
  late RefreshListController refreshListController;
  late RefreshController refreshController;
  String refreshListControllerTag =
      DateTime.now().millisecondsSinceEpoch.toString();

  @override
  void initState() {
    super.initState();
    refreshListController = Get.put<RefreshListController>(
        RefreshListController(widget.initPageSize, !widget.initRefresh),
        tag: refreshListControllerTag);
    refreshController = RefreshController(initialRefresh: widget.initRefresh);
    refreshListController.initRefreshController(refreshController);
  }

  forceRefresh() {
    if (widget.forceRefresh) {
      refreshListController.requestNewData(
          widget.onRefresh, widget.initPageIndex);
    }
  }

  forceRefreshFinished(bool isRefreshFinished) {
    if (widget.forceRefresh) {
      if (isRefreshFinished && widget.onRefreshFinished != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          widget.onRefreshFinished!();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    forceRefresh();
    return GetBuilder<RefreshListController>(
        tag: refreshListControllerTag,
        builder: (controller) {
          forceRefreshFinished(controller.isRefreshFinished);
          List list = controller.list;
          return SmartRefresher(
            enablePullUp: controller.canPullUp,
            controller: controller.refreshController,
            onRefresh: () {
              controller.requestNewData(widget.onRefresh, widget.initPageIndex);
            },
            onLoading: () {
              controller.requestMoreData(widget.onLoadMore);
            },
            child: list.isEmpty
                ? Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                          child: controller.showLoading
                              ? widget.loadingWidget
                              : widget.emptyWidget)
                    ],
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    padding: widget.padding,
                    controller: widget.scrollController,
                    itemBuilder: (context, index) {
                      return widget.itemBuilder(context, index, list);
                    },
                    itemCount: list.length,
                    separatorBuilder: (context, index) {
                      return widget.separatorBuilder == null
                          ? const SizedBox()
                          : widget.separatorBuilder!(context, index, list);
                    },
                  ),
          );
        });
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    refreshListController.requestNewData(
        widget.onRefresh, widget.initPageIndex);
  }

  @override
  void dispose() {
    super.dispose();
    refreshController.dispose();
    if (widget.scrollController != null) {
      widget.scrollController!.dispose();
    }
  }
}

class RefreshListController extends GetxController {
  RefreshController mRefreshController = RefreshController();

  int currentPage = 1;

  int initPageSize = 20;

  List mList = [];

  List get list => mList;

  bool mCanPullUp = false;

  bool get canPullUp => mCanPullUp;

  bool mShowLoading = true;

  bool get showLoading => mShowLoading;

  RefreshListController(this.initPageSize, this.mShowLoading);

  RefreshController get refreshController => mRefreshController;

  bool mIsRefreshFinished = false;

  bool get isRefreshFinished => mIsRefreshFinished;

  initRefreshController(RefreshController refreshController) {
    mRefreshController = refreshController;
    update();
  }

  requestNewData(OnRefresh onRefresh, int initIndexPage) async {
    currentPage = initIndexPage;

    List tempList = [];

    Resp resp = await onRefresh();

    if (resp.success) {
      //判断list的位置,1，list直接是data,2，list在data里面
      if (resp.data != null) {
        // 1，list直接是data,
        if (resp.data is List) {
          tempList = resp.data as List;
        } else {
          //2，list在data里面,并且对应的key为list，如果为其他，再加判断
          if (ListEntity.fromJson(resp.data).list is List) {
            tempList = ListEntity.fromJson(resp.data).list ?? [];
          }
        }
      }
      mList = tempList;
    }

    if (tempList.isNotEmpty) {
      if (tempList.length == initPageSize) {
        currentPage++;
        mRefreshController.refreshCompleted(resetFooterState: true);
        mCanPullUp = true;
      } else {
        mRefreshController.refreshCompleted(resetFooterState: false);
        mCanPullUp = false;
      }
    } else {
      mRefreshController.refreshCompleted(resetFooterState: false);
      mCanPullUp = false;
    }

    if (mShowLoading) {
      mShowLoading = !mShowLoading;
    }
    mIsRefreshFinished = true;

    update();
  }

  requestMoreData(OnLoadMore onLoadMore) async {
    List tempList = [];

    Resp resp = await onLoadMore(currentPage);

    if (resp.success) {
      //判断list的位置,1，list直接是data,2，list在data里面
      if (resp.data != null) {
        // 1，list直接是data,
        if (resp.data is List) {
          tempList = resp.data as List;
        } else {
          //2，list在data里面,并且对应的key为list，如果为其他，再加判断
          if (ListEntity.fromJson(resp.data).list is List) {
            tempList = ListEntity.fromJson(resp.data).list ?? [];
          }
        }
      }
    }

    mList.addAll(tempList);
    if (tempList.isNotEmpty) {
      if (tempList.length == initPageSize) {
        currentPage++;
        mRefreshController.loadComplete();
      } else {
        mRefreshController.loadNoData();
      }
    } else {
      mRefreshController.loadNoData();
    }
    update();
  }
}

class ListEntity {
  List<dynamic>? list;

  ListEntity(this.list);

  ListEntity.fromJson(Map<String, dynamic> json) {
    list = json['list'] != null
        ? (json['list'] as List).map((i) => i).toList()
        : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['list'] = list != null ? list?.map((i) => i.toJson()).toList() : [];
    return data;
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}
