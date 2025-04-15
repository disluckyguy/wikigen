import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wiki_repository/wiki_repository.dart';
import 'package:wikigen/home/domain/app_domain.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
  });

  String expandedValue;
  String headerValue;
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
  const SectionsExpansionPanelList(this.data, {super.key});

  final List<Item> data;

  @override
  State<SectionsExpansionPanelList> createState() =>
      _SectionsExpansionPanelListState();
}

class _SectionsExpansionPanelListState
    extends State<SectionsExpansionPanelList> {
  var expantionData = List<bool>.empty(growable: true);
  @override
  Widget build(BuildContext context) {
    if (expantionData.isEmpty) {
      setState(() {
        expantionData = List.filled(widget.data.length, false);
      });
    }
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(context, widget.data, expantionData, (index, value) {
          setState(() {
            expantionData[index] = value;
          });
        }),
      ),
    );
  }

  Widget _buildPanel(BuildContext context, List<Item> data,
      List<bool> expantionData, Function(int, bool) expantionCallback) {
    final theme = Theme.of(context);
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) =>
          expantionCallback(index, isExpanded),
      children: data
          .asMap()
          .map((int index, Item item) {
            return MapEntry(
                index,
                ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text(item.headerValue, style: theme.textTheme.titleLarge,),
                    );
                  },
                  body: ListTile(
                    title: Column(
                      children: [
                        MarkdownBody(
                          data: item.expandedValue,
                          styleSheet:
                              MarkdownStyleSheet.fromTheme(Theme.of(context))
                                  .copyWith(
                                      textScaler: const TextScaler.linear(1.3)),
                        ),
                      ],
                    ),
                  ),
                  isExpanded: expantionData[index],
                ));
          })
          .values
          .toList(),
    );
  }
}

class WikiPage extends ConsumerWidget {
  const WikiPage({required this.query, required this.apiKey, super.key});

  final String query;
  final String apiKey;

  static route(String query, String apiKey, int? localIndex) {
    return MaterialPageRoute(
        builder: (_) => WikiPage(
              query: query,
              apiKey: apiKey,
            ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Wiki> wiki = ref.watch(WikiProvider(query, apiKey));
    final theme = Theme.of(context);
    return switch (wiki) {
      AsyncData(:final value) => Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            leading: BackButton(
              onPressed: () => {Navigator.of(context).pop()},
            ),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                value.title,
                style: theme.textTheme.titleLarge
                    ?.copyWith(color: theme.colorScheme.onSurface),
              ),
            ),
            actions: [BookmarkButton(wiki: wiki.value)],
          ),
          body: ListView(
            padding: const EdgeInsets.all(8),
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  value.summary,
                  style: theme.textTheme.titleLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    value.introduction,
                    style: theme.textTheme.bodyLarge?.copyWith(fontSize: 20),
                  ),
                ),
              ),
              const Divider(),
              SectionsExpansionPanelList(
                generateItems(value.sections),
              )
            ],
          ),
        ),
      AsyncError(:final error) => ErrorPage(error: error.toString()),
      _ => const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        )
    };
  }
}

class LocalWikiPage extends ConsumerWidget {
  const LocalWikiPage({super.key, required this.id});

  static route(int id) {
    return MaterialPageRoute(builder: (BuildContext context) {
      return LocalWikiPage(id: id);
    });
  }

  final int id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final AsyncValue<Wiki> wiki = ref.watch(LocalWikiProvider(id));

    return switch (wiki) {
      AsyncData(:final value) => Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            leading: BackButton(
              onPressed: () => {Navigator.of(context).pop()},
            ),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                value.title,
                style: theme.textTheme.titleLarge
                    ?.copyWith(color: theme.colorScheme.onSurface),
              ),
            ),
            actions: [
              BookmarkButton(
                wiki: value,
                isSaved: true,
              )
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(8),
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  value.summary,
                  style: theme.textTheme.titleLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    value.introduction,
                    style: theme.textTheme.bodyLarge?.copyWith(fontSize: 20),
                  ),
                ),
              ),
              const Divider(),
              SectionsExpansionPanelList(generateItems(value.sections))
            ],
          ),
        ),
      AsyncError(:final error) => ErrorPage(error: error.toString()),
      _ => const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        )
    };
  }
}


// ignore: must_be_immutable
class BookmarkButton extends ConsumerStatefulWidget {
  BookmarkButton({super.key, required Wiki wiki, bool isSaved = false}) : _wiki = wiki, _isSaved = isSaved;

  final Wiki _wiki;
  bool _isSaved;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends ConsumerState<BookmarkButton> {
  @override
  Widget build(BuildContext context) {
    final messenger = ScaffoldMessenger.of(context);
    return IconButton(
      onPressed: () async {
        if (widget._isSaved) {
          messenger.clearSnackBars();
          messenger.showSnackBar(bookmarkSnackbar("Bookmark Removed"));
          setState(() {
            widget._isSaved = false;
          });
          await ref
              .read(wikisControllerProvider.notifier)
              .removeWiki(widget._wiki.id);
        } else {
          messenger.clearSnackBars();
          messenger.showSnackBar(bookmarkSnackbar("Bookmark Added"));
          setState(() {
            widget._isSaved = true;
          });
          await ref
              .read(wikisControllerProvider.notifier)
              .addWiki(widget._wiki, widget._wiki.id);
        }
      },
      icon: Icon(
          widget._isSaved ? Icons.bookmark_rounded : Icons.bookmark_outline_rounded),
    );
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, required this.error});

  final String error;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 128,
              color: theme.colorScheme.error,
            ),
            Text(
              "Error: ${error.toString()}",
              style: theme.textTheme.titleLarge,
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.of(context).pop(context);
              },
              label: const Text("Go Back"),
              icon: const Icon(Icons.chevron_left),
            )
          ],
        ),
      ),
    );
  }
}

SnackBar bookmarkSnackbar(String text) {
  return SnackBar(
    content: Text(text),
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(4),
    padding: const EdgeInsets.all(8),
    showCloseIcon: true,
  );
}
