import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/src/shared_preferences_async.dart';
import 'package:wiki_repository/wiki_repository.dart';
import 'package:wikigen/home/domain/app_domain.dart';
import 'package:wikigen/home/view/settings_page.dart';
import 'package:wikigen/home/view/wiki_page.dart';
import 'package:wikigen/models/destinations.dart';

class AppPage extends ConsumerStatefulWidget {
  const AppPage({super.key});

  @override
  ConsumerState<AppPage> createState() => _AppPageState();
}

class _AppPageState extends ConsumerState<AppPage> {
  var destination = 0;

  @override
  Widget build(BuildContext context) {
    final destinationWidget = switch (destination) {
      0 => HomePage(
          onOpenSettings: () {
            setState(() {
              destination = 2;
            });
          },
        ),
      1 => Container(),
      2 => const SettingsPage(),
      _ => null,
    };

    return Scaffold(
      appBar: const WGAppBar(),
      drawer: WGNavigationDrawer(
        index: destination,
        onPressed: (value) {
          setState(() {
            destination = value;
          });
        },
      ),
      body: destinationWidget,
    );
  }
}

class HomePage extends ConsumerWidget {
  HomePage({
    super.key,
    this.onOpenSettings,
  });

  final _controller = TextEditingController();
  final Function? onOpenSettings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wikis = ref.watch(wikisControllerProvider);
    final preferences = ref.watch(preferencesProvider);
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        switch (preferences) {
          AsyncData(:final value) => FutureBuilder<String?>(
              builder: (context, snapshot) {
                final theme = Theme.of(context);
                if (snapshot.data?.isEmpty ?? false) {
                  return MaterialBanner(
                    content: Text(
                      "Gemini API Key needs to be set",
                      style: theme.textTheme.titleLarge,
                    ),
                    backgroundColor: theme.colorScheme.errorContainer,
                    actions: [
                      TextButton(
                        onPressed: () {
                          if (onOpenSettings != null) {
                            onOpenSettings!();
                          }
                        },
                        child: Text(
                          "Open Settings",
                          style: theme.textTheme.titleLarge,
                        ),
                      )
                    ],
                  );
                } else {
                  return Container();
                }
              },
              future: value.getString("api_key"),
            ),
          _ => Container()
        },
        switch (wikis) {
          AsyncData(:final List<Wiki> value) => Expanded(
              flex: 5,
              child: Column(
                children: [
                  if (value.isNotEmpty)
                    Expanded(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 1000,
                        ),
                        child: LayoutBuilder(builder: (context, contraints) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView.builder(
                              itemCount: value.length,
                              itemBuilder: (context, index) {
                                final item = value[index];

                                return Card.filled(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                item.title,
                                                style: theme
                                                    .textTheme.titleLarge!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                            ),
                                            IconButton(
                                                onPressed: () async {
                                                  
                                                  await ref
                                                      .read(
                                                          wikisControllerProvider
                                                              .notifier)
                                                      .removeWiki(item.id);
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                  size: 32,
                                                )),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            item.introduction.length > 150
                                                ? "${item.introduction.substring(0, 147)}..."
                                                : item.introduction,
                                            style: theme.textTheme.bodyMedium,
                                            overflow: TextOverflow.visible,
                                            softWrap: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount:
                                          (contraints.maxWidth ~/ 250).toInt()),
                            ),
                          );
                        }),
                      ),
                    ),
                ],
              ),
            ),
          _ => const Expanded(child: Center(child: CircularProgressIndicator()))
        },
        const Divider(),
        switch (preferences) {
          AsyncData(:final value) => FutureBuilder<String?>(
              future: value.getString("api_key"),
              builder: (context, snapshot) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12, top: 4),
                  child: SearchBar(
                    trailing: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).push(WikiPage.route(
                                _controller.text, snapshot.data ?? "", null));
                          },
                          icon: const Icon(Icons.send))
                    ],
                    enabled: snapshot.data?.isNotEmpty ?? false,
                    controller: _controller,
                    onSubmitted: (value) => Navigator.of(context).push(
                        WikiPage.route(
                            _controller.text, snapshot.data ?? "", null)),
                  ),
                );
              }),
          _ => Container()
        }
      ],
    );
  }
}

class WGNavigationDrawer extends StatelessWidget {
  const WGNavigationDrawer(
      {super.key, required this.onPressed, required this.index});

  final Function(int value) onPressed;
  final int index;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return NavigationDrawer(
      selectedIndex: index,
      onDestinationSelected: (value) {
        onPressed(value);
        Scaffold.of(context).closeDrawer();
      },
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
          child: Text(
            'Wikigen',
            style: theme.textTheme.titleMedium,
          ),
        ),
        ...Destination.values.map(
          (Destination destination) {
            return NavigationDrawerDestination(
              label: Text(destination.label),
              icon: Icon(destination.icon),
              selectedIcon: Icon(destination.selectedIcon),
            );
          },
        ),
      ],
    );
  }
}

class WGAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WGAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      leading: DrawerButton(
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Wikigen",
          style: theme.textTheme.titleLarge
              ?.copyWith(color: theme.colorScheme.onSurface),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class WikiItem extends StatelessWidget {
  const WikiItem({
    super.key,
    required this.wiki,
  });

  final Wiki wiki;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(wiki.title),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(wiki.summary),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(wiki.createdOn.toString(),
                style: Theme.of(context).textTheme.labelMedium),
            Text(wiki.lastModified.toString(),
                style: Theme.of(context).textTheme.labelMedium),
          ],
        )
      ],
    );
  }
}
