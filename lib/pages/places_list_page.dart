import 'package:flutter/material.dart';

import 'package:flutter_great_places/providers/great_place_provider.dart';
import 'package:flutter_great_places/routes/app_routes.dart';
import 'package:provider/provider.dart';

class PlacesListPage extends StatelessWidget {
  const PlacesListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        toolbarHeight: 30,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                Text(
                  'Meus Lugares',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Seus lugares preferidos aqui. Explore novos lugares e registre aqui por onde foi se aventurando!',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              // listen false pois o FutureBuilder que vai monitorar para saber se a árvore vai renderizar
              future: Provider.of<GreatPlaceProvider>(context, listen: false)
                  .loadPlaces(),
              builder: (context, snapshot) => snapshot.connectionState ==
                      ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Consumer<GreatPlaceProvider>(
                      builder: (context, places, child) {
                        if (places.itemsCount == 0) {
                          return child!;
                        } else {
                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: places.itemsCount,
                            itemBuilder: (context, index) => Container(
                              // padding: const EdgeInsets.all(4),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Material(
                                color: Colors.amber.shade50,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () {},
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: FileImage(
                                          // Widget FileImage para  decodificar a file image
                                          places.itemByIndex(index).image,
                                        ),
                                      ),
                                      title:
                                          Text(places.itemByIndex(index).title),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                      // essa child vai ser só mostrada quando não tivermos lugares cadastrados
                      child: const Center(
                        child: Text('Nenhuma lugar cadastrado ainda ;('),
                      ),
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(AppRoutes.PLACE_FORM),
        isExtended: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Icon(
          Icons.place,
          color: Colors.black,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
