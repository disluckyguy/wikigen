import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wiki_repository/wiki_repository.dart';
import 'package:wikigen/home/domain/app_domain.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

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
  const SectionsExpansionPanelList({required List<Item> data, super.key})
      : _data = data;

  final List<Item> _data;
  @override
  State<SectionsExpansionPanelList> createState() =>
      _SectionsExpansionPanelListState();
}

class _SectionsExpansionPanelListState
    extends State<SectionsExpansionPanelList> {
  _SectionsExpansionPanelListState();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(widget._data),
      ),
    );
  }

  Widget _buildPanel(List<Item> data) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          data[index].isExpanded = isExpanded;
        });
      },
      children: data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
            title: Column(
              children: [
                MarkdownBody(
                  data: item.expandedValue,
                  styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
                      .copyWith(textScaler: const TextScaler.linear(1.1)),
                ),
              ],
            ),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}

class WikiPage extends ConsumerStatefulWidget {
  const WikiPage({query = "", super.key}) : _query = query;

  final String _query;

  static route(String query, int? localIndex) {
    return MaterialPageRoute(builder: (_) => WikiPage(query: query));
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WikiPageState();
}

class _WikiPageState extends ConsumerState<WikiPage> {
  var isSaved = false;
  @override
  Widget build(BuildContext context) {
    final AsyncValue<Wiki> wiki = ref.watch(WikiProvider(widget._query));
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
            actions: [
              IconButton(
                  onPressed: () async {
                    print(isSaved);
                    if (isSaved) {
                      
                      await ref
                          .read(wikisControllerProvider.notifier)
                          .removeLastWiki();

                          setState(() {
                            isSaved = false;
                          });
                      
                    } else {
                      
                      await ref.read(wikisControllerProvider.notifier).addWiki(value);

                      setState(() {
                        isSaved = true;
                      });
                      
                    }
                  },
                  icon: Icon(isSaved? Icons.bookmark: Icons.bookmark_border))
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(8),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  value.summary,
                  style: theme.textTheme.titleMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    value.introduction,
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
              ),
              const Divider(),
              SectionsExpansionPanelList(data: generateItems(value.sections))
            ],
          ),
        ),
      AsyncError() => Expanded(
            child: Center(
          child: Column(
            children: [
              const Text("Something went wrong :("),
              TextButton.icon(
                onPressed: () {
                  Navigator.of(context).pop(context);
                },
                label: const Text("Go Back"),
                icon: const Icon(Icons.chevron_left),
              )
            ],
          ),
        )),
      _ => const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        )
    };
  }
}

class LocalWikiPage extends ConsumerStatefulWidget {
  const LocalWikiPage({required Wiki wiki, super.key}) : _wiki = wiki;

  final Wiki _wiki;

  static route(Wiki wiki) {
    return MaterialPageRoute(builder: (_) => LocalWikiPage(wiki: wiki,));
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LocalWikiPageState();
}

class _LocalWikiPageState extends ConsumerState<LocalWikiPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        leading: BackButton(
          onPressed: () => {Navigator.of(context).pop()},
        ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget._wiki.title,
            style: theme.textTheme.titleLarge
                ?.copyWith(color: theme.colorScheme.onSurface),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                
                await ref
                    .read(wikisControllerProvider.notifier)
                    .removeWiki(widget._wiki.id);
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.bookmark))
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget._wiki.summary,
              style: theme.textTheme.titleMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget._wiki.introduction,
                style: theme.textTheme.bodyLarge,
              ),
            ),
          ),
          const Divider(),
          SectionsExpansionPanelList(data: generateItems(widget._wiki.sections))
        ],
      ),
    );
  }
}
