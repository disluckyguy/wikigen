import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wikigen/home/bloc/home_bloc.dart';
import 'package:wikigen/models/destinations.dart';
import 'package:wikigen/models/wiki.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        print(state);
        return Scaffold(
            appBar: HomeAppBar(theme: theme),
            drawer: HomeNavigationDrawer(theme: theme),
            body: switch (state) {
              HomeInitial() => const Initial(),
              HomeLoading() => const Loading(),
              // TODO: Handle this case.
              HomeReady() => throw UnimplementedError(),
            });
      },
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class Initial extends StatelessWidget {
  const Initial({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        List<Widget> wikis = List.empty();

        for (var i = 0; i < state.wikis.length; i++) {
          final wiki = state.wikis[i];

          wikis.add(WikiItem(wiki: wiki));
        }
        return Column(
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
                        onPressed: () => {}, icon: const Icon(Icons.send))
                  ],
                  onSubmitted: (value) {
                    context.read<HomeBloc>().add(HomeQueryEntered(value));
                  },
                ),
              ),
            ),
          ],
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
        Text(wiki.title),
        Text(wiki.summary ?? ""),
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
      title: Text(
        "Wikigen",
        style: theme.textTheme.titleLarge
            ?.copyWith(color: theme.colorScheme.onSurface),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
