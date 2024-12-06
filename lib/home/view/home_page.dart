import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiki_repository/wiki_repository.dart';
import 'package:wikigen/home/bloc/home_bloc.dart';
import 'package:wikigen/models/destinations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        return switch (state) {
          HomeInitial() => const Initial(),
          HomeLoading() => const Loading(),
          HomeReady() => Ready(wiki: state.currentWiki),
        };
      },
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        leading: BackButton(
          onPressed: () => context.read<HomeBloc>().add(NavigatedToHome()),
        ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Wikigen",
            style: theme.textTheme.titleLarge
                ?.copyWith(color: theme.colorScheme.onSurface),
          ),
        ),
      ),
      body: const Center(
        child: Column(
          children: [
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

class Initial extends StatelessWidget {
  const Initial({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        List<Widget> wikis = List.empty();

        for (var i = 0; i < state.wikis.length; i++) {
          final wiki = state.wikis[i];

          wikis.add(WikiItem(wiki: wiki));
        }
        return Scaffold(
          appBar: HomeAppBar(theme: theme),
          drawer: HomeNavigationDrawer(theme: theme),
          body: Column(
            children: [
              Expanded(
                  child: Column(
                children: wikis,
              )),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SearchBar(
                    trailing: [
                      IconButton(
                          onPressed: () {
                            context.read<HomeBloc>().add(HomeQueryEntered());
                          },
                          icon: const Icon(Icons.send))
                    ],
                    onChanged: (value) =>
                        {context.read<HomeBloc>().add(HomeQueryChanged(value))},
                    onSubmitted: (value) {
                      context.read<HomeBloc>().add(HomeQueryEntered());
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
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

class Ready extends StatelessWidget {
  const Ready({required wiki, super.key}) : _wiki = wiki;

  final Wiki _wiki;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        leading: BackButton(
          onPressed: () => context.read<HomeBloc>().add(NavigatedToHome()),
        ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            _wiki.title,
            style: theme.textTheme.titleLarge
                ?.copyWith(color: theme.colorScheme.onSurface),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _wiki.summary,
              style: theme.textTheme.titleMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _wiki.introduction,
                  style: theme.textTheme.bodyLarge,
                ),
              ),
            ),
          ),
          const Divider(),
          SectionsExpansionPanelList(sections: _wiki.sections)
        ],
      ),
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

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(List<Section> sections) {
  return List<Item>.generate(sections.length, (int index) {
    return Item(
      headerValue: sections[index].title,
      expandedValue: sections[index].contents,
    );
  });
}

class SectionsExpansionPanelList extends StatefulWidget {
  const SectionsExpansionPanelList({required List<Section> sections, super.key})
      : _sections = sections;

  final List<Section> _sections;
  @override
  State<SectionsExpansionPanelList> createState() =>
      _SectionsExpansionPanelListState(generateItems(_sections));
}

class _SectionsExpansionPanelListState
    extends State<SectionsExpansionPanelList> {
  _SectionsExpansionPanelListState(List<Item> data) : _data = data;

  final List<Item> _data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
            title: Text(item.expandedValue),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
