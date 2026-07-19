import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lifeclient/features/admin_panel/view/admin_applications_tab.dart';
import 'package:lifeclient/features/admin_panel/view/admin_users_tab.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/widget/app_bar/page_app_bar.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/general/semantics/general_semantic.dart';
import 'package:lifeclient/product/widget/general/semantics/general_semantic_keys.dart';

enum _AdminPanelTab { users, applications }

final class AdminPanelView extends StatelessWidget {
  const AdminPanelView({super.key});

  @override
  Widget build(BuildContext context) {
    return GeneralSemantic(
      semanticKey: GeneralSemanticKeys.adminPanelView,
      child: DefaultTabController(
        length: _AdminPanelTab.values.length,
        child: GeneralScaffold(
          appBar: PageAppBar(pageTitle: LocaleKeys.admin_title),
          body: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(text: LocaleKeys.admin_usersTab.tr()),
                  Tab(text: LocaleKeys.admin_applicationsTab.tr()),
                ],
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    AdminUsersTab(),
                    AdminApplicationsTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
