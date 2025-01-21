import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wiki_repository/wiki_repository.dart';
import 'package:wikigen/home/domain/app_domain.dart';
import 'package:wikigen/home/view/wiki_page.dart';
import 'package:wikigen/models/destinations.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key, this.isSaved = false});

  final bool isSaved;

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final wikis = ref.watch(wikisControllerProvider);
    return Scaffold(
      appBar: HomeAppBar(theme: theme),
      drawer: HomeNavigationDrawer(theme: theme),
      body: Column(
        children: [
          switch (wikis) {
            AsyncData(:final List<Wiki> value) =>
              Expanded(child: ListView.builder(
                
                itemCount: value.length,
                itemBuilder: (context, index) {
                  final item = value[index];
                  
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(LocalWikiPage.route(item));
                    },
                    isThreeLine: true,
                    title: Text(item.title),
                    subtitle: Text(item.introduction.length > 150 ? "${item.introduction.substring(0, 147)}..." : item.introduction),
                    trailing: IconButton(onPressed: () {ref.read(wikisControllerProvider.notifier).removeWiki(item.id);}, icon: const Icon(Icons.delete)),
                  );
                },
              )),
            _ => const Center(child: CircularProgressIndicator())
          },
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchBar(
                trailing: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(WikiPage.route(_controller.text, null));
                      },
                      icon: const Icon(Icons.send))
                ],
                controller: _controller,
                onSubmitted: (value) => Navigator.of(context)
                    .push(WikiPage.route(_controller.text, null)),
              ),
            ),
          ),
        ],
      ),
    );
  }
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

class HomeNavigationDrawer extends StatelessWidget {
  const HomeNavigationDrawer({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: 0,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
          child: Text(
            'Wikigen',
            style: theme.textTheme.titleMedium,
          ),
        ),
        ...destinations.map(
          (Destination destination) {
            return NavigationDrawerDestination(
              label: Text(destination.label),
              icon: destination.icon,
              selectedIcon: destination.selectedIcon,
            );
          },
        ),
      ],
    );
  }
}

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
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